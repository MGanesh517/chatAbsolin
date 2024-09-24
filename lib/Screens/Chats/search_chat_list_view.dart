
// import 'package:chatnew/CommonComponents/custom_app_bar.dart';
// import 'package:chatnew/CommonComponents/gradient_containers.dart';
// import 'package:chatnew/Routes/app_pages.dart';
// import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
// import 'package:expand_tap_area/expand_tap_area.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class SearchChatListView extends StatefulWidget {
//   final Function onClose;

//   const SearchChatListView({Key? key, required this.onClose}) : super(key: key);

//   @override
//   State<SearchChatListView> createState() => _SearchChatListViewState();
// }

// class _SearchChatListViewState extends State<SearchChatListView> {
//   final controller = Get.put(ChatController());
//   final RefreshController refreshController = RefreshController(initialRefresh: false);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         titleChild: Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Theme.of(context).colorScheme.secondary.withOpacity(0.8)),
//           child: ListTile(
//             leading: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               // child: SvgPicture.asset('assets/images/arrowLeft.svg'),
//               child: const Icon(Icons.arrow_back_ios),
//             ),
//             title: TextFormField(
//               controller: controller.searchUsersTextConrtoller,
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search',
//               ),
//               onFieldSubmitted: (val) {
//                 controller.isRefresh = true;
//                 controller.getUsersList(search: val);
//               },
//               onChanged: (value) {
//                 if (value.isEmpty) {
//                   controller.isRefresh = true;
//                   controller.getUsersList(filter: value);
//                   // controller.directSaleQuotationTextFieldsValidation();
//                 }
//               },
//             ),
//             trailing: controller.searchUsersTextConrtoller.text.isEmpty
//                 ? null
//                 : CloseButton(
//                     onPressed: () {
//                       controller.searchUsersTextConrtoller.clear();
//                       controller.isRefresh = true;
//                       controller.getUsersList();
//                     },
//                   ),
//           ),
//         ),
//       ),
//       body: GetBuilder<ChatController>(
//           initState: (_) => ChatController.to.initSearchUsersState(),
//           builder: (value) => InverseGradientContainer(
//                 child: SafeArea(
//                   child: Stack(children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 20,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 20,
//                         ),
//                         Expanded(
//                             child: Obx(() => (SmartRefresher(
//                                   controller: refreshController,
//                                   enablePullUp: true,
//                                   onRefresh: () async {
//                                     controller.isRefresh = true;
//                                     controller.currentPage = 1;
//                                     final result = await controller.getUsersList();
//                                     if (result) {
//                                       refreshController.resetNoData();
//                                       refreshController.refreshCompleted();
//                                     } else {
//                                       refreshController.refreshFailed();
//                                     }
//                                   },
//                                   onLoading: () async {
//                                     if (controller.totalPages > 1) {
//                                       final result = await controller.getUsersList();
//                                       if (result) {
//                                         if (controller.currentPage > controller.totalPages) {
//                                           refreshController.loadNoData();
//                                         } else {
//                                           refreshController.loadComplete();
//                                         }
//                                       } else {
//                                         refreshController.loadNoData();
//                                       }
//                                     } else {
//                                       refreshController.loadNoData();
//                                     }
//                                   },
//                                   child: controller.usersList.isNotEmpty
//                                       ? ListView.separated(
//                                           // controller: controller.scrollController,

//                                           // padding: const EdgeInsets.only(left: 8, right: 8),
//                                           itemCount: controller.usersList.length,
//                                           shrinkWrap: true,
//                                           itemBuilder: (BuildContext context, int index) {
//                                             return ExpandTapWidget(
//                                               onTap: () {
//                                                 controller.startUserChat(controller.usersList[index].id);
//                                                 // Get.toNamed(Routes.individualChatRoomView);
//                                               },
//                                               tapPadding: const EdgeInsets.all(16),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(left: 16, right: 16),
//                                                 child: Row(
//                                                   children: [
//                                                     CircleAvatar(
//                                                       backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
//                                                       radius: 30,
//                                                       child: Text(
//                                                         controller.usersList[index].name != null && controller.usersList[index].name!.isNotEmpty
//                                                             ? controller.usersList[index].name!.characters.first.toUpperCase()
//                                                             : 'N/A',
//                                                         style: TextStyle(
//                                                           color: Colors.primaries[index % Colors.primaries.length],
//                                                           fontSize: 15,
//                                                           fontWeight: FontWeight.w600,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Container(
//                                                       width: 10,
//                                                     ),
//                                                     Text(
//                                                       controller.usersList[index].name ?? 'N/A',
//                                                       style: TextStyle(
//                                                         color: Theme.of(context).colorScheme.onSurface,
//                                                         fontSize: 15,
//                                                         fontWeight: FontWeight.w600,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           separatorBuilder: (BuildContext context, int index) {
//                                             return const Padding(
//                                               padding: EdgeInsets.only(left: 16.0, right: 16.0),
//                                               child: Divider(),
//                                             );
//                                           },
//                                         )
//                                       : Center(
//                                           child: Text(
//                                             'No data available',
//                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
//                                           ),
//                                         ),
//                                 )))),
//                         Container(
//                           height: 40,
//                         )
//                       ],
//                     ),
//                   ]),
//                 ),
//               )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.toNamed(Routes.ChatListView);
//         },
//         child: const Icon(Icons.list),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';

// // class SearchChatListView extends StatelessWidget {
// //   final Function onClose;

// //   const SearchChatListView({Key? key, required this.onClose}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     final controller = Get.find<ChatController>();

// //     return Column(
// //       children: [
// //         // Container(
// //         //   decoration: BoxDecoration(
// //         //     borderRadius: BorderRadius.circular(25),
// //         //     border: Border.all(width: 1, color: Colors.grey),
// //         //   ),
// //         //   child: TextFormField(
// //         //     controller: controller.searchUsersTextConrtoller,
// //         //     decoration: InputDecoration(
// //         //       border: InputBorder.none,
// //         //       hintText: 'Search Users',
// //         //       prefixIcon: const Icon(Icons.search),
// //         //       contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
// //         //       suffixIcon: IconButton(
// //         //         icon: const Icon(Icons.close),
// //         //         onPressed: () => onClose(),
// //         //       ),
// //         //     ),
// //         //     onChanged: (value) {
// //         //       // Implement search logic here
// //         //     },
// //         //   ),
// //         // ),
// //         // Implement the search results list view here
// //       ],
// //     );
// //   }
// // }