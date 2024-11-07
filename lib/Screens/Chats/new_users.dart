// // import 'package:chatnew/CommonComponents/custom_app_bar.dart';
// // import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
// // import 'package:chatnew/Screens/Chats/search_chat_list_view.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:pull_to_refresh/pull_to_refresh.dart';


// // class NewUsers extends StatefulWidget {
// //   const NewUsers({super.key});

// //   @override
// //   State<NewUsers> createState() => _NewUsersState();
// // }

// // class _NewUsersState extends State<NewUsers> {
// //   final RefreshController searchRefreshController = RefreshController(initialRefresh: false);
// //   final controller = Get.put(ChatController());

// // @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     appBar: CustomAppBar(
// //       leadingChild: IconButton(onPressed: () {
// //         Get.back();
// //       }, icon: Icon(Icons.arrow_back)),
// //       centertitle: false,
// //       appBarBGColor: Theme.of(context).colorScheme.primary,
// //       titleChild: const Text(
// //         'New Users List',
// //         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
// //       ),
// //       actionsWidget: [
// //         IconButton(
// //           onPressed: () {},
// //           icon: const Icon(Icons.more_vert_outlined, color: Colors.white),
// //         )
// //       ],
// //     ),
// //     body: SafeArea(
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             // This part of the layout will adjust dynamically
// //             Expanded(
// //               child: MediaQuery.of(context).size.width < 600
// //                 ? SearchChatListView()
// //                 : Dialog(
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: SearchChatListView(),
// //                   ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ),
// //   );
// // }


// //   Widget buildSearchView() {
// //     return GetBuilder<ChatController>(
// //       initState: (_) => ChatController.to.initSearchUsersState(),
// //       builder: (value) => Obx(
// //         () => SmartRefresher(
// //           controller: searchRefreshController,
// //           enablePullUp: true,
// //           onRefresh: () async {
// //             controller.isRefresh = true;
// //             controller.currentPage = 1;
// //             final result = await controller.getUsersList();
// //             if (result) {
// //               searchRefreshController.resetNoData();
// //               searchRefreshController.refreshCompleted();
// //             } else {
// //               searchRefreshController.refreshFailed();
// //             }
// //           },
// //           onLoading: () async {
// //             if (controller.totalPages > 1) {
// //               final result = await controller.getUsersList();
// //               if (result) {
// //                 if (controller.currentPage > controller.totalPages) {
// //                   searchRefreshController.loadNoData();
// //                 } else {
// //                   searchRefreshController.loadComplete();
// //                 }
// //               } else {
// //                 searchRefreshController.loadNoData();
// //               }
// //             } else {
// //               searchRefreshController.loadNoData();
// //             }
// //           },
// //           child: controller.usersList.isNotEmpty
// //               ? ListView.separated(
// //                   itemCount: controller.usersList.length,
// //                   shrinkWrap: true,
// //                   itemBuilder: (BuildContext context, int index) {
// //                     return ListTile(
// //                       leading: CircleAvatar(
// //                         backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
// //                         child: Text(
// //                           controller.usersList[index].name?.isNotEmpty == true
// //                               ? controller.usersList[index].name!.characters.first.toUpperCase()
// //                               : 'N/A',
// //                           style: TextStyle(
// //                             color:  Theme.of(context).colorScheme.primary,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                       ),
// //                       title: Text(
// //                         controller.usersList[index].name ?? 'N/A',
// //                         style: const TextStyle(
// //                           color: Colors.black,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                       onTap: () {
// //                         controller.startUserChat(controller.usersList[index].id);
// //                         // _navigateToChatRoom(context);
// //                       },
// //                     );
// //                   },
// //                   separatorBuilder: (BuildContext context, int index) {
// //                     return const Divider(color: Colors.grey);
// //                   },
// //                 )
// //               : const Center(
// //                   child: Text(
// //                     'No data available',
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //         ),
// //       ),
// //     );
// //   }
// // }



// // new_users_screen.dart
// import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'individual_chat_room_view.dart';

// class NewUsersScreen extends StatefulWidget {
//   final Function(int?)? onChatSelected;
  
//   const NewUsersScreen({
//     Key? key, 
//     this.onChatSelected,
//   }) : super(key: key);

//   @override
//   State<NewUsersScreen> createState() => _NewUsersScreenState();
// }

// class _NewUsersScreenState extends State<NewUsersScreen> {
//   final RefreshController refreshController = RefreshController(initialRefresh: false);
//   final controller = Get.find<ChatController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Chat'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: GetBuilder<ChatController>(
//         initState: (_) => ChatController.to.initSearchUsersState(),
//         builder: (value) => Obx(() => SmartRefresher(
//           controller: refreshController,
//           enablePullUp: true,
//           onRefresh: () async {
//             controller.isRefresh = true;
//             controller.currentPage = 1;
//             final result = await controller.getUsersList();
//             if (result) {
//               refreshController.resetNoData();
//               refreshController.refreshCompleted();
//             } else {
//               refreshController.refreshFailed();
//             }
//           },
//           onLoading: () async {
//             if (controller.totalPages > 1) {
//               final result = await controller.getUsersList();
//               if (result) {
//                 if (controller.currentPage > controller.totalPages) {
//                   refreshController.loadNoData();
//                 } else {
//                   refreshController.loadComplete();
//                 }
//               } else {
//                 refreshController.loadNoData();
//               }
//             } else {
//               refreshController.loadNoData();
//             }
//           },
//           child: controller.usersList.isNotEmpty
//               ? ListView.separated(
//                   itemCount: controller.usersList.length,
//                   shrinkWrap: true,
//                   itemBuilder: (BuildContext context, int index) {
//                     final user = controller.usersList[index];
                    
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
//                         child: Text(
//                           user.name?.isNotEmpty == true
//                               ? user.name!.characters.first.toUpperCase()
//                               : 'N/A',
//                           style: TextStyle(
//                             color: Theme.of(context).colorScheme.primary,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         user.name ?? 'N/A',
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       onTap: () {
//                         controller.getChatDetails(user.id);
//                         widget.onChatSelected?.call(0);
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const IndividualChatRoomView(),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   separatorBuilder: (BuildContext context, int index) {
//                     return const Divider(color: Colors.grey);
//                   },
//                 )
//               : const Center(
//                   child: Text(
//                     'No users available',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//         )),
//       ),
//     );
//   }
// }