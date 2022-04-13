import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../data/core.dart';
import '../../data/provider_values.dart';

class ResumeForm extends StatefulWidget {
  ResumeForm({Key? key}) : super(key: key);

  @override
  State<ResumeForm> createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  int? initialIndex = 0;

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final positionNameController = TextEditingController();
  final tellNumberController = TextEditingController();
  final emailController = TextEditingController();
  final socialController = TextEditingController();
  final skillsController = TextEditingController();
  final experienceController = TextEditingController();
  final imageLinkController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final aboutController = TextEditingController();
  final tgController = TextEditingController();
  final specializationController = TextEditingController();
  final resumeLinkController = TextEditingController();
  final universityNameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(builder: (context, provider, child) {
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
                                'Create your resume',
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
                                positionNameController, 'Your name ',
                                keyboardType: TextInputType.name),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(aboutController, 'About yourself',
                                keyboardType: TextInputType.name),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(
                                tellNumberController, 'Your tell number',
                                keyboardType: TextInputType.name),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(tgController, 'Telegram username',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(
                                socialController, 'Facebook username',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(skillsController, 'Your Skills',
                                keyboardType: TextInputType.emailAddress),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: userInput(
                                specializationController, 'Your Specialization',
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
    userResumeModel.about = aboutController.text;
    userResumeModel.tgAccount = tgController.text;
    userResumeModel.specialization = specializationController.text;
    userResumeModel.universityName = universityNameController.text;
    userResumeModel.experience = experienceController.text;
    userResumeModel.dateOfBirth = dateOfBirthController.text;
    userResumeModel.resumeLink = resumeLinkController.text;

    await firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("resume")
        .doc(uid)
        .set(userResumeModel.toMap())
        .then((value) {
      Provider.of<ScreenIndexProvider>(context, listen: false).readUser();

      Fluttertoast.showToast(msg: "Resume created successfully");
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.message);
      Provider.of<ScreenIndexProvider>(context, listen: false).readUser();
      Navigator.pop(context);
    });
    Navigator.pop(context);
  }

  // postDetailsToFirestore() async {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //
  //   User? user = _auth.currentUser;
  //
  //   UserResumeCard userResumeCard = UserResumeCard();
  //
  //   // userModel.email = user!.email;
  //   // userModel.uid = user.uid;
  //   // userModel.firstName = positionNameController.text;
  //   // userModel.secondName = tellNumberController.text;
  //   // userModel.userMode = modeController.text;
  //
  //   UserResumeCard resume = UserResumeCard(
  //     positionName: "Test",
  //     tellNumber: "1",
  //     email: "emailtest",
  //     social: "social",
  //     skills: "skills",
  //     experience: "experience",
  //     imageLink:
  //         "https://instagram.ftas5-1.fna.fbcdn.net/v/t51.2885-19/275533037_534615464600607_594752709445410002_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ftas5-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=QCaOvnpq_isAX8ptw_2&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT89_7xmEwOPU3kLwtiTBOSAoE-_uaOwI27xy7A5xynz7w&oe=624BAC78&_nc_sid=7bff83",
  //     dateOfBirth: "01.01.2012",
  //     resumeLink: "blabla",
  //     universityName: "Narxoz",
  //   );
  //
  //   // await firebaseFirestore
  //   //     .collection('users')
  //   //     .doc(user.uid)
  //   //     .set(userModel.toMap());
  // }
}
