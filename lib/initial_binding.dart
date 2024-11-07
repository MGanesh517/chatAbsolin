import 'package:get/get.dart';
import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatController>(ChatController(), permanent: true);
  }
}
