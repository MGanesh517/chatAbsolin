import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';


class MuteChatDialog extends StatelessWidget {
  // final UserDetails? otherUser;
  final String? chatId;
  MuteChatDialog({Key? key, this.chatId}) : super(key: key);

  final controller = Get.put(ChatController());
  // final masterController = Get.put(MasterController());
  Future<bool> _willPopCallback() async {
    Get.back();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    // var commonService = CommonService.instance;
    // print("Staff Details${masterController.staffDetails.toJson()}");
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
            contentPadding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
            title: Text("Mute notifications",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            content: Wrap(
              children: [
                Center(
                  child: Text("No one else in this chat will see that you muted it, and you will be still notified if you are mentioned",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Theme.of(context).colorScheme.onSurface)),
                ),
                const Divider(),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: 85,
                    height: 35,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).colorScheme.primary,
                    highlightColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Get.back();
                      controller.muteUnmuteChat(chatId, true);
                    },
                    child: Text(
                      "Mute",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 85,
                    height: 35,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).disabledColor,
                    highlightColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              )
            ]);
      }),
    );
  }
}
