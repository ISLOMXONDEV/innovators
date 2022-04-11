import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/data/models/projects_model.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../data/core.dart';
import '../../data/provider_values.dart';

class ProjectForm extends StatefulWidget {
  const ProjectForm({Key? key}) : super(key: key);

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  int? initialIndex = 0;

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final projectsNameController = TextEditingController();
  final foundDataController = TextEditingController();
  final emailController = TextEditingController();
  final avatarController = TextEditingController();
  final tgAccountController = TextEditingController();
  final segmentController = TextEditingController();
  final detailsController = TextEditingController();

  final addressController = TextEditingController();
  final tellNumberController = TextEditingController();

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
    return Consumer<ScreenIndexProvider>(builder: (context, provider, child) {
      return Scaffold(
        //Container(child: images[provider.screenIndex!.toInt()]),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
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
                                  'Create your Project',
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
                                  projectsNameController, 'Projects name',
                                  keyboardType: TextInputType.name),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(foundDataController,
                                  'The time project started',
                                  keyboardType: TextInputType.name),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: userInput(
                            //       socialController, 'Telegram username',
                            //       keyboardType: TextInputType.emailAddress),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(
                                  segmentController, 'Projects Segment',
                                  keyboardType: TextInputType.emailAddress),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(detailsController, 'Details',
                                  keyboardType: TextInputType.emailAddress),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(avatarController, 'Image link',
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
                              child: userInput(addressController, 'Address',
                                  keyboardType: TextInputType.emailAddress),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(
                                  tellNumberController, 'Telephone number',
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
        ),

        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              signUpResume(
                uid: provider.loggedInUser!.uid,
                user: provider.loggedInUser,
              );
            },
            child: const Icon(
              Icons.add,
              size: 50,
            )),
      );
    });
  }

  void signUpResume({String? uid, UserModel? user}) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    ProjectsModel project = ProjectsModel();
    project.projectsName = projectsNameController.text;
    project.details = detailsController.text;
    project.foundData = foundDataController.text;
    project.segment = segmentController.text;
    project.emailsOfStaff = emailController.text;
    project.avatarImage = avatarController.text;
    project.address = addressController.text;
    project.phoneNumber = tellNumberController.text;
    project.founder = user?.email;
    project.tgAccount = tgAccountController.text;
    print(project.projectsName);

    firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("project")
        .doc(uid)
        .set(project.toMap())
        .then((value) {
      Fluttertoast.showToast(msg: "Project created successfully");
    }).catchError((e) {
      print(e);
      Fluttertoast.showToast(msg: e.message);
    });
    context.watch<ScreenIndexProvider>().hasProject = true;
    Navigator.pop(context);
  }
}
