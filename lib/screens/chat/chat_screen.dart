import 'package:flutter/material.dart';
import 'package:random_job/screens/chat/chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static String route() => "/chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _currentIndex = 0;
  final _pages = <Widget>[
    const ChatUserWidget(),
    // const ChatRoomWidget(
    //   userInfo: "",
    // ),
    const ChatSettingWidget(),
  ];
  final _titles = <String>[
    "Users",
    // "Room",
    "Setting",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
        // actions: const [AppBarDropdownWidget()],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        indicatorColor: Colors.green,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.group),
            label: "all",
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.house),
          //   label: "room",
          // ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "setting",
          ),
        ],
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
