import 'dart:convert';
import 'dart:io';

import 'package:chatnew/Screens/Chats/Model/get_chat_list_model.dart';
import 'package:chatnew/Screens/Chats/Model/get_chat_users_list_model.dart';
import 'package:chatnew/Screens/Chats/Model/get_messages_list_model.dart';
import 'package:chatnew/Screens/Chats/Model/get_users_list_model.dart';
import 'package:chatnew/utils/http_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatRepo {
  Future<GetUsersList?> getUsersList(filterParams) async {
    try {
      var response = await HttpUtils.getIOInstance().get("/chats/userslist", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return GetUsersList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<GetUsersChatList?> getUserChatList(filterParams) async {
    try {
      var response = await HttpUtils.getIOInstance().get("/chats/user_chat_list/", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return GetUsersChatList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  startUserChat(data) async {
    print("printing response ::::: ${jsonEncode(data)}");

    try {
      var response = await HttpUtils.getIOInstance().post("/chats/create_personal_chat", data: jsonEncode(data));
      print("printing response ::::: $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        return response.data;
        // return response.data;
      }

      return null;
    } on DioException catch (e) {
      if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
        throw Exception(e.message);
      } else {
        throw Exception(e.response);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  sendMessage(data) async {
    print("printing response ::::: ${jsonEncode(data)}");

    try {
      var response = await HttpUtils.getIOInstance().post("/chats/createmessage", data: jsonEncode(data));
      print("printing response ::::: $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        return response.data;
        // return response.data;
      }

      return null;
    } on DioException catch (e) {
      if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
        throw Exception(e.message);
      } else {
        throw Exception(e.response);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  acceptInvitation(data) async {
    print("printing response ::::: ${jsonEncode(data)}");

    try {
      var response = await HttpUtils.getIOInstance().post("/chats/chat_accept_reject", data: jsonEncode(data));
      print("printing response ::::: $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        return response.data;
        // return response.data;
      }

      return null;
    } on DioException catch (e) {
      if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
        throw Exception(e.message);
      } else {
        throw Exception(e.response);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  blockUnblockChat(data) async {
    print("printing response ::::: ${jsonEncode(data)}");

    try {
      var response = await HttpUtils.getIOInstance().post("/chats/chat_block_unblock", data: jsonEncode(data));
      print("printing response ::::: $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        return response.data;
        // return response.data;
      }

      return null;
    } on DioException catch (e) {
      if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
        throw Exception(e.message);
      } else {
        throw Exception(e.response);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  muteUnMuteChat(data) async {
    print("printing response ::::: ${jsonEncode(data)}");

    try {
      var response = await HttpUtils.getIOInstance().post("/chats/chat_mute_unmute", data: jsonEncode(data));
      print("printing response ::::: $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        return response.data;
        // return response.data;
      }

      return null;
    } on DioException catch (e) {
      if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
        throw Exception(e.message);
      } else {
        throw Exception(e.response);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  blockRequest(data) async {
    print("printing response ::::: ${jsonEncode(data)}");

    try {
      var response = await HttpUtils.getIOInstance().post("/chats/requestblock_unblock", data: jsonEncode(data));
      print("printing response ::::: $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        return response.data;
        // return response.data;
      }

      return null;
    } on DioException catch (e) {
      if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
        throw Exception(e.message);
      } else {
        throw Exception(e.response);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<GetChatData?> getChatDetails(chatId) async {
    try {
      var response = await HttpUtils.getIOInstance().get("/chats/get_chat_details/$chatId");
      print('responsde fjdshfudgsfsf ::::: $response');

      if (response.statusCode == 200) {
        return GetChatData.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      debugPrint('Print Error Resposne::::::${e.response}');
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  Future<GetMessagesList?> getMessagesList(chatId, filterParams) async {
    print("Filter Params:::::::: $filterParams");
    try {
      var response = await HttpUtils.getIOInstance().get("/chats/messages/$chatId", queryParameters: filterParams);

      if (response.statusCode == 200) {
        return GetMessagesList.fromJson(response.data as Map<String, dynamic>);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }

  checkBlockStatus() async {
    try {
      var response = await HttpUtils.getIOInstance().post(
        "/chats/request_block_status",
      );
      print("printing response ::::: $response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.toString());
        return response.data;
        // return response.data;
      }

      return null;
    } on DioException catch (e) {
      if (e.response!.statusCode == 500 || e.response!.statusCode == 404) {
        throw Exception(e.message);
      } else {
        throw Exception(e.response);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }
}
