

import 'package:chatnew/CommonComponents/gradient_containers.dart';
import 'package:chatnew/Screens/Chats/call.dart';
import 'package:chatnew/Screens/Chats/chats_list_view.dart';
import 'package:chatnew/Screens/Chats/individual_chat_room_view.dart';
import 'package:chatnew/Screens/Chats/status.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int selectedIndex = 0;
  int? selectedChatId;
  int selectedSectionIndex = 0;

  final List<Widget> sections = [
    ChatListView(onChatSelected: (chatId) {}),
    Call(),
    Status(),
  ];

  @override
  Widget build(BuildContext context) {
    print('get the width of the seclectedchat :::: ${MediaQuery.of(context).size.width}');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isLargeScreen = constraints.maxWidth > 600;

            return GradientContainer(
              child: isLargeScreen
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: const Color(0xff202c33),
                          width: 65,
                          child: Center(
                            child: ListView.builder(
                              itemCount: sections.length,
                              itemBuilder: (context, index) {
                                final bool isSelected = selectedSectionIndex == index;
                                return ListTile(
                                  leading: Icon(
                                    getIconForSection(index),
                                    color: isSelected ? Colors.white : null,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedSectionIndex = index;
                                      selectedChatId = null;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          // width: 275,
                          width: MediaQuery.of(context).size.width < 800 ?  MediaQuery.of(context).size.width * 0.4 : 325,
                          child: selectedSectionIndex == 0
                              ? ChatListView(
                                  onChatSelected: (chatId) {
                                    setState(() {
                                      selectedChatId = chatId;
                                    });
                                  },
                                )
                              : sections[selectedSectionIndex],
                        ),
                        // Expanded(
                        //   flex: MediaQuery.of(context).size.width > 500 ? 2 : MediaQuery.of(context).size.width > 800  ? 2  : MediaQuery.of(context).size.width >1000 ? 2 : 1,
                        //   // flex: MediaQuery.of(context).size.width <= 700 ? 5 : MediaQuery.of(context).size.width <= 1100 ? 2 : 1,
                        //   child: selectedSectionIndex == 0
                        //       ? ChatListView(
                        //           onChatSelected: (chatId) {
                        //             setState(() {
                        //               selectedChatId = chatId;
                        //             });
                        //           },
                        //         )
                        //       : sections[selectedSectionIndex],
                        // ),
                        Expanded(
                          flex: 4,
                          child: selectedSectionIndex == 0
                              ? (selectedChatId == null
                                  ? const Center(
                                      child: Text(
                                        'Select a chat',
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
                                      ),
                                    )
                                  : IndividualChatRoomView())
                              : const SizedBox.shrink(),
                        ),
                      ],
                    )
                  : sections[selectedIndex],
            );
          },
        ),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width <= 600
          ? BottomNavigationBar(
            backgroundColor: Colors.blue[50],
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
                BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Call'),
                BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Status'),
              ],
            )
          : null,
    );
  }

  IconData getIconForSection(int index) {
    switch (index) {
      case 0: return Icons.chat;
      case 1: return Icons.call;
      case 2: return Icons.camera;
      default: return Icons.help;
    }
  }
}