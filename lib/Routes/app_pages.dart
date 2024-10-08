import 'package:chatnew/Screens/Chats/chats_list_view.dart';
import 'package:chatnew/Screens/Chats/individual_chat_room_view.dart';
import 'package:chatnew/Screens/Login/login_screen.dart';
import 'package:chatnew/Screens/dashboard_view.dart';
import 'package:chatnew/initial_binding.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.loginView,
      page: () => const LoginView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      binding: InitialBinding(),
    ),
    GetPage(
      name: Routes.dashboardView,
      page: () =>  DashboardView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      binding: InitialBinding(),
    ),
    GetPage(
      name: Routes.chatListView,
      page: () =>  ChatListView(onChatSelected: (p0) {
        
      },),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 300),
      binding: InitialBinding(),
    ),
    GetPage(
      name: Routes.individualChatRoomView,
      page: () => const IndividualChatRoomView(chatId: 0),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      binding: InitialBinding(),
    ),
  ];
}
