import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innovators/data/models/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:innovators/view/views.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/welcome.jpg'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight - 200),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                child: const Text(
                  "PRESS TO CONTINUE",
                  style: TextStyle(fontSize: 25, fontFamily: ''),
                ),
                onPressed: () {
                  if (loggedInUser.userMode == "employee") {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => EmployerMainScreen()));
                  } else if (loggedInUser.userMode == "founder") {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FounderMainScreen()));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ServiceMainScreen()));
                  }
                },
              ),
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
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
