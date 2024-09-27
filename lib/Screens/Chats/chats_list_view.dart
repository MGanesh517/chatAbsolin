import 'package:chatnew/CommonComponents/common_chat_list_card.dart';
import 'package:chatnew/CommonComponents/custom_app_bar.dart';
import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
import 'package:chatnew/Screens/Chats/Model/get_chat_users_list_model.dart';
import 'package:chatnew/Screens/Chats/individual_chat_room_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatListView extends StatefulWidget {

  final Function(int?) onChatSelected;
  const ChatListView({super.key, required this.onChatSelected});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final RefreshController searchRefreshController = RefreshController(initialRefresh: false);
  final RefreshController chatRefreshController = RefreshController(initialRefresh: false);
  final controller = Get.put(ChatController());
  int? selectedChatIndex;
  // bool isLargeScreen = false;
  bool isSearchView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centertitle: false,
        titleChild: const Text('Chat', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
        actionsWidget: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined, color: Colors.white))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: TextFormField(
              controller: controller.searchUsersTextConrtoller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(width: 1, color: Colors.grey)
                ),
                hintText: 'Search',
                prefixIcon: isSearchView
                  ? IconButton(
                      onPressed: () {
                        controller.searchUsersTextConrtoller.clear();
                        controller.getUsersList();
                        setState(() {
                          isSearchView = false;
                        });
                      },
                      icon: const Icon(Icons.arrow_back)
                    )
                  : const Icon(Icons.search),
                suffixIcon: controller.searchUsersTextConrtoller.text.isEmpty
                  ? null
                  : CloseButton(
                      onPressed: () {
                        controller.searchUsersTextConrtoller.clear();
                        controller.isRefresh = true;
                        controller.getUsersList();
                        setState(() {
                          isSearchView = false;
                        });
                      },
                    ),
              ),
              showCursor: isSearchView,
              onTap: () {
                setState(() {
                  isSearchView = true;
                });
              },
              onFieldSubmitted: (val) {
                controller.isRefresh = true;
                controller.getUsersList(search: val);
              },
              onChanged: (value) {
                if (value.isEmpty) {
                  setState(() {
                    isSearchView = false;
                  });
                  controller.isRefresh = true;
                  controller.getUsersList(filter: value);
                } else {
                  setState(() {
                    isSearchView = true;
                  });
                  controller.isRefresh = true;
                  controller.getUsersList(search: value);
                }
              },
            ),
          ),
          Expanded(
            child: isSearchView ? _buildSearchView() : _buildChatListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          // Get.toNamed(Routes.searchChatListView);
        },
        child: const Icon(Icons.add_comment, color: Colors.white,),
      ),
    );
  }


  Widget _buildSearchView() {
    return GetBuilder<ChatController>(
      initState: (_) => ChatController.to.initSearchUsersState(),
      builder: (value) => Obx(
        () => SmartRefresher(
          controller: searchRefreshController,
          enablePullUp: true,
          onRefresh: () async {
            controller.isRefresh = true;
            controller.currentPage = 1;
            final result = await controller.getUsersList();
            if (result) {
              searchRefreshController.resetNoData();
              searchRefreshController.refreshCompleted();
            } else {
              searchRefreshController.refreshFailed();
            }
          },
          onLoading: () async {
            if (controller.totalPages > 1) {
              final result = await controller.getUsersList();
              if (result) {
                if (controller.currentPage > controller.totalPages) {
                  searchRefreshController.loadNoData();
                } else {
                  searchRefreshController.loadComplete();
                }
              } else {
                searchRefreshController.loadNoData();
              }
            } else {
              searchRefreshController.loadNoData();
            }
          },
          child: controller.usersList.isNotEmpty
              ? ListView.separated(
                  itemCount: controller.usersList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
                        child: Text(
                          controller.usersList[index].name?.isNotEmpty == true
                              ? controller.usersList[index].name!.characters.first.toUpperCase()
                              : 'N/A',
                          style: TextStyle(
                            color:  Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      title: Text(
                        controller.usersList[index].name ?? 'N/A',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        controller.startUserChat(controller.usersList[index].id);
                        // _navigateToChatRoom(context);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(color: Colors.grey);
                  },
                )
              : const Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }

 Widget _buildChatListView() {
    return GetBuilder<ChatController>(
      initState: (_) => ChatController.to.initState(),
      builder: (value) => Obx(
        () => FutureBuilder<List<GetUsersChatListData>?>(
          key: controller.futureBuilderKey,
          future: controller.getChatUsersList(search: controller.searchUsersTextConrtoller.text),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Chats Available', style: TextStyle(color: Colors.white)));
            }
            return SmartRefresher(
              controller: chatRefreshController,
              enablePullUp: true,
              onRefresh: () async {
                controller.userChatIsRefresh = true;
                controller.userChatCurrentPage = 1;
                final result = await controller.getChatUsersList();
                if (result != null && result.isNotEmpty) {
                  chatRefreshController.resetNoData();
                  chatRefreshController.refreshCompleted();
                } else {
                  chatRefreshController.refreshFailed();
                }
              },
              onLoading: () async {
                if (controller.userChatTotalPages > 1) {
                  final result = await controller.getChatUsersList();
                  if (result != null && result.isNotEmpty) {
                    if (controller.userChatCurrentPage > controller.userChatTotalPages) {
                      chatRefreshController.loadNoData();
                    } else {
                      chatRefreshController.loadComplete();
                    }
                  } else {
                    chatRefreshController.loadNoData();
                  }
                } else {
                  chatRefreshController.loadNoData();
                }
              },
              child: ListView.builder(
                itemCount: controller.userChatList.length,
                itemBuilder: (BuildContext context, int index) {
                  final chat = controller.userChatList[index];
                  return CommonChatCard(
                    backGroundColor: Colors.primaries[index % Colors.primaries.length],
                    chatSeenStatus: chat.lastMessage?.type == 'image' ? 'assets/images/camera.svg' : '',
                    image: 'assets/event.jpeg',
                    time: chat.lastMessage?.createdOn != null
                        ? Jiffy.parseFromDateTime(chat.lastMessage!.createdOn!.toLocal()).fromNow()
                        : 'N/A',
                    title: chat.otherUser?.name ?? chat.groupDetails?.name ?? 'N/A',
                    subTitle: chat.lastMessage?.type == 'image'
                        ? 'Photo'
                        : chat.lastMessage?.message ?? '',
                    btnLink: () {
                      controller.getChatDetails(chat.id);
                      widget.onChatSelected(0);
                      if (MediaQuery.of(context).size.width <= 600) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const IndividualChatRoomView(chatId:0)),
                        );
                      }
                    },
                    msgCount: chat.unreadCount?.toString() ?? '0',
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // void _navigateToChatRoom(BuildContext context) {
  //   if ( MediaQuery.of(context).size.width > 600) {
      
  //   } else {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const IndividualChatRoomView(chatId: 0,)),
  //     );
  //   }
  // }
}
