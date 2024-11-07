

// import 'package:chatnew/CommonComponents/common_chat_list_card.dart';
// import 'package:chatnew/CommonComponents/custom_app_bar.dart';
// import 'package:chatnew/CommonComponents/gradient_containers.dart';
// import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
// import 'package:chatnew/Screens/Chats/Model/get_chat_users_list_model.dart';
// import 'package:chatnew/Screens/Chats/individual_chat_room_view.dart';
// import 'package:expand_tap_area/expand_tap_area.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class ChatListView extends StatefulWidget {
//   const ChatListView({super.key});

//   @override
//   State<ChatListView> createState() => _ChatListViewState();
// }

// class _ChatListViewState extends State<ChatListView> with SingleTickerProviderStateMixin {
//   final RefreshController searchRefreshController = RefreshController(initialRefresh: false);
//   final RefreshController chatRefreshController = RefreshController(initialRefresh: false);
//   final controller = Get.put(ChatController());
//   int? selectedChatIndex;
//   bool? isLargeScreen;
//   bool isSearchView = false;
//   int selectedSectionIndex = 0;
//   TabController? tabController;


//   final List<Map<String, dynamic>> sections = [
//     {'name': 'Calls', 'icon': Icons.call},
//     {'name': 'Chats', 'icon': Icons.chat},
//     {'name': 'Status', 'icon': Icons.camera_alt},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: sections.length, vsync: this);
    
//   }

//   @override
//   void dispose() {
//     tabController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   // backgroundColor: Color(0xff111b21),
//     //       appBar: CustomAppBar(
//     //         centertitle: false,
//     //         appBarBGColor: const Color(0xff111b21),
//     //         titleChild: const Text('Chat',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
//     //         actionsWidget: [
//     //           IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined, color: Colors.white,))
//     //         ],
//     //       ),
//     //   body: SafeArea(
//     //     child: Column(
//     //       children: [
//     //         Padding(
//     //           padding: const EdgeInsets.all(8.0),
//     //           child: TextFormField(
//     //             controller: controller.searchUsersTextConrtoller,
//     //             decoration: InputDecoration(
//     //               border: OutlineInputBorder(
//     //                   borderRadius: BorderRadius.circular(25),
//     //                   borderSide: const BorderSide(width: 1, color: Colors.grey)),
//     //               hintText: 'Search',
//     //               prefixIcon: const Icon(Icons.search),
//     //               suffixIcon: controller.searchUsersTextConrtoller.text.isEmpty
//     //                   ? null
//     //                   : CloseButton(
//     //                       onPressed: () {
//     //                         controller.searchUsersTextConrtoller.clear();
//     //                         controller.isRefresh = true;
//     //                         controller.getUsersList();
//     //                         setState(() {
//     //                           isSearchView = false;
//     //                         });
//     //                       },
//     //                     ),
//     //             ),
//     //             onTap: () {
//     //               setState(() {
//     //                 isSearchView = true;
//     //               });
//     //             },
//     //             onFieldSubmitted: (val) {
//     //               controller.isRefresh = true;
//     //               controller.getUsersList(search: val);
//     //             },
//     //             onChanged: (value) {
//     //               if (value.isEmpty) {
//     //                 setState(() {
//     //                   isSearchView = false;
//     //                 });
//     //                 controller.isRefresh = true;
//     //                 controller.getUsersList(filter: value);
//     //               } else {
//     //                 setState(() {
//     //                   isSearchView = true;
//     //                 });
//     //                 controller.isRefresh = true;
//     //                 controller.getUsersList(search: value);
//     //               }
//     //             },
//     //           ),
//     //         ),
//     //         Expanded(
//     //           child: isSearchView ? _buildSearchView() : _buildChatListView(),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//     return Scaffold(
//       backgroundColor: const Color(0xff202c33),
//       body: SafeArea(
//         bottom: false,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             isLargeScreen = constraints.maxWidth > 600;
            
//             return GradientContainer(
//               child: isLargeScreen!
//                   ? Row(
//                       children: [
//                         // Sidebar
//                         Container(
//                           color: const Color(0xff202c33),
//                           width: 70,
//                           child: ListView.builder(
//                             itemCount: sections.length,
//                             itemBuilder: (context, index) {

//                               final bool isSelected = selectedSectionIndex == index;

