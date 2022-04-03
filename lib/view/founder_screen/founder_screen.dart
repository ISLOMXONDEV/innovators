import 'package:flutter/material.dart';

import '../all_users_general_components/drawer.dart';
import 'founder_info_widget.dart';

class FounderMainScreen extends StatefulWidget {
  const FounderMainScreen({Key? key}) : super(key: key);

  @override
  State<FounderMainScreen> createState() => _FounderMainScreenState();
}

class _FounderMainScreenState extends State<FounderMainScreen> {
  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.add_box,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    FounderInfoWidget(),
  ];

  int? _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Innovator',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: _pages.elementAt(
          _selectedIndex!.toInt(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueAccent,
        iconSize: 34,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex!.toInt(),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Actions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_rounded),
            label: 'Project',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int? index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
