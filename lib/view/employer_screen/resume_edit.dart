import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/data/models/projects_model.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../data/core.dart';
import '../../data/provider_values.dart';

class ResumeEdit extends StatefulWidget {
  ResumeEdit({Key? key}) : super(key: key);

  @override
  State<ResumeEdit> createState() => _ResumeEditState();
}

class _ResumeEditState extends State<ResumeEdit> {
  int? initialIndex = 0;

  final _auth = FirebaseAuth.instance;

  var _formKey = GlobalKey<FormState>();

  var positionNameController = TextEditingController();

  var tellNumberController = TextEditingController();

  var emailController = TextEditingController();

  var socialController = TextEditingController();

  var tgAccountController = TextEditingController();

  var skillsController = TextEditingController();

  var experienceController = TextEditingController();

  var imageLinkController = TextEditingController();

  var dateOfBirthController = TextEditingController();

  var resumeLinkController = TextEditingController();

  var universityNameController = TextEditingController();

  bool firstTime = true;

  Widget userInput(TextEditingController userInput, String hintTitle,
      {TextInputType? keyboardType, String? initialValue}) {
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
          initialValue: initialValue,
        ),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(builder: (context, provider, child) {
      if (firstTime) {
        positionNameController = TextEditingController(
            text: provider.userResumeCard?.positionName ?? "");
        tellNumberController = TextEditingController(
            text: provider.userResumeCard?.tellNumber ?? "");
        emailController =
            TextEditingController(text: provider.userResumeCard?.email ?? "");
        socialController =
            TextEditingController(text: provider.userResumeCard?.social ?? "");
        tgAccountController = TextEditingController(
            text: provider.userResumeCard?.tgAccount ?? "");
        skillsController =
            TextEditingController(text: provider.userResumeCard?.skills ?? "");
        experienceController = TextEditingController(
            text: provider.userResumeCard?.experience ?? "");
        imageLinkController = TextEditingController(
            text: provider.userResumeCard?.imageLink ?? "");
        dateOfBirthController = TextEditingController(
            text: provider.userResumeCard?.dateOfBirth ?? "");
        resumeLinkController = TextEditingController(
            text: provider.userResumeCard?.resumeLink ?? "");
        universityNameController = TextEditingController(
            text: provider.userResumeCard?.universityName ?? "");
        firstTime = false;
      }
      return Scaffold(
        //Container(child: images[provider.screenIndex!.toInt()]),
        resizeToAvoidBottomInset: false,
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
                                'Update your resume',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: "arial",
                                  color: ColorTheme,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(
                              positionNameController,
                              'Position name you want a practise',
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(
                                tellNumberController, 'Your tell number',
                                keyboardType: TextInputType.name),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(socialController,
                                'Instagram, Facebook or LinkedIn username',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(tgAccountController,
                                'Telegram username without @ symbol',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(skillsController, 'Your Skills',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(experienceController, 'Experience',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(imageLinkController, 'Image link',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(dateOfBirthController,
                                'Date of birth DD:MM:YYYY',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(resumeLinkController,
                                'Resume file link in Google drive',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(
                                universityNameController, 'University Name',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          const Divider(thickness: 0, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              signUpResume(provider.loggedInUser!.uid);
            },
            child: const Icon(
              Icons.add,
              size: 50,
            )),
      );
    });
  }

  void signUpResume(String? uid) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    UserResumeCard userResumeModel = UserResumeCard();
    userResumeModel.positionName = positionNameController.text;
    userResumeModel.email = experienceController.text;
    userResumeModel.social = socialController.text;
    userResumeModel.tellNumber = tellNumberController.text;
    userResumeModel.skills = skillsController.text;
    userResumeModel.universityName = universityNameController.text;
    userResumeModel.experience = experienceController.text;
    userResumeModel.tgAccount = tgAccountController.text;
    userResumeModel.dateOfBirth = dateOfBirthController.text;
    userResumeModel.resumeLink = resumeLinkController.text;

    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("resume")
        .doc(uid)
        .update(userResumeModel.toMap())
        .then((value) {
      Fluttertoast.showToast(msg: "Account edited successfully");
      Provider.of<ScreenIndexProvider>(context, listen: false).readUser();
      Navigator.pop(context);
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.message);

      Navigator.pop(context);
    });
  }
}
