
// import 'dart:ffi';

import 'package:chatnew/CommonComponents/common_services.dart';
import 'package:chatnew/CommonComponents/custom_app_bar.dart';
import 'package:chatnew/CommonComponents/gradient_containers.dart';
import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
import 'package:chatnew/utils/photo_view.dart';
import 'package:chatnew/utils/soket_utils.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Model/get_messages_list_model.dart';

class IndividualChatRoomView extends StatefulWidget {
  final String? chatId;
  const IndividualChatRoomView({super.key, this.chatId});

  @override
  State<IndividualChatRoomView> createState() => _IndividualChatRoomViewState();
}

class _IndividualChatRoomViewState extends State<IndividualChatRoomView> {
  
  final controller = Get.put(ChatController());

  // final socket = Get.find<SocketService>();
  final socket = Get.put(ChatService());
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  FocusNode _focusNode = FocusNode();
  bool? isLargeScreen;

  @override
  void initState() {
    super.initState();

    // Add a listener to focus changes
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    // Dispose of the FocusNode when it's no longer needed
    _focusNode.dispose();
    super.dispose();
  }

  // Callback function to handle focus changes
  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
     SocketUtils.socketTypingEvent(controller.chatDetails.data!.chat!.id, true);
    } else {
      SocketUtils.socketTypingEvent(controller.chatDetails.data!.chat!.id, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => InverseGradientContainer(
        child: Scaffold(
        appBar: CustomAppBar(
          // appBarBGColor: Color(0xff202c33),
          leadingChild: MediaQuery.of(context).size.width <= 500 ? const BackButtonIcon() : null,
          leadingLink: () {
            Get.back();
          },
          titleChild: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                radius: 20,
                child: Text(
                  controller.chatDetails.data?.chat!.type == 'group'
                      ? controller.chatDetails.data!.chat!.groupDetails != null
                          ? controller.chatDetails.data!.chat!.groupDetails!.name != null
                              ? controller.chatDetails.data!.chat!.groupDetails!.name!.characters.first.toUpperCase()
                              : 'N/A'
                          : 'N/A'
                      : controller.chatDetails.data?.chat!.otherUser != null
                          ? controller.chatDetails.data!.chat!.otherUser!.name != null
                              ? controller.chatDetails.data!.chat!.otherUser!.name!.characters.isNotEmpty?
                  controller.chatDetails.data!.chat!.otherUser!.name!.characters.first.toUpperCase()
                              : 'N/A'
                          : 'N/A': 'N/A',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 10,
              ),
              Expanded(
                child: Text(
                  controller.chatDetails.data?.chat!.type == 'group'
                      ? controller.chatDetails.data!.chat!.groupDetails != null
                          ? controller.chatDetails.data!.chat!.groupDetails!.name != null
                              ? controller.chatDetails.data!.chat!.groupDetails!.name!
                              : 'N/A'
                          : 'N/A'
                      : controller.chatDetails.data?.chat!.otherUser != null
                          ? controller.chatDetails.data!.chat!.otherUser!.name != null
                              ? controller.chatDetails.data!.chat!.otherUser!.name!
                              : 'N/A'
                          : 'N/A',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              //  DropdownButtonHideUnderline(
              //       child: DropdownButton<String>(
              //         icon: const Icon(
              //           Icons.more_vert_outlined,
              //           size: 24.0,
              //           color: Colors.white,
              //         ),
              //         items: controller.chatDetails.data?.chat!.type == 'group'
              //             ? <String>[controller.chatDetails.data!.muteStatus == true ? 'Unmute' : 'Mute'].map((String value) {
              //                 return DropdownMenuItem<String>(
              //                   value: value,
              //                   child: Text(value),
              //                 );
              //               }).toList()
              //             : <String>[
              //                 controller.chatDetails.data!.muteStatus == true ? 'Unmute' : 'Mute',
              //                 controller.chatDetails.data!.chat!.isBlocked == true ? 'UnBlock' : 'Block'
              //               ].map((String value) {
              //                 return DropdownMenuItem<String>(
              //                   value: value,
              //                   child: Text(value),
              //                 );
              //               }).toList(),
              //         onChanged: (String? val) {
              //           setState(() {
              //             if (val == 'Mute') {
              //               controller.chatDetails.data!.muteStatus == true
              //                   ? controller.muteUnmuteChat(controller.chatDetails.data!.chat!.id, false)
              //                   // ?
              //                   : Get.dialog(MuteChatDialog(
              //                       // otherUser: controller.chatDetails.data!.chat!.otherUser!,
              //                       chatId: controller.chatDetails.data!.chat!.id,
              //                     ));
              //               // Get.dialog(LogoutDialogWidget());
              //             } else if (val == 'Unmute') {
              //               controller.chatDetails.data!.muteStatus == true
              //                   ? controller.muteUnmuteChat(controller.chatDetails.data!.chat!.id, false)
              //                   // ?
              //                   : Get.dialog(MuteChatDialog(
              //                       chatId: controller.chatDetails.data!.chat!.id,
              //                     ));
              //             } else {
              //               controller.chatDetails.data!.chat!.isBlocked == true
              //                   ? Get.dialog(UnBlockChatDialog(
              //                       otherUser: controller.chatDetails.data!.chat!.otherUser!,
              //                       chatId: controller.chatDetails.data!.chat!.id,
              //                     ))
              //                   // ?
              //                   : Get.dialog(BlockChatDialog(
              //                       otherUser: controller.chatDetails.data!.chat!.otherUser!,
              //                       chatId: controller.chatDetails.data!.chat!.id,
              //                     ));
              //               // Get.dialog(DeleteProfileDialogWidget());
              //             }
              //           });
              //         },
              //       ),
              //     )
            ],
          ),
        ),
        body: 
        GetBuilder<ChatController>(
            // initState: (_) => ChatController.to.initMessagesState(),
            builder: (value) => InverseGradientContainer(
                  child: SafeArea(
                    child: Stack(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   height: 20,
                          //   width: MediaQuery.of(context).size.width,
                          //   decoration: BoxDecoration(
                          //     color: Theme.of(context).primaryColor,
                          //     borderRadius: const BorderRadius.only(
                          //       bottomLeft: Radius.circular(20),
                          //       bottomRight: Radius.circular(20),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   height: 20,
                          // ),
                          Expanded(
                              child: Obx(() => (FutureBuilder<List<GetMessagesListData>?>(
                                    future: controller.getChats(controller.chatDetails.data?.chat!.id),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SmartRefresher(
                                          controller: refreshController,
                                          enablePullUp: true,
                                          onRefresh: () async {
                                            controller.messagesIsRefresh = true;
                                            controller.messagesCurrentPage = 1;
                                            final result = await controller.getChats(controller.chatDetails.data!.chat!.id);
                                            if (result != null && result.isNotEmpty) {
                                              refreshController.resetNoData();
                                              refreshController.refreshCompleted();
                                            } else {
                                              refreshController.refreshFailed();
                                            }
                                          },
                                          onLoading: () async {
                                            print("Printing ON On Loading");
                                            if (controller.messagesTotalPages > 1) {
                                              final result = await controller.getChats(controller.chatDetails.data!.chat!.id);
                                              if (result != null && result.isNotEmpty) {
                                                if (controller.messagesCurrentPage > controller.messagesTotalPages) {
                                                  refreshController.loadNoData();
                                                } else {
                                                  refreshController.loadComplete();
                                                }
                                              } else {
                                                refreshController.loadNoData();
                                              }
                                            } else {
                                              refreshController.loadNoData();
                                            }
                                          },
                                          child: ListView.builder(
                                            reverse: true,
                                            controller: controller.scrollController,

                                            // padding: const EdgeInsets.only(left: 8, right: 8),
                                            itemCount: controller.messagesList.length,
                                            // shrinkWrap: true,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Column(
                                                children: [
                                                  controller.messagesList[index].type == 'info'
                                                      ? Container(
                                                          height: 50,
                                                          constraints: BoxConstraints(
                                                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                                                              borderRadius: BorderRadius.circular(12)),
                                                          // child: Expanded(
                                                          //     child: Markdown(
                                                          //   data: controller.messagesList[index].message ?? '',
                                                          // )),
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Align(
                                                            alignment: FractionalOffset.center,
                                                            child: Text(
                                                              controller.messagesList[index].message ?? '',
                                                              overflow: TextOverflow.clip,
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                  const SizedBox(
                                                    height: 05,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: controller.messagesList[index].user!.id == CommonService.instance.userId
                                                        ? MainAxisAlignment.end
                                                        : MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          controller.messagesList[index].user!.id == CommonService.instance.userId
                                                              ? controller.messagesList[index].type != 'info'
                                                                  ? getSenderView(
                                                                      controller.messagesList[index].type == 'image' ? true : false,
                                                                      controller.messagesList[index].type == 'image'
                                                                          ? "http://hpsconnect_io.dev.absol.in/${controller.messagesList[index].file}"
                                                                          : '',
                                                                      controller.messagesList[index].message!,
                                                                      controller.messagesList[index].createdOn != null
                                                                          ? Jiffy.parseFromDateTime(controller.messagesList[index].createdOn!.toLocal())
                                                                              .format(pattern: "do MMM hh:mm a")
                                                                          : 'N/A',
                                                                      ChatBubbleClipper1(type: BubbleType.sendBubble),
                                                                      context)
                                                                  : Container()
                                                              : controller.messagesList[index].type != 'info'
                                                                  ? getReceiverView(
                                                                      controller.messagesList[index].type == 'image' ? true : false,
                                                                      controller.messagesList[index].type == 'image'
                                                                          ? controller.messagesList[index].file != null
                                                                              ? "http://hpsconnect_io.dev.absol.in/${controller.messagesList[index].file}"
                                                                              : ''
                                                                          : '',
                                                                      controller.messagesList[index].message!,
                                                                      controller.messagesList[index].createdOn != null
                                                                          ? Jiffy.parseFromDateTime(controller.messagesList[index].createdOn!.toLocal())
                                                                              .format(pattern: "do MMM'yy hh:mm a")
                                                                          : 'N/A',
                                                                      ChatBubbleClipper1(type: BubbleType.receiverBubble),
                                                                      context)
                                                                  : Container()
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  CommonService.instance.userId != controller.chatDetails.data!.chat!.createdBy!.id &&
                                                          controller.messagesList.length == 1
                                                      ? Container(
                                                          height: 100,
                                                        )
                                                      : Container(
                                                          height: 20,
                                                        )
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Center(child: Text("Getting Server Error"));
                                      }

                                      // By default, show a loading spinner.
                                      return const Center(child: Text("No Conversations Yet"));
                                    },
                                  )))),
                          Container(
                            height: 40,
                          )
                        ],
                      ),
                      Positioned(
                          bottom: 0.0,
                          child: Obx(() => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).colorScheme.secondary,
                            ),
                                // height: 100,
                                width: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width  - 390,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: controller.chatDetails.data?.chat!.type == 'personal'
                                      ? controller.chatDetails.data!.chat!.isBlocked == false
                                          ? controller.chatDetails.data!.chat!.isActive == false
                                              ? CommonService.instance.userId != controller.chatDetails.data!.chat!.createdBy!.id
                                                  ? Column(
                                                      children: [
                                                        Text(
                                                          'Accept message request from ${controller.chatDetails.data!.chat!.otherUser!.name ?? ''}',
                                                          style: TextStyle(
                                                              fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
                                                        ),
                                                        Container(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          'if you accept, they will also be able to chat you',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 12, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                                                        ),
                                                        Container(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            OutlinedButton(
                                                                style: OutlinedButton.styleFrom(
                                                                  foregroundColor: Theme.of(context).colorScheme.primary,
                                                                  minimumSize: Size(MediaQuery.of(context).size.width / 2.5, 50),
                                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                                  side: BorderSide(
                                                                    width: 1.0,
                                                                    color: Theme.of(context).colorScheme.primary,
                                                                  ),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(15),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  controller.acceptInvitation(controller.chatDetails.data!.chat!.id, false);
                                                                },
                                                                child: Text(
                                                                  "Reject",
                                                                  style: TextStyle(
                                                                      fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                                                                )),
                                                            Container(
                                                              width: 30,
                                                            ),
                                                            MaterialButton(
                                                              height: 50,
                                                              minWidth: MediaQuery.of(context).size.width / 2.5,
                                                              elevation: 0.0,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                              color: Theme.of(context).colorScheme.primary,
                                                              highlightColor: Theme.of(context).colorScheme.primary,
                                                              onPressed: () {
                                                                controller.acceptInvitation(controller.chatDetails.data!.chat!.id, true);
                                                              },
                                                              child: Text(
                                                                "Accept",
                                                                style: TextStyle(
                                                                    fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Column(children: [
                                                      Text(
                                                        'Invitation Sent',
                                                        style: TextStyle(
                                                            fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
                                                      ),
                                                      Container(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'You can send more messages after your Invitation has been accepted',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 12, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
                                                      ),
                                                    ])
                                              : Row(
                                                  children: [
                                                    Flexible(
                                                      child: TextFormField(
                                                        controller: controller.messageTextController,
                                                        maxLength: 10000,
                                                        focusNode: _focusNode,
                                                        maxLines: 3,
                                                        minLines: 1,
                                                        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Send message', counterText: ''),
                                                        textInputAction: TextInputAction.send,
                                                        onFieldSubmitted: (value) {
                                                          if (value.trim().isNotEmpty) {
                                                            controller.sendMessage(controller.chatDetails.data!.chat!.id);
                                                            controller.scrollToBottom();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 10,
                                                    ),
                                                    MaterialButton(
                                                        height: 50,
                                                        minWidth: 50,
                                                        elevation: 0.0,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                                        color: Theme.of(context).colorScheme.primary,
                                                        highlightColor: Theme.of(context).colorScheme.primary,
                                                        onPressed: () {
                                                          if (controller.messageTextController.text.trim().isNotEmpty) {
                                                            controller.sendMessage(controller.chatDetails.data!.chat!.id);
                                                            controller.scrollToBottom();
                                                          }
                                                        },
                                                        child: Center(child: Icon(Icons.send_rounded)))
                                                  ],
                                                )
                                          : const Center(
                                              child: Text(
                                                'This user has been blocked by you.',
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                                              ),
                                            )
                                      : Center(
                                          child: Text(
                                            'Only admins can send messages',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
                                          ),
                                        ),
                                ),
                              )))
                    ]),
                  ),
                ))
                )));
  }

  getTitleText(String title) => Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      );

  getSenderView(bool isImage, String image, String message, String time, CustomClipper clipper, BuildContext context) => ChatBubble(
        clipper: clipper,
        elevation: 0.0,
        alignment: Alignment.topRight,
        // margin: const EdgeInsets.only(top: 5),
        // backGroundColor: Theme.of(context).colorScheme.primary,
        backGroundColor: Colors.grey[50], 
        // backGroundColor: Colors.white,
        child: Container(
          constraints: BoxConstraints(
            // maxWidth: MediaQuery.of(context).size.width * 0.7,
            maxWidth: MediaQuery.of(context).size.width < 700 ? MediaQuery.of(context).size.width * 0.7 : MediaQuery.of(context).size.width < 842 ? MediaQuery.of(context).size.width  * 0.6 - 200 : MediaQuery.of(context).size.width > 700 ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width /4
            ),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isImage == true
                  ? image != ''
                      ? GestureDetector(
                          onTap: () {
                            Get.to(
                              PhotoViewPage(
                                photo: image,
                              ),
                              transition: Transition.downToUp,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondaryContainer),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image,
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object? exception, StackTrace? stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: (40),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondaryContainer),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/noImageAvailable.jpeg',
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              )),
                        )
                  : ExpandTapWidget(
                tapPadding: EdgeInsets.all(16),
                    onTap: (){
              Clipboard.setData(ClipboardData(text: message));
              Get.snackbar('Copied!', 'Text copied to clipboard.',
              snackPosition: SnackPosition.BOTTOM);
                    },
                    child: Text(
                        message,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(color: Colors.black),
                      ),
                  ),
              Container(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30,
                  ),
                  Text(
                    time,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      );


      getReceiverView(bool isImage, String image, String message, String time, CustomClipper clipper, BuildContext context) => ChatBubble(
        clipper: clipper,
        backGroundColor: Theme.of(context).colorScheme.primaryContainer,
        // margin: const EdgeInsets.only(top: 5),
        child: Container(
          constraints: isImage?
          BoxConstraints(
            // maxWidth: ,
          )
          :BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width < 700 ? MediaQuery.of(context).size.width * 0.6 : MediaQuery.of(context).size.width < 842 ? MediaQuery.of(context).size.width  * 0.6 - 200 : MediaQuery.of(context).size.width > 700 ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width /4
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isImage == true
                  ? image != ''
                      ? GestureDetector(
                          onTap: () {
                            Get.to(
                              PhotoViewPage(
                                photo: image,
                              ),
                              transition: Transition.downToUp,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondaryContainer),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image,
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object? exception, StackTrace? stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: (40),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondaryContainer),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/noImageAvailable.jpeg',
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              )),
                        )
                        : ExpandTapWidget(
                tapPadding: EdgeInsets.all(16),
                    onTap: (){
              Clipboard.setData(ClipboardData(text: message));
              Get.snackbar('Copied!', 'Text copied to clipboard.',
              snackPosition: SnackPosition.BOTTOM);
                    },
                    child: Text(
                        message,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(color: Colors.black),
                      ),
                  ),
                  // : Text(
                  //     message,
                  //     overflow: TextOverflow.clip,
                  //     style: const TextStyle(color: Colors.black),
                  //   ),
              Container(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30,
                  ),
                  Text(
                    time,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}





// import 'package:chatnew/CommonComponents/block_chat_dialog_widget.dart';
// import 'package:chatnew/CommonComponents/common_services.dart';
// import 'package:chatnew/CommonComponents/custom_app_bar.dart';
// import 'package:chatnew/CommonComponents/gradient_containers.dart';
// import 'package:chatnew/CommonComponents/mute_chat_dailog_widget.dart';
// import 'package:chatnew/CommonComponents/unblock_chat_dialog_widget.dart';
// import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
// import 'package:chatnew/utils/photo_view.dart';
// import 'package:chatnew/utils/soket_utils.dart';
// import 'package:expand_tap_area/expand_tap_area.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_chat_bubble/chat_bubble.dart';
// import 'package:get/get.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:markdown_widget/markdown_widget.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import 'Model/get_messages_list_model.dart';

// class IndividualChatRoomView extends StatefulWidget {
//   const IndividualChatRoomView({Key? key}) : super(key: key);

//   @override
//   State<IndividualChatRoomView> createState() => _IndividualChatRoomViewState();
// }

// class _IndividualChatRoomViewState extends State<IndividualChatRoomView> {
//   final controller = Get.put(ChatController());

//   // final socket = Get.find<SocketService>();
//   final socket = Get.put(ChatService());
//   final RefreshController refreshController = RefreshController(initialRefresh: false);
//   FocusNode _focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();

//     // Add a listener to focus changes
//     _focusNode.addListener(_handleFocusChange);
//   }

//   @override
//   void dispose() {
//     // Dispose of the FocusNode when it's no longer needed
//     _focusNode.dispose();
//     super.dispose();
//   }

//   // Callback function to handle focus changes
//   void _handleFocusChange() {
//     if (_focusNode.hasFocus) {
//       SocketUtils.socketTypingEvent(controller.chatDetails.data!.chat!.id, true);
//     } else {
//       SocketUtils.socketTypingEvent(controller.chatDetails.data!.chat!.id, false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(
//           leadingChild: const BackButtonIcon(),
//           leadingLink: () {
//             Get.back();
//           },
//           titleChild: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//                 radius: 20,
//                 child: Text(
//                   controller.chatDetails.data?.chat!.type == 'group'
//                       ? controller.chatDetails.data!.chat!.groupDetails != null
//                           ? controller.chatDetails.data!.chat!.groupDetails!.name != null
//                               ? controller.chatDetails.data!.chat!.groupDetails!.name!.characters.first.toUpperCase()
//                               : 'N/A'
//                           : 'N/A'
//                       : controller.chatDetails.data?.chat!.otherUser != null
//                           ? controller.chatDetails.data!.chat!.otherUser!.name != null
//                               ? controller.chatDetails.data!.chat!.otherUser!.name!.characters.isNotEmpty
//                                   ? controller.chatDetails.data!.chat!.otherUser!.name!.characters.first.toUpperCase()
//                                   : 'N/A'
//                               : 'N/A'
//                           : 'N/A',
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.primary,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 10,
//               ),
//               Expanded(
//                 child: Text(
//                   controller.chatDetails.data?.chat!.type == 'group'
//                       ? controller.chatDetails.data!.chat!.groupDetails != null
//                           ? controller.chatDetails.data!.chat!.groupDetails!.name != null
//                               ? controller.chatDetails.data!.chat!.groupDetails!.name!
//                               : 'N/A'
//                           : 'N/A'
//                       : controller.chatDetails.data!.chat!.otherUser != null
//                           ? controller.chatDetails.data!.chat!.otherUser!.name != null
//                               ? controller.chatDetails.data!.chat!.otherUser!.name!
//                               : 'N/A'
//                           : 'N/A',
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.secondary,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Obx(() => DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       icon: const Icon(
//                         Icons.more_vert_outlined,
//                         size: 24.0,
//                         color: Colors.white,
//                       ),
//                       items: controller.chatDetails.data!.chat!.type == 'group'
//                           ? <String>[controller.chatDetails.data!.muteStatus == true ? 'Unmute' : 'Mute'].map((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList()
//                           : <String>[
//                               controller.chatDetails.data!.muteStatus == true ? 'Unmute' : 'Mute',
//                               controller.chatDetails.data!.chat!.isBlocked == true ? 'UnBlock' : 'Block'
//                             ].map((String value) {
//                               return DropdownMenuItem<String>(
//                                 value: value,
//                                 child: Text(value),
//                               );
//                             }).toList(),
//                       onChanged: (String? val) {
//                         setState(() {
//                           if (val == 'Mute') {
//                             controller.chatDetails.data!.muteStatus == true
//                                 ? controller.muteUnmuteChat(controller.chatDetails.data!.chat!.id, false)
//                                 // ?
//                                 : Get.dialog(MuteChatDialog(
//                                     // otherUser: controller.chatDetails.data!.chat!.otherUser!,
//                                     chatId: controller.chatDetails.data!.chat!.id,
//                                   ));
//                             // Get.dialog(LogoutDialogWidget());
//                           } else if (val == 'Unmute') {
//                             controller.chatDetails.data!.muteStatus == true
//                                 ? controller.muteUnmuteChat(controller.chatDetails.data!.chat!.id, false)
//                                 // ?
//                                 : Get.dialog(MuteChatDialog(
//                                     chatId: controller.chatDetails.data!.chat!.id,
//                                   ));
//                           } else {
//                             controller.chatDetails.data!.chat!.isBlocked == true
//                                 ? Get.dialog(UnBlockChatDialog(
//                                     otherUser: controller.chatDetails.data!.chat!.otherUser!,
//                                     chatId: controller.chatDetails.data!.chat!.id,
//                                   ))
//                                 // ?
//                                 : Get.dialog(BlockChatDialog(
//                                     otherUser: controller.chatDetails.data!.chat!.otherUser!,
//                                     chatId: controller.chatDetails.data!.chat!.id,
//                                   ));
//                             // Get.dialog(DeleteProfileDialogWidget());
//                           }
//                         });
//                       },
//                     ),
//                   ))
//             ],
//           ),
//         ),
//         body: GetBuilder<ChatController>(
//             // initState: (_) => ChatController.to.initMessagesState(),
//             builder: (value) => InverseGradientContainer(
//                   child: SafeArea(
//                     child: Stack(children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             height: 20,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor,
//                               borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(20),
//                                 bottomRight: Radius.circular(20),
//                               ),
//                             ),
//                           ),
//                           // Container(
//                           //   height: 20,
//                           // ),
//                           Expanded(
//                               child: Obx(() => (FutureBuilder<List<GetMessagesListData>?>(
//                                     future: controller.getChats(controller.chatDetails.data!.chat!.id),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.hasData) {
//                                         return SmartRefresher(
//                                           controller: refreshController,
//                                           enablePullUp: true,
//                                           onRefresh: () async {
//                                             controller.messagesIsRefresh = true;
//                                             controller.messagesCurrentPage = 1;
//                                             final result = await controller.getChats(controller.chatDetails.data!.chat!.id);
//                                             if (result != null && result.isNotEmpty) {
//                                               refreshController.resetNoData();
//                                               refreshController.refreshCompleted();
//                                             } else {
//                                               refreshController.refreshFailed();
//                                             }
//                                           },
//                                           onLoading: () async {
//                                             print("Printing ON On Loading");
//                                             if (controller.messagesTotalPages > 1) {
//                                               final result = await controller.getChats(controller.chatDetails.data!.chat!.id);
//                                               if (result != null && result.isNotEmpty) {
//                                                 if (controller.messagesCurrentPage > controller.messagesTotalPages) {
//                                                   refreshController.loadNoData();
//                                                 } else {
//                                                   refreshController.loadComplete();
//                                                 }
//                                               } else {
//                                                 refreshController.loadNoData();
//                                               }
//                                             } else {
//                                               refreshController.loadNoData();
//                                             }
//                                           },
//                                           child: ListView.builder(
//                                             reverse: true,
//                                             controller: controller.scrollController,

//                                             // padding: const EdgeInsets.only(left: 8, right: 8),
//                                             itemCount: controller.messagesList.length,
//                                             // shrinkWrap: true,
//                                             itemBuilder: (BuildContext context, int index) {
//                                               return Column(
//                                                 children: [
//                                                   controller.messagesList[index].type == 'info'
//                                                       ? Container(
//                                                           height: 50,
//                                                           constraints: BoxConstraints(
//                                                             maxWidth: MediaQuery.of(context).size.width * 0.7,
//                                                           ),
//                                                           decoration: BoxDecoration(
//                                                               color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
//                                                               borderRadius: BorderRadius.circular(12)),
//                                                           // child: Expanded(
//                                                           //     child: Markdown(
//                                                           //   data: controller.messagesList[index].message ?? '',
//                                                           // )),
//                                                           padding: const EdgeInsets.all(8.0),
//                                                           child: Align(
//                                                             alignment: FractionalOffset.center,
//                                                             child: Text(
//                                                               controller.messagesList[index].message ?? '',
//                                                               overflow: TextOverflow.clip,
//                                                               textAlign: TextAlign.center,
//                                                               style: TextStyle(color: Theme.of(context).colorScheme.primary),
//                                                             ),
//                                                           ),
//                                                         )
//                                                       : Container(),
//                                                   const SizedBox(
//                                                     height: 05,
//                                                   ),
//                                                   Row(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     mainAxisAlignment: controller.messagesList[index].user!.dUserId == CommonService.instance.userId
//                                                         ? MainAxisAlignment.end
//                                                         : MainAxisAlignment.start,
//                                                     children: [
//                                                       Column(
//                                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                                         children: [
//                                                           controller.messagesList[index].user!.dUserId == CommonService.instance.userId
//                                                               ? controller.messagesList[index].type != 'info'
//                                                                   ? getSenderView(
//                                                                       controller.messagesList[index].type == 'image' ? true : false,
//                                                                       controller.messagesList[index].type == 'image'
//                                                                           ? "http://hpsconnect_io.dev.absol.in/${controller.messagesList[index].file}"
//                                                                           : '',
//                                                                       controller.messagesList[index].message!,
//                                                                       controller.messagesList[index].createdOn != null
//                                                                           ? Jiffy.parseFromDateTime(controller.messagesList[index].createdOn!.toLocal())
//                                                                               .format(pattern: "do MMM hh:mm a")
//                                                                           : 'N/A',
//                                                                       ChatBubbleClipper1(type: BubbleType.sendBubble),
//                                                                       context)
//                                                                   : Container()
//                                                               : controller.messagesList[index].type != 'info'
//                                                                   ? getReceiverView(
//                                                                       controller.messagesList[index].type == 'image' ? true : false,
//                                                                       controller.messagesList[index].type == 'image'
//                                                                           ? controller.messagesList[index].file != null
//                                                                               ? "http://hpsconnect_io.dev.absol.in/${controller.messagesList[index].file}"
//                                                                               : ''
//                                                                           : '',
//                                                                       controller.messagesList[index].message!,
//                                                                       controller.messagesList[index].createdOn != null
//                                                                           ? Jiffy.parseFromDateTime(controller.messagesList[index].createdOn!.toLocal())
//                                                                               .format(pattern: "do MMM'yy hh:mm a")
//                                                                           : 'N/A',
//                                                                       ChatBubbleClipper1(type: BubbleType.receiverBubble),
//                                                                       context)
//                                                                   : Container()
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   CommonService.instance.userId != controller.chatDetails.data!.chat!.createdBy!.dUserId &&
//                                                           controller.messagesList.length == 1
//                                                       ? Container(
//                                                           height: 100,
//                                                         )
//                                                       : Container(
//                                                           height: 20,
//                                                         )
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         );
//                                       } else if (snapshot.hasError) {
//                                         return const Center(child: Text("Getting Server Error"));
//                                       }

//                                       // By default, show a loading spinner.
//                                       return const Center(child: Text("No Conversations Yet"));
//                                     },
//                                   )))),
//                           Container(
//                             height: 40,
//                           )
//                         ],
//                       ),
//                       Positioned(
//                           bottom: 0.0,
//                           child: Obx(() => Container(
//                                 // height: 100,
//                                 width: MediaQuery.of(context).size.width,
//                                 color: Theme.of(context).colorScheme.secondary,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: controller.chatDetails.data!.chat!.type == 'personal'
//                                       ? controller.chatDetails.data!.chat!.isBlocked == false
//                                           ? controller.chatDetails.data!.chat!.isActive == false
//                                               ? CommonService.instance.userId != controller.chatDetails.data!.chat!.createdBy!.dUserId
//                                                   ? Column(
//                                                       children: [
//                                                         Text(
//                                                           'Accept message request from ${controller.chatDetails.data!.chat!.otherUser!.name ?? ''}',
//                                                           style: TextStyle(
//                                                               fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
//                                                         ),
//                                                         Container(
//                                                           height: 5,
//                                                         ),
//                                                         Text(
//                                                           'if you accept, they will also be able to chat you',
//                                                           textAlign: TextAlign.center,
//                                                           style: TextStyle(
//                                                               fontSize: 12, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
//                                                         ),
//                                                         Container(
//                                                           height: 20,
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment: MainAxisAlignment.center,
//                                                           children: [
//                                                             OutlinedButton(
//                                                                 style: OutlinedButton.styleFrom(
//                                                                   foregroundColor: Theme.of(context).colorScheme.primary,
//                                                                   minimumSize: Size(MediaQuery.of(context).size.width / 2.5, 50),
//                                                                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                                                                   side: BorderSide(
//                                                                     width: 1.0,
//                                                                     color: Theme.of(context).colorScheme.primary,
//                                                                   ),
//                                                                   shape: RoundedRectangleBorder(
//                                                                     borderRadius: BorderRadius.circular(15),
//                                                                   ),
//                                                                 ),
//                                                                 onPressed: () {
//                                                                   controller.acceptInvitation(controller.chatDetails.data!.chat!.id, false);
//                                                                 },
//                                                                 child: Text(
//                                                                   "Reject",
//                                                                   style: TextStyle(
//                                                                       fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
//                                                                 )),
//                                                             Container(
//                                                               width: 30,
//                                                             ),
//                                                             MaterialButton(
//                                                               height: 50,
//                                                               minWidth: MediaQuery.of(context).size.width / 2.5,
//                                                               elevation: 0.0,
//                                                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                                                               color: Theme.of(context).colorScheme.primary,
//                                                               highlightColor: Theme.of(context).colorScheme.primary,
//                                                               onPressed: () {
//                                                                 controller.acceptInvitation(controller.chatDetails.data!.chat!.id, true);
//                                                               },
//                                                               child: Text(
//                                                                 "Accept",
//                                                                 style: TextStyle(
//                                                                     fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
//                                                               ),
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     )
//                                                   : Column(children: [
//                                                       Text(
//                                                         'Invitation Sent',
//                                                         style: TextStyle(
//                                                             fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
//                                                       ),
//                                                       Container(
//                                                         height: 5,
//                                                       ),
//                                                       Text(
//                                                         'You can send more messages after your Invitation has been accepted',
//                                                         textAlign: TextAlign.center,
//                                                         style: TextStyle(
//                                                             fontSize: 12, fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSurface),
//                                                       ),
//                                                     ])
//                                               : Row(
//                                                   children: [
//                                                     Flexible(
//                                                       child: TextFormField(
//                                                         controller: controller.messageTextController,
//                                                         maxLength: 10000,
//                                                         focusNode: _focusNode,
//                                                         maxLines: 5,
//                                                         minLines: 1,
//                                                         decoration: const InputDecoration(border: InputBorder.none, hintText: 'Send message', counterText: ''),
//                                                         textInputAction: TextInputAction.send,
//                                                         onFieldSubmitted: (value) {
//                                                           if (value.trim().isNotEmpty) {
//                                                             controller.sendMessage(controller.chatDetails.data!.chat!.id);
//                                                             controller.scrollToBottom();
//                                                           }
//                                                         },
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       width: 10,
//                                                     ),
//                                                     MaterialButton(
//                                                         height: 50,
//                                                         minWidth: 50,
//                                                         elevation: 0.0,
//                                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                                                         color: Theme.of(context).colorScheme.primary,
//                                                         highlightColor: Theme.of(context).colorScheme.primary,
//                                                         onPressed: () {
//                                                           if (controller.messageTextController.text.trim().isNotEmpty) {
//                                                             controller.sendMessage(controller.chatDetails.data!.chat!.id);
//                                                             controller.scrollToBottom();
//                                                           }
//                                                         },
//                                                         child: const Center(child: Icon(Icons.send)))
//                                                   ],
//                                                 )
//                                           : const Center(
//                                               child: Text(
//                                                 'This user has been blocked by you.',
//                                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
//                                               ),
//                                             )
//                                       : Center(
//                                           child: Text(
//                                             'Only admins can send messages',
//                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface),
//                                           ),
//                                         ),
//                                 ),
//                               )))
//                     ]),
//                   ),
//                 )));
//   }

//   getTitleText(String title) => Row(
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
//           ),
//         ],
//       );

//   getSenderView(bool isImage, String image, String message, String time, CustomClipper clipper, BuildContext context) => ChatBubble(
//         clipper: clipper,
//         alignment: Alignment.topRight,
//         // margin: const EdgeInsets.only(top: 5),
//         backGroundColor: Theme.of(context).colorScheme.primary,
//         child: Container(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width * 0.7,
//           ),
//           child: Column(
//             // mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               isImage == true
//                   ? image != ''
//                       ? GestureDetector(
//                           onTap: () {
//                             Get.to(
//                               PhotoViewPage(
//                                 photo: image,
//                               ),
//                               transition: Transition.downToUp,
//                               duration: const Duration(milliseconds: 300),
//                             );
//                           },
//                           child: Container(
//                             height: 100,
//                             width: 100,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondaryContainer),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 image,
//                                 height: double.infinity,
//                                 width: double.infinity,
//                                 alignment: Alignment.center,
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) {
//                                     return child;
//                                   }
//                                   return Center(
//                                     child: CircularProgressIndicator(
//                                       value: loadingProgress.expectedTotalBytes != null
//                                           ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//                                           : null,
//                                     ),
//                                   );
//                                 },
//                                 errorBuilder: (BuildContext context, Object? exception, StackTrace? stackTrace) {
//                                   return const Center(
//                                     child: Icon(
//                                       Icons.broken_image,
//                                       size: (40),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         )
//                       : Container(
//                           height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondaryContainer),
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.asset(
//                                 'assets/noImageAvailable.jpeg',
//                                 height: double.infinity,
//                                 width: double.infinity,
//                                 alignment: Alignment.center,
//                                 fit: BoxFit.cover,
//                               )),
//                         )
//                   : ExpandTapWidget(
//                       tapPadding: EdgeInsets.all(16),
//                       onTap: () {
//                         Clipboard.setData(ClipboardData(text: message));
//                         Get.snackbar('Copied!', 'Text copied to clipboard.', snackPosition: SnackPosition.BOTTOM);
//                       },
//                       // child: Markdown(data: message)
//                       child: Text(
//                         message,
//                         overflow: TextOverflow.clip,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//               Container(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: 30,
//                   ),
//                   Text(
//                     time,
//                     textAlign: TextAlign.right,
//                     textDirection: TextDirection.rtl,
//                     style: const TextStyle(color: Colors.white, fontSize: 10),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );

//   getReceiverView(bool isImage, String image, String message, String time, CustomClipper clipper, BuildContext context) => ChatBubble(
//         clipper: clipper,
//         backGroundColor: Theme.of(context).colorScheme.primaryContainer,
//         // margin: const EdgeInsets.only(top: 5),
//         // padding: const EdgeInsets.only(top:0, bottom: 0 ),
//         child: Container(
//           constraints: isImage
//               ? BoxConstraints(
//                   // maxWidth: MediaQuery.of(context).size.width * 0.8,
//                   )
//               : BoxConstraints(
//                   maxWidth: MediaQuery.of(context).size.width * 0.8,
//                 ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               isImage == true
//                   ? image != ''
//                       ? GestureDetector(
//                           onTap: () {
//                             Get.to(
//                               PhotoViewPage(
//                                 photo: image,
//                               ),
//                               transition: Transition.downToUp,
//                               duration: const Duration(milliseconds: 300),
//                             );
//                           },
//                           child: Container(
//                             height: 100,
//                             width: 100,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondaryContainer),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.network(
//                                 image,
//                                 height: double.infinity,
//                                 width: double.infinity,
//                                 alignment: Alignment.center,
//                                 fit: BoxFit.cover,
//                                 loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) {
//                                     return child;
//                                   }
//                                   return Center(
//                                     child: CircularProgressIndicator(
//                                       value: loadingProgress.expectedTotalBytes != null
//                                           ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//                                           : null,
//                                     ),
//                                   );
//                                 },
//                                 errorBuilder: (BuildContext context, Object? exception, StackTrace? stackTrace) {
//                                   return const Center(
//                                     child: Icon(
//                                       Icons.broken_image,
//                                       size: (40),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         )
//                       : Container(
//                           height: 100,
//                           width: 100,
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).colorScheme.secondaryContainer),
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.asset(
//                                 'assets/noImageAvailable.jpeg',
//                                 height: double.infinity,
//                                 width: double.infinity,
//                                 alignment: Alignment.center,
//                                 fit: BoxFit.cover,
//                               )),
//                         )
//                   :
//                   // Container(
//                   //     // height: 30,
//                   //     child: ),
//                   MarkdownBlock(
//                       data: message,
//                       selectable: true,
//                     ),
//               // Container(
//               //     height: 300,
//               //     child: Expanded(
//               //         child: Markdown(
//               //       data: message,
//               //     )),
//               //   ),
//               // Text(
//               //     message,
//               //     overflow: TextOverflow.clip,
//               //     style: const TextStyle(color: Colors.black),
//               //   ),
//               // Container(
//               //   height: 5,
//               // ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // Container(
//                   //   width: 30,
//                   // ),
//                   Text(
//                     time,
//                     textAlign: TextAlign.right,
//                     textDirection: TextDirection.rtl,
//                     style: const TextStyle(color: Colors.black, fontSize: 10),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
// }
