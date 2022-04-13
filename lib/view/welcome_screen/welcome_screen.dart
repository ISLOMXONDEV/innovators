import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innovators/data/models/projects_model.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:innovators/view/views.dart';

import '../../data/core.dart';
import '../../data/provider_values.dart';
import '../all_users_general_components/errorScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = "/welcome_screen";

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? loggedInUser = UserModel();
  UserResumeCard? userResumeCard = UserResumeCard();
  ProjectsModel? projectsModel = ProjectsModel();
  bool startGetting = false;

  _modeInfo(String? userMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_MODE, userMode.toString());
  }

  Future<void> infoGet() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        print(value.data());
        loggedInUser = UserModel.fromMap(value.data());
        print(loggedInUser?.firstName);
      });
    });

    if (loggedInUser?.userMode == "employee") {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("resume")
          .doc(user!.uid)
          .get()
          .then((value) {
        setState(() {
          userResumeCard = UserResumeCard.fromMap(value.data());
        });
      });
    } else if (loggedInUser?.userMode == "founder") {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("project")
          .doc(user!.uid)
          .get()
          .then((value) {
        print(value.data());
        setState(() {
          projectsModel = ProjectsModel.fromMap(value.data());
        });
      });
    }
  }

  @override
  void initState() {
    infoGet();
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _isLoading = false;
      });
    });

    _modeInfo(loggedInUser?.userMode);
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
        child: _isLoading
            ? const CircularProgressIndicator()
            : Consumer<ScreenIndexProvider>(
                builder: (context, provider, child) {
                  return Scaffold(
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
                            provider.updateUser(loggedInUser);
                            provider.readVacancy();
                            provider.readServices();
                            provider.readPosts();
                            provider.readJobSeekers();
                            provider.readProject();
                            provider.readUser();
                            var result = userResumeCard?.positionName;
                            if (result != null) {
                              provider.resumeDefine(userResumeCard);
                              provider.hasResume = true;
                            }
                            var project = projectsModel?.projectsName;
                            if (project != null) {
                              provider.projectDefine(projectsModel);
                              provider.hasProject = true;
                            }

                            if (loggedInUser != null &&
                                    userResumeCard != null ||
                                loggedInUser != null) {
                              if (loggedInUser?.userMode == "service") {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ServiceMainScreen()));
                              } else if (loggedInUser?.userMode == "founder") {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const FounderMainScreen()));
                              } else if (loggedInUser?.userMode == "employee") {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EmployerMainScreen()));
                              } else {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ErrorScreen()));
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
