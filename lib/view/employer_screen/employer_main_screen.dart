import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:innovators/data/provider_values.dart';
import 'package:innovators/view/employer_screen/explore_screen.dart';
import 'package:innovators/view/employer_screen/post_screen.dart';
import 'package:innovators/view/employer_screen/vacancies_screen.dart';
import 'package:innovators/view/employer_screen/resume_edit.dart';
import 'package:innovators/view/employer_screen/user_info_page.dart';
import 'package:provider/provider.dart';

import '../all_users_general_components/drawer.dart';
import 'add_post.dart';

class EmployerMainScreen extends StatefulWidget {
  const EmployerMainScreen({Key? key}) : super(key: key);

  @override
  State<EmployerMainScreen> createState() => _EmployerMainScreenState();
}

class _EmployerMainScreenState extends State<EmployerMainScreen> {
  static const List<Widget> _pages = <Widget>[
    VacanciesScreen(),
    ExploreScreen(),
    AddPost(),
    PostsScreen(),
    UserInfoWidget(),
  ];

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
          drawer: const CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: _selectedIndex == 0
                ? const Text(
                    'Vacancies',
                    style: const TextStyle(color: Colors.black),
                  )
                : _selectedIndex == 1
                    ? const Text(
                        'Explore',
                        style: const TextStyle(color: Colors.black),
                      )
                    : _selectedIndex == 2
                        ? const Text(
                            'Post',
                            style: TextStyle(color: Colors.black),
                          )
                        : _selectedIndex == 3
                            ? const Text(
                                'News',
                                style: TextStyle(color: Colors.black),
                              )
                            : const Text(
                                'Profile',
                                style: TextStyle(color: Colors.black),
                              ),
            actions: [
              _selectedIndex == 4
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResumeEdit(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit)),
                    )
                  : const SizedBox()
            ],
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
            currentIndex: _selectedIndex.toInt(),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: 'Main',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_rounded),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Actions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
