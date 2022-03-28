import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovators/view/login/login_screen.dart';
import '../../data/core.dart';
import '../../data/preference_service.dart';
import 'package:innovators/view/views.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash-screen";
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        String? token = await PreferencesService().getString(TOKEN);
        if (token == null || token.isEmpty) {
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushReplacementNamed(
              context,
              LoginScreen.routeName,
            ),
          );
        } else {
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushReplacementNamed(
              context,
              WelcomeScreen.routeName,
            ),
          );
        }
      },
    );
  }

  // _storeUserInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(UserType, isViewed);
  //   print(prefs.getInt('onBoard'));
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: Image.asset(
          "assets/images/SplashScreen.jpeg",
          fit: BoxFit.cover,
        ));
  }
}
