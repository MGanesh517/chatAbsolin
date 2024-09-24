import 'dart:convert';

import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
import 'package:chatnew/Screens/Chats/Model/get_messages_list_model.dart';
import 'package:chatnew/utils/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:socket_io_client/socket_io_client.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../CommonComponents/common_services.dart';
import '../Routes/app_pages.dart';
import '../Screens/Chats/Model/get_chat_users_list_model.dart';
final chatController = Get.put(ChatController());
class SocketUtils {
  // ignore: constant_identifier_names
  // static const String SOCKET_BASE_URL = 'ws://192.168.1.42:3000/';
  // static const String SOCKET_BASE_URL = 'ws://144.24.97.26:5001';
  // static const String SOCKET_BASE_URL = 'ws://144.24.97.26:5001';

  static IO.Socket? socket;
  static socketLogin() {
    // IO.Socket? socket;
    socket = IO.io(HttpUtils.API_IO_SERVER_PREFIX, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    if(!socket!.connected){
    socket!.connect();
    }
    print("Print Scoket Connection Status:::::${socket!.connected}");
    socket!.onConnect((_) {
      debugPrint('Connection established');
      debugPrint('Device Id:::::${CommonService.instance.deviceId}');
      socket!.emit('login', {'jwt_token': CommonService.instance.accessToken, 'device_uuid': CommonService.instance.deviceId});
    });
    socket!.on('login_feedback', (data) {
      debugPrint("Getting In Login Event");
      debugPrint("Printing Socket Id:::::::::::::${socket!.id}");
      debugPrint(data);
    });
    socket!.on('typing', (data) {
      debugPrint("Getting In Typing Event");
      debugPrint("Printing Socket Id:::::::::::::${socket!.id}");
      debugPrint("Printing Socket Id:::::::::::::${data['typing']}");
      chatController.isTyping = data['typing'];
    });
    socket!.on('recive_message', (data) {
      debugPrint("Getting In Receive Event");
      debugPrint("Printing Socket Id:::::::::::::${data}");
      debugPrint("Printing Socket Id:::::::::::::${data['message']['chat']}");

      debugPrint("Print MSGS Length:::::::::${chatController.messagesList.length}");
      debugPrint("Print Socket Id:::::::::${socket!.id}");
      debugPrint("Print Socket Message:::::::::${data['message']['message']}");
      debugPrint("Print Socket Type:::::::::${data['message']['type']}");
      debugPrint("Print Socket CreatedOn:::::::::${data['message']['created_on']}");
      LastMessage lastMsg = LastMessage(message: data['message']['message'],createdOn: DateTime.parse(data['message']['created_on']));
      print("Last Message Json::::::${lastMsg.toJson()}");
      chatController.onChatUserMessage(GetUsersChatListData.fromJson(data['chat']),LastMessage.fromJson(lastMsg.toJson()));
      chatController.update();
      if(chatController.chatDetails.data!=null && chatController.chatDetails.data!.chat!.id ==data['chat']['_id'] ){
        chatController.onChatMessage(GetMessagesListData.fromJson(data['message']));
        socketReadMessage(chatController.chatDetails.data!.chat!.id,chatController.messagesList.last.id);
        chatController.update();

      }

      debugPrint("Print MSGS cvngng Length:::::::::${chatController.messagesList.last.message}");

      debugPrint(data);
    });
    socket!.onDisconnect((_) => debugPrint('Connection Disconnection'));
    socket!.onConnectError((err) => debugPrint(err));
    socket!.onError((err) => debugPrint(err));
  }

  static socketLocation(lat, long) {
    // socket = IO.io(HttpUtils.IO_PREFIX, <String, dynamic>{
    //   'autoConnect': true,
    //   'transports': ['websocket'],
    // });
    // socket!.connect();
    // socket!.onConnect((_) {
    //   debugPrint('Connection established');
    //   debugPrint("Socket ID::::: ${socket!.id}");
    if (!socket!.connected) {
      print("Socket Failed");
      socketLogin();
    }
    socket!.emit('update_location', {'lat': lat.toString().substring(0, 9), 'lng': long.toString().substring(0, 9)});
    //   // socket!.emit('login',{ 'access_token':CommonService.instance.accessToken, 'device_uuid': CommonService.instance.deviceId });
    // });
    socket!.on('update_location', (data) {
      debugPrint("Getting In Login Event");
      debugPrint("Printing Socket Id:::::::::::::${socket!.id}");
      debugPrint(data);
    });
  }

  static socketMsgUpdate(chatId, message) {

    // socket = IO.io(HttpUtils.IO_PREFIX, <String, dynamic>{
    //   'autoConnect': true,
    //   'transports': ['websocket'],
    // });
    // socket!.connect();
    // socket!.onConnect((_) {
    //   debugPrint('Connection established');
    //   debugPrint("Socket ID::::: ${socket!.id}");
    debugPrint("Chat Id :::::$chatId");
    debugPrint("Chat Message :::::$message");
    debugPrint("Socket Connect Status  :::::${socket!.connected}");
    if (!socket!.connected) {
      print("Socket Failed");
      socketLogin();
    }
    // socket!.onConnect((_) {
    //   debugPrint('Connection established');
    //   debugPrint('Device Id:::::${CommonService.instance.deviceId}');
    //   socket!.emit('send_message', {'chat_id': chatId, 'message': message});
    // });
    socket!.emit('send_message', {'chat_id': chatId, 'message': message});

    //   // socket!.emit('login',{ 'access_token':CommonService.instance.accessToken, 'device_uuid': CommonService.instance.deviceId });
    // });
    // socket!.on('recive_message', (data) {
    //   debugPrint("Getting In Receive Event");
    //   debugPrint("Printing Socket Id:::::::::::::${data}");
    //   debugPrint("Printing Socket Id:::::::::::::${data['message']['chat']}");
    //
    //   debugPrint("Print MSGS Length:::::::::${chatController.messagesList.length}");
    //   debugPrint("Print Socket Id:::::::::${socket!.id}");
    //   debugPrint("Print Socket Message:::::::::${data['message']['message']}");
    //   debugPrint("Print Socket Type:::::::::${data['message']['type']}");
    //   debugPrint("Print Socket CreatedOn:::::::::${data['message']['created_on']}");
    //   LastMessage lastMsg = LastMessage(message: data['message']['message'],createdOn: DateTime.parse(data['message']['created_on']));
    //   print("Last Message Json::::::${lastMsg.toJson()}");
    //   if(chatController.chatDetails.data!.chat!.id ==data['chat']['_id'] ){
    //     chatController.onChatMessage(GetMessagesListData.fromJson(data['message']));
    //     chatController.messageTextConrtoller.clear();
    //   }
    //   chatController.onChatUserMessage(GetUsersChatListData.fromJson(data['chat']),LastMessage.fromJson(lastMsg.toJson()));
    //   chatController.update();
    //   // chatController.messagesList.add(GetMessagesListData.fromJson(data['message']['chat']));
    //   // chatController.update();
    //
    //   debugPrint("Print MSGS cvngng Length:::::::::${chatController.messagesList.last.message}");
    //
    //   debugPrint(data);
    // });
    socket!.onDisconnect((_) => debugPrint('Connection Disconnection'));
    socket!.onConnectError((err) => debugPrint(err.toString()));
    socket!.onError((err) => debugPrint(err.toString()));
  }

  static socketReadMessage(chatId, messageId) {
    debugPrint("Chat Id :::::$chatId");
    debugPrint("Chat Message :::::$messageId");
    debugPrint("Socket Connect Status  :::::${socket!.connected}");
    if (!socket!.connected) {
      print("Socket Failed");
      socketLogin();
    }
    socket!.emit('read_msg', {'chat': chatId, 'msg_read': messageId});
  }

  static socketTypingEvent(chatId, status) {

    // socket = IO.io(HttpUtils.IO_PREFIX, <String, dynamic>{
    //   'autoConnect': true,
    //   'transports': ['websocket'],
    // });
    // socket!.connect();
    // socket!.onConnect((_) {
    //   debugPrint('Connection established');
    //   debugPrint("Socket ID::::: ${socket!.id}");
    debugPrint("Chat Id :::::$chatId");
    debugPrint("Chat Message :::::$status");
    debugPrint("Socket Connect Status  :::::${socket!.connected}");
    if (!socket!.connected) {
      print("Socket Failed");
      socketLogin();
    }
    // socket!.onConnect((_) {
    //   debugPrint('Connection established');
    //   debugPrint('Device Id:::::${CommonService.instance.deviceId}');
    //   socket!.emit('send_message', {'chat_id': chatId, 'message': message});
    // });
    socket!.emit('typing', {'chat_id': chatId, 'typing': status});

    //   // socket!.emit('login',{ 'access_token':CommonService.instance.accessToken, 'device_uuid': CommonService.instance.deviceId });
    // });
    // socket!.on('recive_message', (data) {
    //   debugPrint("Getting In Receive Event");
    //   debugPrint("Printing Socket Id:::::::::::::${data}");
    //   debugPrint("Printing Socket Id:::::::::::::${data['message']['chat']}");
    //
    //   debugPrint("Print MSGS Length:::::::::${chatController.messagesList.length}");
    //   debugPrint("Print Socket Id:::::::::${socket!.id}");
    //   debugPrint("Print Socket Message:::::::::${data['message']['message']}");
    //   debugPrint("Print Socket Type:::::::::${data['message']['type']}");
    //   debugPrint("Print Socket CreatedOn:::::::::${data['message']['created_on']}");
    //   LastMessage lastMsg = LastMessage(message: data['message']['message'],createdOn: DateTime.parse(data['message']['created_on']));
    //   print("Last Message Json::::::${lastMsg.toJson()}");
    //   if(chatController.chatDetails.data!.chat!.id ==data['chat']['_id'] ){
    //     chatController.onChatMessage(GetMessagesListData.fromJson(data['message']));
    //     chatController.messageTextConrtoller.clear();
    //   }
    //   chatController.onChatUserMessage(GetUsersChatListData.fromJson(data['chat']),LastMessage.fromJson(lastMsg.toJson()));
    //   chatController.update();
    //   // chatController.messagesList.add(GetMessagesListData.fromJson(data['message']['chat']));
    //   // chatController.update();
    //
    //   debugPrint("Print MSGS cvngng Length:::::::::${chatController.messagesList.last.message}");
    //
    //   debugPrint(data);
    // });
  }

  static socketLogout() {
   socket!.disconnect();
  }
}