//                               return ListTile(
//                                 // tileColor: isSelected
//                                 //     ? Colors.blue.shade100
//                                 //     : Colors.transparent,
//                                 leading: Icon(
//                                   sections[index]['icon'],
//                                   color: isSelected
//                                       ? Colors.white
//                                       : null,
//                                 ),
//                                 onTap: () {
//                                   setState(() {
//                                     selectedSectionIndex = index;
//                                   });
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                         const VerticalDivider(width: 1),
                        
//                         Expanded(
//                           flex: 3,
//                           child: buildMainContentForSection(selectedSectionIndex),
//                         ),
                        
//                         const VerticalDivider(width: 1),

//                         Expanded(
//                           flex: 4,
//                           child: selectedChatIndex == null
//                               ? const Center(
//                                   child: Text(
//                                     'Select a chat',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 23),
//                                   ),
//                                 )
//                               : const IndividualChatRoomView(),
//                         ),
//                       ],
//                     )
//                   : Column(
//                       children: [
//                         TabBar(
//                           controller: tabController,
//                           tabs: sections
//                               .map((section) => Tab(
//                                     icon: Icon(section['icon'] as IconData),
//                                     // text: section['name'] as String,
//                                   ))
//                               .toList(),
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             controller: tabController,
//                             children: [
//                               const Center(child: Text('Calls Screen')),
//                               buildMainContentForSection(1), // Chats
//                               const Center(child: Text('Status Screen')),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildMainContentForSection(int index) {
//     switch (index) {
//       case 0:
//         return  Container(
//           color: const Color(0xff111b21),
//           child: Column(
//           children: [
//             CustomAppBar(
//           centertitle: false,
//           appBarBGColor: const Color(0xff111b21),
//           titleChild: const Text('Calls',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
//           actionsWidget: [
//             IconButton(onPressed: () {}, icon:  Icon(Icons.more_vert_outlined, color: Theme.of(context).colorScheme.secondary,))
//           ],
//         ),
//             const Text('Calls Screen'),
//           ],
//         ));
//       case 1:
//         return _buildMainContent(); // Chats
//       case 2:
//         return  Container(
//           color: const Color(0xff111b21),
//           child: Column(
//           children: [
//             CustomAppBar(
//           centertitle: false,
//           appBarBGColor: const Color(0xff111b21),
//           titleChild: const Text('Status',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
//           actionsWidget: [
//             IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined, color: Colors.white,))
//           ],
//         ),
//             const Text('Status Screen'),
//           ],
//         ));
//       default:
//         return const Center(child: Text('Invalid Selection'));
//     }
//   }

