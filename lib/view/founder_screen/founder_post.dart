import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innovators/data/models/projects_model.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../data/provider_values.dart';

class PostVacancy extends StatefulWidget {
  const PostVacancy({Key? key}) : super(key: key);

  @override
  State<PostVacancy> createState() => _PostVacancyState();
}

class _PostVacancyState extends State<PostVacancy> {
  final statusController = TextEditingController();
  final positionNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final contactNumberNameController = TextEditingController();
  final contactEmailController = TextEditingController();
  final contactTelegramUsernameController = TextEditingController();
  final requirementsController = TextEditingController();
  final paymentInfoController = TextEditingController();
  final detailsController = TextEditingController();
  var typeController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(28.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Create a vacancy",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 30,
                    fontFamily: 'Arial'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(positionNameController, "Position name",
                keyboardType: TextInputType.name),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(companyNameController, "Company name",
                keyboardType: TextInputType.name),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(
              requirementsController,
              "Requirements",
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(
              detailsController,
              "Details of job",
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(
              paymentInfoController,
              "Payment or Salary",
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(
              contactEmailController,
              "Email of Company",
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(
              contactNumberNameController,
              "Telephone Number of Company",
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(
              contactTelegramUsernameController,
              "Contact Telegram username",
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: userInput(
              locationController,
              "Location of Company",
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text('Type of job'),
                Container(
                  child: ToggleSwitch(
                    minWidth: 90.0,
                    cornerRadius: 20.0,
                    activeBgColors: [
                      [Colors.green[800]!],
                      [Colors.blue[800]!]
                    ],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    initialLabelIndex: 1,
                    totalSwitches: 2,
                    labels: ['Online', 'Offline'],
                    radiusStyle: true,
                    onToggle: (index) {
                      if (index == 1) {
                        typeController.text = "Online";
                      } else {
                        typeController.text = "Offline";
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              post();
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void post() async {
    Vacancy vacancy = Vacancy();
    vacancy.location = locationController.text;
    vacancy.requirements = requirementsController.text;
    vacancy.details = detailsController.text;
    vacancy.status = 'active';
    vacancy.uidCompany =
        Provider.of<ScreenIndexProvider>(context, listen: false)
            .loggedInUser
            ?.uid;
    vacancy.positionName = positionNameController.text;
    vacancy.paymentInfo = paymentInfoController.text;
    vacancy.companyName = companyNameController.text;
    vacancy.type = typeController.text;
    vacancy.contactEmail = contactEmailController.text;
    vacancy.contactNumber = contactNumberNameController.text;
    vacancy.telegramChatLink = contactTelegramUsernameController.text;
    await Provider.of<ScreenIndexProvider>(context, listen: false)
        .postVacancy(vacancy);

    locationController.clear();
    requirementsController.clear();
    detailsController.clear();
    positionNameController.clear();
    companyNameController.clear();
    paymentInfoController.clear();
    typeController.clear();
    contactEmailController.clear();
    contactNumberNameController.clear();
    contactTelegramUsernameController.clear();
  }

  Widget userInput(
    TextEditingController userInput,
    String hintTitle, {
    TextInputType? keyboardType,
    var widthSize,
  }) {
    return Container(
      width: widthSize ?? MediaQuery.of(context).size.width - 30,
      decoration: BoxDecoration(
          color: Colors.blue[100], borderRadius: BorderRadius.circular(40)),
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
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
