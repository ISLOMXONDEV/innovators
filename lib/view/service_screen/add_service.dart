import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/data/models/projects_model.dart';
import 'package:innovators/data/models/service.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../data/core.dart';
import '../../data/provider_values.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  int? initialIndex = 0;

  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final contactNumberController = TextEditingController();
  final serviceDetailsController = TextEditingController();
  final serviceLocationController = TextEditingController();
  final serviceNameController = TextEditingController();
  final tgAccountController = TextEditingController();
  final priceController = TextEditingController();

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
                                  'Create your Sevice',
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
                              child: userInput(contactNumberController,
                                  'Your Contact number',
                                  keyboardType: TextInputType.name),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(serviceDetailsController,
                                  'Details of your service',
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
                              child: userInput(serviceLocationController,
                                  'Location of your service',
                                  keyboardType: TextInputType.emailAddress),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: userInput(
                                  serviceNameController, 'Name of the service',
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
                              child: userInput(priceController, 'Price in \$',
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
              signUpService(
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

  void signUpService({String? uid, UserModel? user}) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    Service service = Service();
    service.serviceName = serviceNameController.text;
    service.serviceDetails = serviceDetailsController.text;
    service.serviceContactNumber = contactNumberController.text;
    service.serviceLocation = serviceLocationController.text;
    service.serviceProvider = "${user?.firstName} ${user?.secondName}";
    service.servicePayment = int.parse(priceController.text);
    service.serviceProviderID = user?.uid;
    service.serviceTgAccount = tgAccountController.text;

    firebaseFirestore
        .collection("services")
        .doc("$uid+${service.serviceName}")
        .set(service.toMap())
        .then((value) {
      Fluttertoast.showToast(msg: "Service created successfully");
      serviceNameController.clear();
      serviceDetailsController.clear();
      contactNumberController.clear();
      serviceLocationController.clear();
      priceController.clear();
      tgAccountController.clear();
    }).catchError((e) {
      print(e);
      Fluttertoast.showToast(msg: e.message);
    });
    context.watch<ScreenIndexProvider>().hasProject = true;
    Navigator.pop(context);
  }
}
