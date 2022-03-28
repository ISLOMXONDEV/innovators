import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/view/login/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/core.dart';
import 'package:innovators/view/views.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login_screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String email = '';

  String password = '';

  Widget signInWith(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Sign in')),
        ],
      ),
    );
  }

  void singIn(String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user_modeawait = pref.get(USER_MODE);

    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Login Successful'),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => WelcomeScreen())),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  Widget userInput(String hintTitle, TextInputType keyboardType,
      {bool? obsecureText}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25),
        child: TextFormField(
          onChanged: (value) => setState(() {
            if (hintTitle == "Email") {
              email = value;
            } else {
              password = value;
            }
          }),
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

            if (hintTitle == "Password") {
              RegExp regex = RegExp(r'^.{6,}$');
              if (!regex.hasMatch((value))) {
                return ("Please enter a valid password(Minimum 6 Character)");
              }
            }
          },
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
          obscureText: obsecureText ?? false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              height: 510,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Container(
                          child: const Center(
                            child: Text(
                              'Innovator Youth',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: "arial",
                                color: Colors.white,
                              ),
                            ),
                          ),
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: ColorTheme,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      userInput('Email', TextInputType.emailAddress),
                      userInput('Password', TextInputType.visiblePassword,
                          obsecureText: true),
                      Container(
                        height: 55,
                        // for an exact replicate, remove the padding.
                        // pour une réplique exact, enlever le padding.
                        padding:
                            const EdgeInsets.only(top: 5, left: 70, right: 70),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: ColorTheme,
                          onPressed: () {
                            singIn(email, password);
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text('Forgot password ?'),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            signInWith(Icons.add),
                            signInWith(Icons.book_online),
                          ],
                        ),
                      ),
                      Divider(thickness: 0, color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account yet ? ',
                            style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RegistrationScreen.routeName,
                              );
                            },
                            child: const Text(
                              'Sign Up',
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
          ],
        ),
      ),
    );
  }
}
