import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovators/view/main_screen/main_screen.dart';

import '../../data/preference_service.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash-screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // String? token = await PreferencesService().getString(KEY_TOKEN);
      // if (token == null || token.isEmpty) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(
          context,
          MainScreen.routeName,
        ),
      );
      // } else {
      //   context.read<UserInfoBloc>().add(UserInfoFetch());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/SplashScreen.jpeg",
              ),
            )),
            child: const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )));
  }
}
