import 'package:flutter/material.dart';
import 'package:innovators/data/provider_values.dart';
import 'package:innovators/view/founder_screen/employers_list.dart';
import 'package:innovators/view/founder_screen/founder_post.dart';
import 'package:innovators/view/founder_screen/project_edit.dart';
import 'package:provider/provider.dart';

import '../all_users_general_components/drawer.dart';
import '../employer_screen/add_post.dart';
import '../employer_screen/post_screen.dart';
import 'founder_info_widget.dart';

class FounderMainScreen extends StatefulWidget {
  const FounderMainScreen({Key? key}) : super(key: key);

  @override
  State<FounderMainScreen> createState() => _FounderMainScreenState();
}

class _FounderMainScreenState extends State<FounderMainScreen> {
  static const List<Widget> _pages = <Widget>[
    EmployersList(),
    AddPost(),
    PostVacancy(),
    PostsScreen(),
    FounderInfoWidget(),
  ];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(
      builder: (context, provider, child) {
        provider.initialise();
        int? _selectedIndex = provider.screenIndex;

        void _onItemTapped(int? index) {
          setState(() {
            provider.screenIndex = index;
          });
        }

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: _selectedIndex == 4
                ? Text("Project Info")
                : _selectedIndex == 3
                    ? Text("Disscussion")
                    : _selectedIndex == 2
                        ? Text("Add")
                        : _selectedIndex == 1
                            ? Text("Post")
                            : Text('Main'),
            actions: [
              _selectedIndex == 3
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectEdit(),
                              ));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          drawer: CustomDrawer(),
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
            currentIndex: _selectedIndex.toInt(),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Main',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.messenger),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: 'Add',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mark_chat_unread_rounded),
                label: 'Actions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_rounded),
                label: 'Project',
              ),
            ],
          ),
        );
      },
    );
  }
}