//   Widget _buildMainContent() {
//     return Container(
//           color: const Color(0xff111b21),
//       child: Column(
//         children: [
//           CustomAppBar(
//             centertitle: false,
//             appBarBGColor: const Color(0xff111b21),
//             titleChild: const Text('Chat',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
//             actionsWidget: [
//               IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined, color: Colors.white,))
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: controller.searchUsersTextConrtoller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25),
//                     borderSide: const BorderSide(width: 1, color: Colors.grey)),
//                 hintText: 'Search',
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: controller.searchUsersTextConrtoller.text.isEmpty
//                     ? null
//                     : CloseButton(
//                         onPressed: () {
//                           controller.searchUsersTextConrtoller.clear();
//                           controller.isRefresh = true;
//                           controller.getUsersList();
//                           setState(() {
//                             isSearchView = false;
//                           });
//                         },
//                       ),
//               ),
//               onTap: () {
//                 setState(() {
//                   isSearchView = true;
//                 });
//               },
//               onFieldSubmitted: (val) {
//                 controller.isRefresh = true;
//                 controller.getUsersList(search: val);
//               },
//               onChanged: (value) {
//                 if (value.isEmpty) {
//                   setState(() {
//                     isSearchView = false;
//                   });
//                   controller.isRefresh = true;
//                   controller.getUsersList(filter: value);
//                 } else {
//                   setState(() {
//                     isSearchView = true;
//                   });
//                   controller.isRefresh = true;
//                   controller.getUsersList(search: value);
//                 }
//               },
//             ),
//           ),
//           Expanded(
//             child: isSearchView ? _buildSearchView() : _buildChatListView(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchView() {
//     return GetBuilder<ChatController>(
//       initState: (_) => ChatController.to.initSearchUsersState(),
//       builder: (value) => Obx(
//         () => SmartRefresher(
//           controller: searchRefreshController,
//           enablePullUp: true,
//           onRefresh: () async {
//             controller.isRefresh = true;
//             controller.currentPage = 1;
//             final result = await controller.getUsersList();
//             if (result) {
//               searchRefreshController.resetNoData();
//               searchRefreshController.refreshCompleted();
//             } else {
//               searchRefreshController.refreshFailed();
//             }
//           },
//           onLoading: () async {
//             if (controller.totalPages > 1) {
//               final result = await controller.getUsersList();
//               if (result) {
//                 if (controller.currentPage > controller.totalPages) {
//                   searchRefreshController.loadNoData();
//                 } else {
//                   searchRefreshController.loadComplete();
//                 }
//               } else {
//                 searchRefreshController.loadNoData();
//               }
//             } else {
//               searchRefreshController.loadNoData();
//             }
//           },
//           child: controller.usersList.isNotEmpty
//               ? ListView.separated(
//                   itemCount: controller.usersList.length,
//                   shrinkWrap: true,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ExpandTapWidget(
//                       onTap: () {
//                         controller.startUserChat(controller.usersList[index].id);
//                       },
//                       tapPadding: const EdgeInsets.all(16),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               backgroundColor: Colors
//                                   .primaries[index % Colors.primaries.length]
//                                   .shade100,
//                               radius: 30,
//                               child: Text(
//                                 controller.usersList[index].name != null &&
//                                         controller.usersList[index].name!
//                                             .isNotEmpty
//                                     ? controller.usersList[index].name!
//                                         .characters.first
//                                         .toUpperCase()
//                                     : 'N/A',
//                                 style: TextStyle(
//                                   color: Colors
//                                       .primaries[index % Colors.primaries.length],
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               controller.usersList[index].name ?? 'N/A',
//                               style: TextStyle(
//                                 color: Theme.of(context).colorScheme.onSurface,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (BuildContext context, int index) {
//                     return const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Divider(),
//                     );
//                   },
//                 )
//               : Center(
//                   child: Text(
//                     'No data available',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChatListView() {
//     return GetBuilder<ChatController>(
//       initState: (_) => ChatController.to.initState(),
//       builder: (value) => Obx(
//         () => FutureBuilder<List<GetUsersChatListData>?>(
//           key: controller.futureBuilderKey,
//           future: controller.getChatUsersList(
//               search: controller.searchUsersTextConrtoller.text),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return SmartRefresher(
//                 controller: chatRefreshController,
//                 enablePullUp: true,
//                 onRefresh: () async {
//                   controller.userChatIsRefresh = true;
//                   controller.userChatCurrentPage = 1;
//                   final result = await controller.getChatUsersList();
//                   if (result != null && result.isNotEmpty) {
//                     chatRefreshController.resetNoData();
//                     chatRefreshController.refreshCompleted();
//                   } else {
//                     chatRefreshController.refreshFailed();
//                   }
//                 },
//                 onLoading: () async {
//                   if (controller.userChatTotalPages > 1) {
//                     final result = await controller.getChatUsersList();
//                     if (result != null && result.isNotEmpty) {
//                       if (controller.userChatCurrentPage >
//                           controller.userChatTotalPages) {
//                         chatRefreshController.loadNoData();
//                       } else {
//                         chatRefreshController.loadComplete();
//                       }
//                     } else {
//                       chatRefreshController.loadNoData();
//                     }
//                   } else {
//                     chatRefreshController.loadNoData();
//                   }
//                 },
//                 child: snapshot.data!.isNotEmpty
//                     ? ListView.builder(
//                         itemCount: controller.userChatList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return CommonChatCard(
//                                                       backGroundColor: Colors.primaries[index % Colors.primaries.length],
//                                                       chatSeenStatus: controller.userChatList[index].lastMessage != null
//                                                           ? controller.userChatList[index].lastMessage!.type == 'image'
//                                                               ? 'assets/images/camera.svg'
//                                                               : ''
//                                                           : '',
//                                                       image: 'assets/event.jpeg',
//                                                       time: controller.userChatList[index].lastMessage != null
//                                                           ? controller.userChatList[index].lastMessage!.createdOn != null
//                                                               ? Jiffy.parseFromDateTime(snapshot.data![index].lastMessage!.createdOn!.toLocal()).fromNow()
//                                                               : 'N/A'
//                                                           : 'N/A',
//                                                       title: controller.userChatList[index].otherUser != null
//                                                           ? controller.userChatList[index].otherUser!.name ?? 'N/A'
//                                                           : controller.userChatList[index].groupDetails != null
//                                                               ? controller.userChatList[index].groupDetails!.name!
//                                                               : '',
//                                                       subTitle: controller.userChatList[index].lastMessage != null
//                                                           ? controller.userChatList[index].lastMessage!.type == 'image'
//                                                               ? 'Photo'
//                                                               : controller.userChatList[index].lastMessage!.message!
//                                                           : '',
//                                                       btnLink: () async {
//                                                         setState(() {
//                                                           selectedChatIndex = index;
//                                                         });
                                                        
