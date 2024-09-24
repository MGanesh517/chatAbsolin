
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

// class _ChatListViewState extends State<ChatListView> {
//   final controller = Get.put(ChatController());
//   final RefreshController searchRefreshController = RefreshController(initialRefresh: false);
//   final RefreshController chatRefreshController = RefreshController(initialRefresh: false);
//   int? selectedChatIndex;
//   bool? isLargeScreen;
//   bool isSearchView = false;
//   // late TabController tabController;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   bottom: MediaQuery.of(context).size.width >500 ? null : TabBar(
//       //     controller: tabController,
//       //     tabs: [
//       //       Tab(icon: Icon(Icons.directions_car), text: "Car"),
//       //       Tab(icon: Icon(Icons.directions_transit), text: "Transit"),
//       //       Tab(icon: Icon(Icons.directions_bike), text: "Bike"),
//       //     ],
//       //   ),
//       // ),
//       backgroundColor: Colors.grey,
//       body: SafeArea(
//         bottom: false,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             isLargeScreen = constraints.maxWidth > 500;
            
//             return GradientContainer(
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: MediaQuery.of(context).size.width <= 700 ? 5 : MediaQuery.of(context).size.width <= 1100 ? 3 : 1,
//                     child: Column(
//                       children: [
//                         const CustomAppBar(
//                           titleChild: Text('ChatList', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23, color: Colors.white)),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: TextFormField(
//                             controller: controller.searchUsersTextConrtoller,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide: const BorderSide(width: 1,color: Colors.grey)
//                               ),
//                               hintText: 'Search',
//                               prefixIcon: const Icon(Icons.search),
//                               suffixIcon: controller.searchUsersTextConrtoller.text.isEmpty
//                               ? null
//                               : CloseButton(
//                                   onPressed: () {
//                                     controller.searchUsersTextConrtoller.clear();
//                                     controller.isRefresh = true;
//                                     controller.getUsersList();
                                    
//                                     setState(() {
//                                       isSearchView = false;
//                                     });

