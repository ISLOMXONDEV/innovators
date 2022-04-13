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

class ServiceEdit extends StatefulWidget {
  ServiceEdit({Key? key}) : super(key: key);

  @override
  State<ServiceEdit> createState() => _ServiceEditState();
}

class _ServiceEditState extends State<ServiceEdit> {
  int? initialIndex = 0;

  final _auth = FirebaseAuth.instance;

  var _formKey = GlobalKey<FormState>();
  var contactNumberController = TextEditingController();
  var serviceDetailsController = TextEditingController();
  var serviceLocationController = TextEditingController();
  var serviceNameController = TextEditingController();
  var tgAccountController = TextEditingController();
  var priceController = TextEditingController();

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
      Service service = provider.myServices[0];
      if (firstTime) {
        contactNumberController.text = service.serviceContactNumber.toString();
        serviceDetailsController.text = service.serviceDetails.toString();
        serviceLocationController.text = service.serviceLocation.toString();
        serviceNameController.text = service.serviceName.toString();
        tgAccountController.text = service.serviceTgAccount.toString();
        priceController.text = service.servicePayment.toString();
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
                                  'Edit your Sevice',
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
              signUpResume(provider.loggedInUser!.uid, provider.loggedInUser);
            },
            child: const Icon(
              Icons.add,
              size: 50,
            )),
      );
    });
  }

  void signUpResume(String? uid, UserModel? user) async {
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
        .update(service.toMap())
        .then((value) {
      Fluttertoast.showToast(msg: "Service created successfully");
      serviceNameController.clear();
      serviceDetailsController.clear();
      contactNumberController.clear();
      serviceLocationController.clear();
      priceController.clear();
      tgAccountController.clear();
      context.read<ScreenIndexProvider>().readServices();

      Navigator.pop(context);
    }).catchError((e) {
      print(e);
      Fluttertoast.showToast(msg: e.message);
    });
  }
}