//                                                         controller.getChatDetails(controller.userChatList[index].id);
                                                        
//                                                         if (!isLargeScreen!) {
//                                                           Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(builder: (context) => const IndividualChatRoomView()),
//                                                           );
//                                                         }
//                                                       },
//                                                       msgCount: controller.userChatList[index].unreadCount != null
//                                                           ? controller.userChatList[index].unreadCount.toString()
//                                                           : '0',
//                                                     );
//                         },
//                       )
//                     : Center(
//                         child: Text(
//                           'No Chats Available',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                         ),
//                       ),
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }












// // import 'package:chatnew/CommonComponents/custom_app_bar.dart';
// // import 'package:chatnew/CommonComponents/gradient_containers.dart';
// // import 'package:chatnew/Routes/app_pages.dart';
// // import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
// // import 'package:expand_tap_area/expand_tap_area.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:pull_to_refresh/pull_to_refresh.dart';

// // class SearchChatListView extends StatefulWidget {
// //   final Function onClose;

// //   const SearchChatListView({Key? key, required this.onClose}) : super(key: key);

// //   @override
// //   State<SearchChatListView> createState() => _SearchChatListViewState();
// // }

// // class _SearchChatListViewState extends State<SearchChatListView> {
// //   final controller = Get.put(ChatController());
// //   final RefreshController refreshController = RefreshController(initialRefresh: false);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: CustomAppBar(
// //         titleChild: Container(
// //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Theme.of(context).colorScheme.secondary.withOpacity(0.8)),
// //           child: ListTile(
// //             leading: InkWell(
// //               onTap: () {
// //                 Get.back();
// //               },
// //               // child: SvgPicture.asset('assets/images/arrowLeft.svg'),
// //               child: const Icon(Icons.arrow_back_ios),
// //             ),
// //             title: TextFormField(
// //               controller: controller.searchUsersTextConrtoller,
// //               decoration: const InputDecoration(
// //                 border: InputBorder.none,
// //                 hintText: 'Search',
// //               ),
// //               onFieldSubmitted: (val) {
// //                 controller.isRefresh = true;
// //                 controller.getUsersList(search: val);
// //               },
// //               onChanged: (value) {
// //                 if (value.isEmpty) {
// //                   controller.isRefresh = true;
// //                   controller.getUsersList(filter: value);
// //                   // controller.directSaleQuotationTextFieldsValidation();
// //                 }
// //               },
// //             ),
// //             trailing: controller.searchUsersTextConrtoller.text.isEmpty
// //                 ? null
// //                 : CloseButton(
// //                     onPressed: () {
// //                       controller.searchUsersTextConrtoller.clear();
// //                       controller.isRefresh = true;
// //                       controller.getUsersList();
// //                     },
// //                   ),
// //           ),
// //         ),
// //       ),
// //       body: GetBuilder<ChatController>(
// //           initState: (_) => ChatController.to.initSearchUsersState(),
// //           builder: (value) => InverseGradientContainer(
// //                 child: SafeArea(
// //                   child: Stack(children: [
// //                     Column(
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         Container(
// //                           height: 20,
// //                           width: MediaQuery.of(context).size.width,
// //                           decoration: BoxDecoration(
// //                             color: Theme.of(context).primaryColor,
// //                             borderRadius: const BorderRadius.only(
// //                               bottomLeft: Radius.circular(20),
// //                               bottomRight: Radius.circular(20),
// //                             ),
// //                           ),
// //                         ),
// //                         Container(
// //                           height: 20,
// //                         ),
// //                         Expanded(
// //                             child: Obx(() => (SmartRefresher(
// //                                   controller: refreshController,
// //                                   enablePullUp: true,
// //                                   onRefresh: () async {
// //                                     controller.isRefresh = true;
// //                                     controller.currentPage = 1;
// //                                     final result = await controller.getUsersList();
// //                                     if (result) {
// //                                       refreshController.resetNoData();
// //                                       refreshController.refreshCompleted();
// //                                     } else {
// //                                       refreshController.refreshFailed();
// //                                     }
// //                                   },
// //                                   onLoading: () async {
// //                                     if (controller.totalPages > 1) {
// //                                       final result = await controller.getUsersList();
// //                                       if (result) {
// //                                         if (controller.currentPage > controller.totalPages) {
// //                                           refreshController.loadNoData();
// //                                         } else {
// //                                           refreshController.loadComplete();
// //                                         }
// //                                       } else {
// //                                         refreshController.loadNoData();
// //                                       }
// //                                     } else {
// //                                       refreshController.loadNoData();
// //                                     }
// //                                   },
// //                                   child: controller.usersList.isNotEmpty
// //                                       ? ListView.separated(
// //                                           // controller: controller.scrollController,

// //                                           // padding: const EdgeInsets.only(left: 8, right: 8),
// //                                           itemCount: controller.usersList.length,
// //                                           shrinkWrap: true,
// //                                           itemBuilder: (BuildContext context, int index) {
// //                                             return ExpandTapWidget(
// //                                               onTap: () {
// //                                                 controller.startUserChat(controller.usersList[index].id);
// //                                                 // Get.toNamed(Routes.individualChatRoomView);
// //                                               },
// //                                               tapPadding: const EdgeInsets.all(16),
// //                                               child: Padding(
// //                                                 padding: const EdgeInsets.only(left: 16, right: 16),
// //                                                 child: Row(
// //                                                   children: [
// //                                                     CircleAvatar(
// //                                                       backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
// //                                                       radius: 30,
// //                                                       child: Text(
// //                                                         controller.usersList[index].name != null && controller.usersList[index].name!.isNotEmpty
// //                                                             ? controller.usersList[index].name!.characters.first.toUpperCase()
// //                                                             : 'N/A',
// //                                                         style: TextStyle(
// //                                                           color: Colors.primaries[index % Colors.primaries.length],
// //                                                           fontSize: 15,
// //                                                           fontWeight: FontWeight.w600,
// //                                                         ),
// //                                                       ),
// //                                                     ),
// //                                                     Container(
// //                                                       width: 10,
// //                                                     ),
// //                                                     Text(
// //                                                       controller.usersList[index].name ?? 'N/A',
// //                                                       style: TextStyle(
// //                                                         color: Theme.of(context).colorScheme.onSurface,
// //                                                         fontSize: 15,
// //                                                         fontWeight: FontWeight.w600,
// //                                                       ),
// //                                                     ),
// //                                                   ],
// //                                                 ),
// //                                               ),
// //                                             );
// //                                           },
// //                                           separatorBuilder: (BuildContext context, int index) {
// //                                             return const Padding(
// //                                               padding: EdgeInsets.only(left: 16.0, right: 16.0),
// //                                               child: Divider(),
// //                                             );
// //                                           },
// //                                         )
// //                                       : Center(
// //                                           child: Text(
// //                                             'No data available',
// //                                             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
// //                                           ),
// //                                         ),
// //                                 )))),
// //                         Container(
// //                           height: 40,
// //                         )
// //                       ],
// //                     ),
// //                   ]),
// //                 ),
// //               )),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Get.toNamed(Routes.ChatListView);
// //         },
// //         child: const Icon(Icons.list),
// //       ),
// //     );
// //   }
// // }

// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';

// // // class SearchChatListView extends StatelessWidget {
// // //   final Function onClose;

// // //   const SearchChatListView({Key? key, required this.onClose}) : super(key: key);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final controller = Get.find<ChatController>();

// // //     return Column(
// // //       children: [
// // //         // Container(
// // //         //   decoration: BoxDecoration(
// // //         //     borderRadius: BorderRadius.circular(25),
// // //         //     border: Border.all(width: 1, color: Colors.grey),
// // //         //   ),
// // //         //   child: TextFormField(
// // //         //     controller: controller.searchUsersTextConrtoller,
// // //         //     decoration: InputDecoration(
// // //         //       border: InputBorder.none,
// // //         //       hintText: 'Search Users',
// // //         //       prefixIcon: const Icon(Icons.search),
// // //         //       contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
// // //         //       suffixIcon: IconButton(
// // //         //         icon: const Icon(Icons.close),
// // //         //         onPressed: () => onClose(),
// // //         //       ),
// // //         //     ),
// // //         //     onChanged: (value) {
// // //         //       // Implement search logic here
// // //         //     },
// // //         //   ),
// // //         // ),
// // //         // Implement the search results list view here
// // //       ],
// // //     );
// // //   }
// // // }









// import 'package:chatnew/CommonComponents/common_chat_list_card.dart';
// import 'package:chatnew/CommonComponents/gradient_containers.dart';
// import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
// import 'package:chatnew/Screens/Chats/Model/get_chat_users_list_model.dart';
// import 'package:chatnew/Screens/Chats/individual_chat_room_view.dart';
// import 'package:expand_tap_area/expand_tap_area.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class ChatListView extends StatefulWidget {
//   const ChatListView({super.key});

//   @override
//   State<ChatListView> createState() => _ChatListViewState();
// }

// class _ChatListViewState extends State<ChatListView> with SingleTickerProviderStateMixin {
//   final controller = Get.put(ChatController());
//   final RefreshController searchRefreshController = RefreshController(initialRefresh: false);
//   final RefreshController chatRefreshController = RefreshController(initialRefresh: false);
//   int? selectedChatIndex;
//   bool? isLargeScreen;
//   bool isSearchView = false;
//   int selectedSectionIndex = 0;
//   TabController? tabController;

//   // final List<Map<String, dynamic>> sections = [
//   // {'name': 'Chats', 'icon': Icons.chat},
//   // {'name': 'Calls', 'icon': Icons.call},
//   // {'name': 'Status', 'icon': Icons.camera_alt},
//   //   ];

//   final List<Map<String, dynamic>> sections = [
//   {'name': 'Calls', 'icon': Icons.call},
//   {'name': 'Chats', 'icon': Icons.chat},
//   {'name': 'Status', 'icon': Icons.camera_alt},
// ];

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: sections.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     tabController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.grey,
//       body: SafeArea(
//         bottom: false,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             isLargeScreen = constraints.maxWidth > 600;
            
//             return GradientContainer(
//               child: isLargeScreen!
//                   ? Row(
//                       children: [
//                         // Sidebar
//                         SizedBox(
//                           width: 70,
//                           child: ListView.builder(
//                             itemCount: sections.length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 leading: Icon(sections[index]['icon']),
//                                 selected: selectedSectionIndex == index,
//                                 onTap: () {
//                                   setState(() {
//                                     selectedSectionIndex = index;
//                                   });
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                         const VerticalDivider(width: 2, color: Colors.grey),
//                         // Main content area
//                         Expanded(
//                           flex: MediaQuery.of(context).size.width <= 700 ? 5 : MediaQuery.of(context).size.width <= 1100 ? 3 : 1,
//                           child: _buildMainContent(),
//                         ),
//                         const VerticalDivider(width: 2),
//                         // Chat details area
//                         Expanded(
//                           flex: 4,
//                           child: selectedChatIndex == null
//                               ? const Center(child: Text('Select a chat', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23)))
//                               : const IndividualChatRoomView()
//                         ),
//                       ],
//                     )
//                   : Column(
//                       children: [
//                         // TabBar(
//                         //   controller: tabController,
//                         //   tabs: sections
//                         //       .map((section) => Tab(
//                         //             text: section,
//                         //           ))
//                         //       .toList(),
//                         // ),
//                         TabBar(
//                           // dividerColor: Colors.transparent,
//                           controller: tabController,
//                           tabs: sections
//                             .map((section) => Tab(
//                                   icon: Icon(section['icon'] as IconData),
//                                   text: section['name'] as String,
//                                 ))
//                             .toList(),
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             controller: tabController,
//                             children: [
//                               const Center(child: Text('Calls Screen')),
//                               _buildMainContent(),
//                               const Center(child: Text('Status Screen')),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMainContent() {
//     return Column(
//       children: [
//         //   Visibility(
//         //   // visible: MediaQuery.of(context).size.width > 600,
//         //   child: const CustomAppBar(
//         //     titleChild: Text('ChatList', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23, color: Colors.white)),
//         //   ),
//         // ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextFormField(
//             controller: controller.searchUsersTextConrtoller,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(25),
//                 borderSide: const BorderSide(width: 1,color: Colors.grey)
//               ),
//               hintText: 'Search',
//               prefixIcon: const Icon(Icons.search),
//               suffixIcon: controller.searchUsersTextConrtoller.text.isEmpty
//               ? null
//               : CloseButton(
//                   onPressed: () {
//                     controller.searchUsersTextConrtoller.clear();
//                     controller.isRefresh = true;
//                     controller.getUsersList();
                    
//                     setState(() {
//                       isSearchView = false;
//                     });
//                   },
//                 ),
//             ),
//             onTap: () {
//               setState(() {
//                 isSearchView = true;
//               });
//             },
//             onFieldSubmitted: (val) {
//               controller.isRefresh = true;
//               controller.getUsersList(search: val);
//             },
//             onChanged: (value) {
//               if (value.isEmpty) {
//                 setState(() {
//                   isSearchView = false;
//                 });
//                 controller.isRefresh = true;
//                 controller.getUsersList(filter: value);
//               } else {
//                 setState(() {
//                   isSearchView = true;
//                 });
//                 controller.isRefresh = true;
//                 controller.getUsersList(search: value);
//               }
//             },
//           ),
//         ),
//         Expanded(
//           child: isSearchView
//               ? _buildSearchView()
//               : _buildChatListView(),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchView() {
//     return GetBuilder<ChatController>(
//       initState: (_) => ChatController.to.initSearchUsersState(),
//       builder: (value) => Obx(() => SmartRefresher(
//         controller: searchRefreshController,
//         enablePullUp: true,
//         onRefresh: () async {
//           controller.isRefresh = true;
//           controller.currentPage = 1;
//           final result = await controller.getUsersList();
//           if (result) {
//             searchRefreshController.resetNoData();
//             searchRefreshController.refreshCompleted();
//           } else {
//             searchRefreshController.refreshFailed();
//           }
//         },
//         onLoading: () async {
//           if (controller.totalPages > 1) {
//             final result = await controller.getUsersList();
//             if (result) {
//               if (controller.currentPage > controller.totalPages) {
//                 searchRefreshController.loadNoData();
//               } else {
//                 searchRefreshController.loadComplete();
//               }
//             } else {
//               searchRefreshController.loadNoData();
//             }
//           } else {
//             searchRefreshController.loadNoData();
//           }
//         },
//         child: controller.usersList.isNotEmpty
//             ? ListView.separated(
//                 itemCount: controller.usersList.length,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ExpandTapWidget(
//                     onTap: () {
//                       controller.startUserChat(controller.usersList[index].id);
//                     },
//                     tapPadding: const EdgeInsets.all(16),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 16, right: 16),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
//                             radius: 30,
//                             child: Text(
//                               controller.usersList[index].name != null && controller.usersList[index].name!.isNotEmpty
//                                   ? controller.usersList[index].name!.characters.first.toUpperCase()
//                                   : 'N/A',
//                               style: TextStyle(
//                                 color: Colors.primaries[index % Colors.primaries.length],
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 10,
//                           ),
//                           Text(
//                             controller.usersList[index].name ?? 'N/A',
//                             style: TextStyle(
//                               color: Theme.of(context).colorScheme.onSurface,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) {
//                   return const Padding(
//                     padding: EdgeInsets.only(left: 16.0, right: 16.0),
//                     child: Divider(),
//                   );
//                 },
//               )
//             : Center(
//                 child: Text(
//                   'No data available',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
//                 ),
//               ),
//       ))
//     );
//   }

//   Widget _buildChatListView() {
//     return GetBuilder<ChatController>(
//       initState: (_) => ChatController.to.initState(),
//       builder: (value) => Obx(() => FutureBuilder<List<GetUsersChatListData>?>(
//         key: controller.futureBuilderKey,
//         future: controller.getChatUsersList(search: controller.searchUsersTextConrtoller.text),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return SmartRefresher(
//               controller: chatRefreshController,
//               enablePullUp: true,
//               onRefresh: () async {
//                 controller.userChatIsRefresh = true;
//                 controller.userChatCurrentPage = 1;
//                 final result = await controller.getChatUsersList();
//                 if (result != null && result.isNotEmpty) {
//                   chatRefreshController.resetNoData();
//                   chatRefreshController.refreshCompleted();
//                 } else {
//                   chatRefreshController.refreshFailed();
//                 }
//               },
//               onLoading: () async {
//                 if (controller.userChatTotalPages > 1) {
//                   final result = await controller.getUserChatList();
//                   if (result != null && result.isNotEmpty) {
//                     if (controller.userChatCurrentPage > controller.userChatTotalPages) {
//                       chatRefreshController.loadNoData();
//                     } else {
//                       chatRefreshController.loadComplete();
//                     }
//                   } else {
//                     chatRefreshController.loadNoData();
//                   }
//                 } else {
//                   chatRefreshController.loadNoData();
//                 }
//               },
//               child: snapshot.data!.isNotEmpty
//                   ? ListView.builder(
//                       padding: const EdgeInsets.only(left: 8, right: 8),
//                       itemCount: controller.userChatList.length,
//                       shrinkWrap: true,
//                       itemBuilder: (BuildContext context, int index) {
//                         return CommonChatCard(
//                           backGroundColor: Colors.primaries[index % Colors.primaries.length],
//                           chatSeenStatus: controller.userChatList[index].lastMessage != null
//                               ? controller.userChatList[index].lastMessage!.type == 'image'
//                                   ? 'assets/images/camera.svg'
//                                   : ''
//                               : '',
//                           image: 'assets/event.jpeg',
//                           time: controller.userChatList[index].lastMessage != null
//                               ? controller.userChatList[index].lastMessage!.createdOn != null
//                                   ? Jiffy.parseFromDateTime(snapshot.data![index].lastMessage!.createdOn!.toLocal()).fromNow()
//                                   : 'N/A'
//                               : 'N/A',
//                           title: controller.userChatList[index].otherUser != null
//                               ? controller.userChatList[index].otherUser!.name ?? 'N/A'
//                               : controller.userChatList[index].groupDetails != null
//                                   ? controller.userChatList[index].groupDetails!.name!
//                                   : '',
//                           subTitle: controller.userChatList[index].lastMessage != null
//                               ? controller.userChatList[index].lastMessage!.type == 'image'
//                                   ? 'Photo'
//                                   : controller.userChatList[index].lastMessage!.message!
//                               : '',
//                           btnLink: () async {
//                             setState(() {
//                               selectedChatIndex = index;
//                             });
//                             controller.getChatDetails(controller.userChatList[index].id);
                            
//                             if (!isLargeScreen!) {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => const IndividualChatRoomView()),
//                               );
//                             }
//                           },
//                           msgCount: controller.userChatList[index].unreadCount != null
//                               ? controller.userChatList[index].unreadCount.toString()
//                               : '0',
//                         );
//                       },
//                     )
//                   : Center(
//                       child: Text(
//                         'No conversations yet',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
//                       ),
//                     ),
//             );
//           } else if (snapshot.hasError) {
//             return const Text("Getting Server Error");
//           }
//           return const Center(child: Text("No conversations yet"));
//         }
//       )),
//     );
//   }
// }














import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
import 'package:chatnew/Screens/Chats/individual_chat_room_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class SearchChatListView extends StatefulWidget {
  final Function(int?)? onChatSelected;  // Added this parameter
  const SearchChatListView({Key? key, this.onChatSelected}) : super(key: key);

  @override
  State<SearchChatListView> createState() => _SearchChatListViewState();
}