//                                     // if (!isLargeScreen!) {
//                                     //   Navigator.pop(context);
//                                     // }
//                                   },
//                                 ),
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 isSearchView = true;
//                               });
//                             },
//                             onFieldSubmitted: (val) {
//                               controller.isRefresh = true;
//                               controller.getUsersList(search: val);
//                             },
//                             onChanged: (value) {
//                               if (value.isEmpty) {
//                                 setState(() {
//                                   isSearchView = false;
//                                 });
//                                 controller.isRefresh = true;
//                                 controller.getUsersList(filter: value);
//                               } else {
//                                 setState(() {
//                                   isSearchView = true;
//                                 });
//                                 controller.isRefresh = true;
//                                 controller.getUsersList(search: value);
//                               }
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           child: isSearchView
//                               ? GetBuilder<ChatController>(
//                                   initState: (_) => ChatController.to.initSearchUsersState(),
//                                   builder: (value) => Obx(() => SmartRefresher(
//                                     controller: searchRefreshController,
//                                     enablePullUp: true,
//                                     onRefresh: () async {
//                                       controller.isRefresh = true;
//                                       controller.currentPage = 1;
//                                       final result = await controller.getUsersList();
//                                       if (result) {
//                                         searchRefreshController.resetNoData();
//                                         searchRefreshController.refreshCompleted();
//                                       } else {
//                                         searchRefreshController.refreshFailed();
//                                       }
//                                     },
//                                     onLoading: () async {
//                                       if (controller.totalPages > 1) {
//                                         final result = await controller.getUsersList();
//                                         if (result) {
//                                           if (controller.currentPage > controller.totalPages) {
//                                             searchRefreshController.loadNoData();
//                                           } else {
//                                             searchRefreshController.loadComplete();
//                                           }
//                                         } else {
//                                           searchRefreshController.loadNoData();
//                                         }
//                                       } else {
//                                         searchRefreshController.loadNoData();
//                                       }
//                                     },
//                                     child: controller.usersList.isNotEmpty
//                                         ? ListView.separated(
//                                             itemCount: controller.usersList.length,
//                                             shrinkWrap: true,
//                                             itemBuilder: (BuildContext context, int index) {
//                                               return ExpandTapWidget(
//                                                 onTap: () {
//                                                   controller.startUserChat(controller.usersList[index].id);
//                                                 },
//                                                 tapPadding: const EdgeInsets.all(16),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.only(left: 16, right: 16),
//                                                   child: Row(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
//                                                         radius: 30,
//                                                         child: Text(
//                                                           controller.usersList[index].name != null && controller.usersList[index].name!.isNotEmpty
//                                                               ? controller.usersList[index].name!.characters.first.toUpperCase()
//                                                               : 'N/A',
//                                                           style: TextStyle(
//                                                             color: Colors.primaries[index % Colors.primaries.length],
//                                                             fontSize: 15,
//                                                             fontWeight: FontWeight.w600,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         width: 10,
//                                                       ),
//                                                       Text(
//                                                         controller.usersList[index].name ?? 'N/A',
//                                                         style: TextStyle(
//                                                           color: Theme.of(context).colorScheme.onSurface,
//                                                           fontSize: 15,
//                                                           fontWeight: FontWeight.w600,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             separatorBuilder: (BuildContext context, int index) {
//                                               return const Padding(
//                                                 padding: EdgeInsets.only(left: 16.0, right: 16.0),
//                                                 child: Divider(),
//                                               );
//                                             },
//                                           )
//                                         : Center(
//                                             child: Text(
//                                               'No data available',
//                                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
//                                             ),
//                                           ),
//                                   )))
//                               : GetBuilder<ChatController>(
//                                   initState: (_) => ChatController.to.initState(),
//                                   builder: (value) => Obx(() => FutureBuilder<List<GetUsersChatListData>?>(
//                                     key: controller.futureBuilderKey,
//                                     future: controller.getChatUsersList(search: controller.searchUsersTextConrtoller.text),
//                                     builder: (context, snapshot) {
//                                       if (snapshot.hasData) {
//                                         return SmartRefresher(
//                                           controller: chatRefreshController,
//                                           enablePullUp: true,
//                                           onRefresh: () async {
//                                             controller.userChatIsRefresh = true;
//                                             controller.userChatCurrentPage = 1;
//                                             final result = await controller.getChatUsersList();
//                                             if (result != null && result.isNotEmpty) {
//                                               chatRefreshController.resetNoData();
//                                               chatRefreshController.refreshCompleted();
//                                             } else {
//                                               chatRefreshController.refreshFailed();
//                                             }
//                                           },
//                                           onLoading: () async {
//                                             if (controller.userChatTotalPages > 1) {
//                                               final result = await controller.getUserChatList();
//                                               if (result != null && result.isNotEmpty) {
//                                                 if (controller.userChatCurrentPage > controller.userChatTotalPages) {
//                                                   chatRefreshController.loadNoData();
//                                                 } else {
//                                                   chatRefreshController.loadComplete();
//                                                 }
//                                               } else {
//                                                 chatRefreshController.loadNoData();
//                                               }
//                                             } else {
//                                               chatRefreshController.loadNoData();
//                                             }
//                                           },
//                                           child: snapshot.data!.isNotEmpty
//                                               ? ListView.builder(
//                                                   padding: const EdgeInsets.only(left: 8, right: 8),
//                                                   itemCount: controller.userChatList.length,
//                                                   shrinkWrap: true,
//                                                   itemBuilder: (BuildContext context, int index) {
//                                                     return CommonChatCard(
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
//                                                   },
//                                                 )
//                                               : Center(
//                                                   child: Text(
//                                                     'No conversations yet',
//                                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
//                                                   ),
//                                                 ),
//                                         );
//                                       } else if (snapshot.hasError) {
//                                         return const Text("Getting Server Error");
//                                       }
//                                       return const Center(child: Text("No conversations yet"));
//                                     }
//                                   )),
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const VerticalDivider(width: 2),
//                   if (isLargeScreen!)
//                     Expanded(
//                       flex: 4,
//                       child: selectedChatIndex == null
//                           ? const Center(child: Text('Select a chat', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23)))
//                           : const IndividualChatRoomView()
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }













