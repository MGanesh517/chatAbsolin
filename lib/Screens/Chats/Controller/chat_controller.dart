import 'dart:async';
import 'dart:convert';

import 'package:chatnew/CommonComponents/common_services.dart';
import 'package:chatnew/CommonComponents/snack_bar_widget.dart';
import 'package:chatnew/Routes/app_pages.dart';
import 'package:chatnew/Screens/Chats/Model/get_chat_list_model.dart';
import 'package:chatnew/Screens/Chats/Model/get_chat_users_list_model.dart';
import 'package:chatnew/Screens/Chats/Model/get_messages_list_model.dart';
import 'package:chatnew/Screens/Chats/Model/get_users_list_model.dart';
import 'package:chatnew/Screens/Chats/Repo/chat_repo.dart';
import 'package:chatnew/utils/loader_util.dart';
import 'package:chatnew/utils/soket_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get to => Get.find();
  var commonService = CommonService.instance;

  TextEditingController searchUsersTextConrtoller = TextEditingController();

  initSearchUsersState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchUsersTextConrtoller.clear();
      isRefresh = true;
      getChatUsersList();
      // getUsersList();
    });
  }

  final RxInt _currentPage = 1.obs;
  get currentPage => _currentPage.value;
  set currentPage(value) => _currentPage.value = value;

  final RxInt _totalPages = 1.obs;
  get totalPages => _totalPages.value;
  set totalPages(value) => _totalPages.value = value;

  final RxBool _isRefresh = false.obs;
  get isRefresh => _isRefresh.value;
  set isRefresh(value) => _isRefresh.value = value;

  final RxInt _usersListCount = 0.obs;
  get usersListCount => _usersListCount.value;
  set usersListCount(value) => _usersListCount.value = value;

  final _usersList = <GetUsersListData>[].obs;
  List<GetUsersListData> get usersList => _usersList;

  getUsersList({bool isLoading = true, String? filter, String? search}) async {
    if (isRefresh) {
      _usersList.value = <GetUsersListData>[];
      currentPage = 1;
      showLoadingDialog();
    } else {
      if (currentPage > totalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': currentPage,
      'page_size': CommonService.instance.pageSize,
      'search': search,
      // 'start_date':filter,
      // 'end_date': endDate
    };

    try {
      final data = await ChatRepo().getUsersList(filterParams);

      if (data != null) {
        usersListCount = data.data!.count;
        _usersList.value = [...usersList, ...data.data!.users ?? []];
        var seen = <String>{};
        List<GetUsersListData> filtered = _usersList.where((field) => seen.add(field.id!)).toList();
        _usersList.value = filtered;
        isRefresh = false;
        closeLoadingDialog();
        totalPages = (usersListCount / CommonService.instance.pageSize).ceil();
        currentPage++;
        return true;
      } else {
        closeLoadingDialog();
        return false;
      }
    } catch (e) {
      closeLoadingDialog();
      debugPrint("users error: $e");
      return false;
      // rethrow;
    }
  }

  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      userChatIsRefresh = true;
      // getUserChatList();
      SocketUtils.socketLogin();
      await checkBlockStatus();
    });
  }

  final RxInt _userChatCurrentPage = 1.obs;
  get userChatCurrentPage => _userChatCurrentPage.value;
  set userChatCurrentPage(value) => _userChatCurrentPage.value = value;

  final RxInt _userChatTotalPages = 1.obs;
  get userChatTotalPages => _userChatTotalPages.value;
  set userChatTotalPages(value) => _userChatTotalPages.value = value;

  final RxBool _userChatIsRefresh = false.obs;
  get userChatIsRefresh => _userChatIsRefresh.value;
  set userChatIsRefresh(value) => _userChatIsRefresh.value = value;

  final RxInt _userChatListCount = 0.obs;
  get userChatListCount => _userChatListCount.value;
  set userChatListCount(value) => _userChatListCount.value = value;

  final _userChatList = <GetUsersChatListData>[].obs;
  List<GetUsersChatListData> get userChatList => _userChatList;

  getUserChatList({bool isLoading = true, String? filter, String? search, String? endDate}) async {
    if (userChatIsRefresh) {
      _userChatList.value = <GetUsersChatListData>[];
      userChatCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (userChatCurrentPage > userChatTotalPages) {
        return false;
      }
    }
    final filterParams = <String, dynamic>{
      'page': userChatCurrentPage,
      'page_size': CommonService.instance.pageSize,
      'search': search,
      // 'start_date':filter,
      // 'end_date': endDate
    };

    try {
      final data = await ChatRepo().getUserChatList(filterParams);

      if (data != null) {
        userChatListCount = data.data!.count;
        _userChatList.value = [...userChatList, ...data.data!.results ?? []];
        var seen = <String>{};
        List<GetUsersChatListData> filtered = _userChatList.where((field) => seen.add(field.id!)).toList();
        _userChatList.value = filtered;
        userChatIsRefresh = false;
        closeLoadingDialog();
        userChatTotalPages = (userChatListCount / CommonService.instance.pageSize).ceil();
        userChatCurrentPage++;
        update();
        return true;
      } else {
        closeLoadingDialog();
        return false;
      }
    } catch (e) {
      closeLoadingDialog();
      debugPrint("users error: $e");
      // return false;
      rethrow;
    }
  }

  startUserChat(secondUserId) async {
    showLoadingDialog();
    try {
      var data = await ChatRepo().startUserChat({"second_user_id": secondUserId});
      closeLoadingDialog();
      if (data != null) {
        getChatDetails(data['data']['_id']);
        // getChats(data['_id']);

        return true;
      }
    } catch (e) {
      closeLoadingDialog();
      // rethrow;
      // showSnackBar(
      //   title: "Oops..!",
      //   message: e.toString(),
      //   icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
      // );
    }
  }

  TextEditingController messageTextController = TextEditingController();
  final scrollController = ScrollController();
  scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
  sendMessage(chatId) async {
    print('object');
    // showLoadingDialog();
    SocketUtils.socketMsgUpdate(chatId, messageTextController.text.trim());
    chatController.messageTextController.clear();
    // try {
    //   var data = await ChatRepo().sendMessage({"chat": chatId, "message": messageTextConrtoller.text});
    //   // closeLoadingDialog();
    //   if (data != null) {
    //     messagesIsRefresh = true;
    //     getMessagesList(chatId);
    //     messageTextConrtoller.clear();
    //     // Get.toNamed(Routes.individualChatRoomView);
    //
    //     return true;
    //   }
    // } catch (e) {
    //   closeLoadingDialog();
    //   // rethrow;
    //   showSnackBar(
    //     title: "Oops..!",
    //     message: e.toString(),
    //     icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
    //   );
    // }
  }

  acceptInvitation(chatId, bool? acceptStatus) async {
    showLoadingDialog();
    try {
      var data = await ChatRepo().acceptInvitation({"chat_id": chatId, "accept": acceptStatus});
      closeLoadingDialog();
      if (data != null) {
        getChatDetails(chatId, navigation: false);
        update();
        // Get.toNamed(Routes.individualChatRoomView);
        return true;
      }
    } catch (e) {
      closeLoadingDialog();
      // rethrow;
      // showSnackBar(
      //   title: "Oops..!",
      //   message: e.toString(),
      //   icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
      // );
    }
  }

  blockUnBlockChat(chatId, bool? blockStatus) async {
    showLoadingDialog();
    try {
      var data = await ChatRepo().blockUnblockChat({"chatId": chatId, "chatblock": blockStatus});
      closeLoadingDialog();
      if (data != null) {
        // Get.toNamed(Routes.individualChatRoomView);
        getChatDetails(chatId, navigation: false);
        update();
        return true;
      }
    } catch (e) {
      closeLoadingDialog();
      // rethrow;
      // showSnackBar(
      //   title: "Oops..!",
      //   message: e.toString(),
      //   icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
      // );
    }
  }

  muteUnmuteChat(chatId, bool? muteStatus) async {
    showLoadingDialog();
    try {
      var data = await ChatRepo().muteUnMuteChat({"chat_id": chatId, "Mute": muteStatus});
      closeLoadingDialog();
      if (data != null) {
        // Get.toNamed(Routes.individualChatRoomView);
        getChatDetails(chatId, navigation: false);
        update();
        return true;
      }
    } catch (e) {
      closeLoadingDialog();
      // rethrow;
      // showSnackBar(
      //   title: "Oops..!",
      //   message: e.toString(),
      //   icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
      // );
    }
  }
  blockRequest(bool? blockStatus) async {
    showLoadingDialog();
    try {
      var data = await ChatRepo().blockRequest({"block": blockStatus});
      closeLoadingDialog();
      if (data != null) {
        // Get.toNamed(Routes.individualChatRoomView);
        userChatIsRefresh = true;
        getChatUsersList();
        checkBlockStatus();
        update();
        return true;
      }
    } catch (e) {
      closeLoadingDialog();
      // rethrow;
      // showSnackBar(
      //   title: "Oops..!",
      //   message: e.toString(),
      //   icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
      // );
    }
  }



  final _chatDetails = GetChatData().obs;
  GetChatData get chatDetails => _chatDetails.value;
  set chatDetails(value) => _chatDetails.value = value;

  getChatDetails(String? chatId,
  {bool? navigation = true}
  ) async {
    print('chat details are $chatId');
    showLoadingDialog();
    try {
      closeLoadingDialog();
      final data = await ChatRepo().getChatDetails(chatId);

      if (data != null) {
        _chatDetails.value = data;
        print('chat details are ${jsonEncode(chatDetails)}');
        closeLoadingDialog();
        messagesIsRefresh = true;
      await  getChats(chatDetails.data!.chat!.id);
        
        // navigation == true ? await Get.toNamed(Routes.individualChatRoomView) : null;
        if(chatDetails.data!.unreadCount! > 0){
          print("Into Count Function");
          SocketUtils.socketReadMessage(chatDetails.data!.chat!.id,messagesList.last.id);
          print("Into Count Function 202020202020");
          _userChatList.value.forEach((element) {
            if(element.otherUser!.id == chatDetails.data!.chat!.otherUser!.id){
              element.unreadCount = 0;
            }
          });
          
        }
        print("Print Unread Count::::::${chatDetails.data!.unreadCount}");
  update();
      } else {
        showSnackBar(
          title: "Oops..!",
          message: 'Something went wrong, please try again after some time',
          icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
        );
      }
      update();
    } catch (e) {
      closeLoadingDialog();
      debugPrint("users error: $e");
      // return false;
      rethrow;
    }
  }

  final RxString _chatId = ''.obs;
  get chatId => _chatId.value;
  set chatId(value) => _chatId.value = value;

  initMessagesState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messagesIsRefresh = true;
      getChatDetails(chatId);
      // getUserChatList();
    });
  }

  final RxInt _messagesCurrentPage = 1.obs;
  get messagesCurrentPage => _messagesCurrentPage.value;
  set messagesCurrentPage(value) => _messagesCurrentPage.value = value;

  final RxInt _messagesTotalPages = 1.obs;
  get messagesTotalPages => _messagesTotalPages.value;
  set messagesTotalPages(value) => _messagesTotalPages.value = value;

  final RxBool _messagesIsRefresh = false.obs;
  get messagesIsRefresh => _messagesIsRefresh.value;
  set messagesIsRefresh(value) => _messagesIsRefresh.value = value;

  final RxInt _messagesListCount = 0.obs;
  get messagesListCount => _messagesListCount.value;
  set messagesListCount(value) => _messagesListCount.value = value;

  final _messagesList = <GetMessagesListData>[].obs;
  List<GetMessagesListData> get messagesList => _messagesList;

  Future<List<GetMessagesListData>?>getChats(
      chatId, {
        bool isLoading = true,
        String? filter,
      }) async {
    if (messagesIsRefresh) {
      _messagesList.value = <GetMessagesListData>[];
      messagesCurrentPage = 1;
      // showLoadingDialog();
    } else {
      if (messagesCurrentPage > messagesTotalPages) {
        return _messagesList.value;
      }
    }
    final filterParams = <String, dynamic>{
      'page': messagesCurrentPage,
      'page_size': CommonService.instance.pageSize,
      'sortOrder': "desc",
      // 'start_date':filter,
      // 'end_date': endDate
    };

    try {
      final data = await ChatRepo().getMessagesList(chatId, filterParams);

      if (data != null) {
        messagesListCount = data.data!.count;
        _messagesList.value = [...messagesList, ...data.data!.results ?? []];
        var seen = <String>{};
        List<GetMessagesListData> filtered = _messagesList.where((field) => seen.add(field.id!)).toList();
        _messagesList.value = filtered;
        messagesIsRefresh = false;
        // closeLoadingDialog();
        messagesTotalPages = (messagesListCount / CommonService.instance.pageSize).ceil();
        messagesCurrentPage++;
        return _messagesList.value;
      } else {
        // closeLoadingDialog();
        return _messagesList.value;
      }
    } catch (e) {
      // closeLoadingDialog();
      debugPrint("users error: $e");
      // return false;
      rethrow;
    }
  }
  void onChatMessage(GetMessagesListData msg) {
    _messagesList.value.insert(0,msg);
    update();
    // _messages.add(curr);
  }
  OtherUser otherUser = OtherUser();
  void onChatUserMessage(GetUsersChatListData chat,LastMessage msg) async{
    // otherUser = OtherUser();
    GetUsersChatListData chatUserData = _userChatList.firstWhere((element) => element.id == chat.id);
    print("KSBHBHFHDBVHBH UnreadCount::::::${chatUserData.unreadCount}");

    if(_userChatList.value.contains(_userChatList.firstWhere((element) => element.id == chat.id))){
      otherUser = chatUserData.otherUser!;
      chat.otherUser = otherUser;
    }else{
      await getChatData(chat.id);
      chat.otherUser = OtherUser.fromJson(socketChatData.data!.chat!.otherUser!.toJson());
    }
    _userChatList.removeWhere((element) => element.id == chat.id);
    chat.lastMessage = msg;
    // if(chat.otherUser!.id == commonService.userId){
    if(Get.routing.current != Routes.individualChatRoomView){
      chat.unreadCount = chatUserData.unreadCount!+1 ;
    }
    // }
    print("Print KDNJJJJG::::::::${chat.unreadCount}");
    print("Printing Json OBJ:::::${chat.toJson()}");
    _userChatList.insert(0,chat);
    update();
    // _messages.add(curr);
  }
  final _socketChatData = GetChatData().obs;
  GetChatData get socketChatData => _socketChatData.value;
  set socketChatData(value) => _socketChatData.value = value;
  getChatData(String? chatId,
  {bool? navigation = true}
  ) async {
    print('chat details are $chatId');
    showLoadingDialog();
    try {
      closeLoadingDialog();
      final data = await ChatRepo().getChatDetails(chatId);

      if (data != null) {
        _socketChatData.value = data;
        otherUser = OtherUser.fromJson(data.data!.chat!.otherUser!.toJson());
        print('chat details are ${jsonEncode(socketChatData)}');
        closeLoadingDialog();
      }
    } catch (e) {
      closeLoadingDialog();
      debugPrint("users error: $e");
      // return false;
      rethrow;
    }
  }
  ValueKey futureBuilderKey =  const ValueKey(0);
  Future<List<GetUsersChatListData>?> getChatUsersList({bool isLoading = true, String? filter, String? search, String? endDate}) async {
    if (userChatIsRefresh) {
      _userChatList.value = <GetUsersChatListData>[];
      userChatCurrentPage = 1;
      showLoadingDialog();
    } else {
      if (userChatCurrentPage > userChatTotalPages) {
        return _userChatList.value;
      }
    }
    final filterParams = <String, dynamic>{
      'page': userChatCurrentPage,
      'page_size': CommonService.instance.pageSize,
      'search': search,
      // 'start_date':filter,
      // 'end_date': endDate
    };
print('bgdhfgdsufhudshu :::$filterParams');
    try {
      final data = await ChatRepo().getUserChatList(filterParams);

      if (data != null) {
        userChatListCount = data.data!.count;
        _userChatList.value = [...userChatList, ...data.data!.results ?? []];
        var seen = <String>{};
        
        List<GetUsersChatListData> filtered = _userChatList.where((field) => seen.add(field.id!)).toList();
        _userChatList.value = filtered;
        userChatIsRefresh = false;
        closeLoadingDialog();
        userChatTotalPages = (userChatListCount / CommonService.instance.pageSize).ceil();
        userChatCurrentPage++;
        update();
        return _userChatList.value;
      } else {
        closeLoadingDialog();
        return _userChatList.value;
      }
    } catch (e) {
      closeLoadingDialog();
      debugPrint("users error: $e");
      // return false;
      rethrow;
    }
  }
  final RxBool _blockStatus = false.obs;
  get blockStatus => _blockStatus.value;
  set blockStatus(value) => _blockStatus.value = value;
  checkBlockStatus() async {
    showLoadingDialog();
    try {
      var data = await ChatRepo().checkBlockStatus();
      closeLoadingDialog();
      if (data != null) {
        print("Prin block STatus ::::$data");
        blockStatus = data['data'];
        update();
        // getChats(data['_id']);

        return true;
      }
    } catch (e) {
      closeLoadingDialog();
      // rethrow;
      // showSnackBar(
      //   title: "Oops..!",
      //   message: e.toString(),
      //   icon: Icon(Icons.close, color: Get.theme.colorScheme.error),
      // );
    }
  }

  final RxBool _isTyping = false.obs;
  get isTyping => _isTyping.value;
  set isTyping(value) => _isTyping.value = value;
}

class ChatService extends GetxService {
  // final _messages = StreamController<List<GetMessagesListData>>();
  final _messagesList = <GetMessagesListData>[];
  List<GetMessagesListData> get messagesList => _messagesList;

  // Stream get chatMessageStream => _messages.stream;

  void onChatMessage(GetMessagesListData msg) {

    messagesList.add(msg);
    // _messages.add(curr);
  }
}
