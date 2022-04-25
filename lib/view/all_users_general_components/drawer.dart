import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/core.dart';
import '../login/login_screen.dart';
import 'components/bottom_user_info.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'components/custom_list_title.dart';
import 'components/header.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(0, 0, 31, 10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.home_outlined,
                title: 'Home',
                infoCount: 0,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.explore,
                title: 'Explore',
                infoCount: 0,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.supervisor_account_rounded,
                title: 'Services',
                infoCount: 2,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.message_rounded,
                title: 'Messages',
                infoCount: 8,
              ),
              const Divider(color: Colors.grey),
              const Spacer(),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.notifications,
                title: 'Notifications',
                infoCount: 2,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.settings,
                title: 'Settings',
                infoCount: 0,
              ),
              const SizedBox(height: 10),
              BottomUserInfo(isCollapsed: _isCollapsed),
              Align(
                alignment: _isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_MODE);

    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, ModalRoute.withName('/'));
  }
}
