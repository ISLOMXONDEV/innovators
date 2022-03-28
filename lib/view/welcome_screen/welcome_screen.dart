import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:innovators/view/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/core.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = "/welcome_screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  _modeInfo(String? userMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_MODE, userMode.toString());
  }

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        loggedInUser = UserModel.fromMap(value.data());
      });
    });

    _modeInfo(loggedInUser.userMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${loggedInUser.firstName} ${loggedInUser.secondName}"),
            Text("${loggedInUser.email}"),
            TextButton(
                onPressed: () {
                  logout(context);
                },
                child: Text("Logout"))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(USER_MODE));
    prefs.remove(USER_MODE);

    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, ModalRoute.withName('/'));
  }
}
