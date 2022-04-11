import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:innovators/view/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../data/core.dart';
import '../../data/provider_values.dart';
import 'package:innovators/view/views.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = "/registration_screen";

  RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int? initialIndex = 0;

  List<Widget> images = [
    Image.asset(
      'assets/images/mode1.png',
      fit: BoxFit.fitWidth,
      height: 200,
    ),
    Image.asset(
      'assets/images/mode2.png',
      fit: BoxFit.fitWidth,
      height: 200,
    ),
    Image.asset(
      'assets/images/mode3.png',
      fit: BoxFit.fitWidth,
      height: 200,
    ),
  ];

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final modeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Widget userInput(TextEditingController userInput, String hintTitle,
      {TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25,
          top: 10,
        ),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return ("Please enter your $hintTitle");
            }

            if (hintTitle == "Email") {
              if (!RegExp("^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please enter a valid email");
              }
            }
            if (hintTitle == "First Name") {
              RegExp regex = RegExp(r'^.{3,}$');
              if (!regex.hasMatch((value))) {
                return ("Please enter a minimum 3 letter First Name");
              }
            }
            if (hintTitle == "Password") {
              RegExp regex = RegExp(r'^.{6,}$');
              if (!regex.hasMatch((value))) {
                return ("Please enter a valid password( Minimum 6 Character)");
              }
            }
            if (hintTitle == "Confirm Password") {
              RegExp regex = RegExp(r'^.{6,}$');
              if (!regex.hasMatch((value)) &&
                  confirmPasswordController.text == passwordController.text) {
                return ("Please enter a valid password( Minimum 6 Character) and Passwords should match");
              }
            }
          },
          controller: userInput,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Container(child: images[provider.screenIndex!.toInt()]),
      resizeToAvoidBottomInset: false,
      body: Consumer<ScreenIndexProvider>(
        builder: (context, provider, child) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: NetworkImage(
                  'https://images.pexels.com/photos/3975570/pexels-photo-3975570.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Registration form',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: "arial",
                                    color: ColorTheme,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  child: images[provider.screenIndex!.toInt()]),
                            ),
                            const SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(
                                  firstNameController, 'First Name',
                                  keyboardType: TextInputType.name),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(
                                  secondNameController, 'Second Name',
                                  keyboardType: TextInputType.name),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(emailController, 'Email',
                                  keyboardType: TextInputType.emailAddress),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(
                                passwordController,
                                'Password',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(
                                confirmPasswordController,
                                'Confirm Password',
                              ),
                            ),
                            userMode(),
                            const Divider(thickness: 0, color: Colors.white),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don\'t want to create an account?',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigator.pushReplacementNamed(
                                    //   context,
                                    //   RegistrationPage.routeName,
                                    // );
                                  },
                                  child: const Text(
                                    'Continue  as \n Guest User',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            signUp(emailController.text, passwordController.text);
          },
          child: const Icon(
            Icons.add,
            size: 50,
          )),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      _auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        postDetailsToFirestore();
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.message);
      });
    }
  }

  Widget userMode() {
    return Consumer<ScreenIndexProvider>(
      builder: (context, provider, child) {
        return Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Whom you consider yourself ?'),
                ),
                Center(
                  child: ToggleSwitch(
                    minWidth: 90.0,
                    minHeight: 70.0,
                    initialLabelIndex: initialIndex,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 3,
                    labels: const ["Student", "Founder", "Service"],
                    iconSize: 30.0,
                    borderColor: const [
                      Color(0xff3b5998),
                      Color(0xff8b9dc3),
                      Color(0xff00aeff),
                      Color(0xff0077f2),
                      Color(0xff962fbf),
                      Color(0xff4f5bd5)
                    ],
                    dividerColor: Colors.blueGrey,
                    activeBgColors: const [
                      [Color(0xff3b5998), Color(0xff8b9dc3)],
                      [Color(0xff00aeff), Color(0xff0077f2)],
                      [
                        Color(0xfffeda75),
                        Color(0xfffa7e1e),
                        Color(0xffd62976),
                        Color(0xff962fbf),
                        Color(0xff4f5bd5)
                      ]
                    ],
                    onToggle: (index) {
                      initialIndex = index;
                      provider.updateIndex(index);
                      if (initialIndex == 0) {
                        setState(() {
                          modeController.text = 'employee';
                        });
                      } else if (initialIndex == 1) {
                        setState(() {
                          modeController.text = 'founder';
                        });
                      } else {
                        setState(() {
                          modeController.text = 'service';
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.secondName = secondNameController.text;
    userModel.userMode = modeController.text;
    userModel.status = 'active';

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: 'Account created successfully');
    Navigator.pop(context);
  }
}