class _SearchChatListViewState extends State<SearchChatListView> {
  final controller = Get.put(ChatController());
  final RefreshController refreshController = RefreshController(initialRefresh: false);



  void _navigateToIndividualChat(String? userId) async {
    try {
      await controller.startUserChat(userId);
      // Call onChatSelected callback if provided
      widget.onChatSelected?.call(0);
      
      // Check screen width for responsive navigation
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IndividualChatRoomView()),
        );
      }
    } catch (e) {
      print('Error navigating to chat: $e');
      Get.snackbar(
        'Error',
        'Unable to open chat. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChatController>(
        initState: (_) => ChatController.to.initSearchUsersState(),
        builder: (value) => Obx(() => SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          onRefresh: () async {
            controller.isRefresh = true;
            controller.currentPage = 1;
            final result = await controller.getUsersList();
            if (result) {
              refreshController.resetNoData();
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            if (controller.totalPages > 1) {
              final result = await controller.getUsersList();
              if (result) {
                if (controller.currentPage > controller.totalPages) {
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
          child: controller.usersList.isNotEmpty
              ? ListView.separated(
                  itemCount: controller.usersList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final user = controller.usersList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
                        child: Text(
                          user.name?.isNotEmpty == true
                              ? user.name!.characters.first.toUpperCase()
                              : 'N/A',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      title: Text(
                        user.name ?? 'N/A',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () => _navigateToIndividualChat(user.id),
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
        ))),
      );
    
  }
}