import 'package:chatnew/CommonComponents/common_chat_list_card.dart';
import 'package:chatnew/CommonComponents/custom_app_bar.dart';
import 'package:chatnew/CommonComponents/gradient_containers.dart';
import 'package:chatnew/Screens/Chats/Controller/chat_controller.dart';
import 'package:chatnew/Screens/Chats/Model/get_chat_users_list_model.dart';
import 'package:chatnew/Screens/Chats/individual_chat_room_view.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> with SingleTickerProviderStateMixin {
  final controller = Get.put(ChatController());
  final RefreshController searchRefreshController = RefreshController(initialRefresh: false);
  final RefreshController chatRefreshController = RefreshController(initialRefresh: false);
  int? selectedChatIndex;
  bool? isLargeScreen;
  bool isSearchView = false;
  int selectedSectionIndex = 0;
  TabController? tabController;

  // final List<Map<String, dynamic>> sections = [
  // {'name': 'Chats', 'icon': Icons.chat},
  // {'name': 'Calls', 'icon': Icons.call},
  // {'name': 'Status', 'icon': Icons.camera_alt},
  //   ];

  final List<Map<String, dynamic>> sections = [
  {'name': 'Chats', 'icon': Icons.chat},
  {'name': 'Calls', 'icon': Icons.call},
  {'name': 'Status', 'icon': Icons.camera_alt},
];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: sections.length, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            isLargeScreen = constraints.maxWidth > 600;
            
            return GradientContainer(
              child: isLargeScreen!
                  ? Row(
                      children: [
                        // Sidebar
                        SizedBox(
                          width: 100,
                          child: ListView.builder(
                            itemCount: sections.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(sections[index]['icon']),
                                selected: selectedSectionIndex == index,
                                onTap: () {
                                  setState(() {
                                    selectedSectionIndex = index;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const VerticalDivider(width: 2, color: Colors.grey),
                        // Main content area
                        Expanded(
                          flex: MediaQuery.of(context).size.width <= 700 ? 5 : MediaQuery.of(context).size.width <= 1100 ? 3 : 1,
                          child: _buildMainContent(),
                        ),
                        const VerticalDivider(width: 2),
                        // Chat details area
                        Expanded(
                          flex: 4,
                          child: selectedChatIndex == null
                              ? const Center(child: Text('Select a chat', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23)))
                              : const IndividualChatRoomView()
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        // TabBar(
                        //   controller: tabController,
                        //   tabs: sections
                        //       .map((section) => Tab(
                        //             text: section,
                        //           ))
                        //       .toList(),
                        // ),
                        TabBar(
                          controller: tabController,
                          tabs: sections
                            .map((section) => Tab(
                                  icon: Icon(section['icon'] as IconData),
                                  text: section['name'] as String,
                                ))
                            .toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              const Center(child: Text('Calls Screen')),
                              _buildMainContent(),
                              const Center(child: Text('Status Screen')),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
          Visibility(
          // visible: MediaQuery.of(context).size.width > 600,
          child: const CustomAppBar(
            titleChild: Text('ChatList', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23, color: Colors.white)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller.searchUsersTextConrtoller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(width: 1,color: Colors.grey)
              ),
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
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
          child: isSearchView
              ? _buildSearchView()
              : _buildChatListView(),
        ),
      ],
    );
  }

  Widget _buildSearchView() {
    return GetBuilder<ChatController>(
      initState: (_) => ChatController.to.initSearchUsersState(),
      builder: (value) => Obx(() => SmartRefresher(
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
                  return ExpandTapWidget(
                    onTap: () {
                      controller.startUserChat(controller.usersList[index].id);
                    },
                    tapPadding: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.primaries[index % Colors.primaries.length].shade100,
                            radius: 30,
                            child: Text(
                              controller.usersList[index].name != null && controller.usersList[index].name!.isNotEmpty
                                  ? controller.usersList[index].name!.characters.first.toUpperCase()
                                  : 'N/A',
                              style: TextStyle(
                                color: Colors.primaries[index % Colors.primaries.length],
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: 10,
                          ),
                          Text(
                            controller.usersList[index].name ?? 'N/A',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Divider(),
                  );
                },
              )
            : Center(
                child: Text(
                  'No data available',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                ),
              ),
      ))
    );
  }

  Widget _buildChatListView() {
    return GetBuilder<ChatController>(
      initState: (_) => ChatController.to.initState(),
      builder: (value) => Obx(() => FutureBuilder<List<GetUsersChatListData>?>(
        key: controller.futureBuilderKey,
        future: controller.getChatUsersList(search: controller.searchUsersTextConrtoller.text),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                  final result = await controller.getUserChatList();
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
              child: snapshot.data!.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      itemCount: controller.userChatList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CommonChatCard(
                          backGroundColor: Colors.primaries[index % Colors.primaries.length],
                          chatSeenStatus: controller.userChatList[index].lastMessage != null
                              ? controller.userChatList[index].lastMessage!.type == 'image'
                                  ? 'assets/images/camera.svg'
                                  : ''
                              : '',
                          image: 'assets/event.jpeg',
                          time: controller.userChatList[index].lastMessage != null
                              ? controller.userChatList[index].lastMessage!.createdOn != null
                                  ? Jiffy.parseFromDateTime(snapshot.data![index].lastMessage!.createdOn!.toLocal()).fromNow()
                                  : 'N/A'
                              : 'N/A',
                          title: controller.userChatList[index].otherUser != null
                              ? controller.userChatList[index].otherUser!.name ?? 'N/A'
                              : controller.userChatList[index].groupDetails != null
                                  ? controller.userChatList[index].groupDetails!.name!
                                  : '',
                          subTitle: controller.userChatList[index].lastMessage != null
                              ? controller.userChatList[index].lastMessage!.type == 'image'
                                  ? 'Photo'
                                  : controller.userChatList[index].lastMessage!.message!
                              : '',
                          btnLink: () async {
                            setState(() {
                              selectedChatIndex = index;
                            });
                            controller.getChatDetails(controller.userChatList[index].id);
                            
                            if (!isLargeScreen!) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const IndividualChatRoomView()),
                              );
                            }
                          },
                          msgCount: controller.userChatList[index].unreadCount != null
                              ? controller.userChatList[index].unreadCount.toString()
                              : '0',
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No conversations yet',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
            );
          } else if (snapshot.hasError) {
            return const Text("Getting Server Error");
          }
          return const Center(child: Text("No conversations yet"));
        }
      )),
    );
  }
}