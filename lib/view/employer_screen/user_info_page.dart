import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innovators/data/core.dart';
import 'package:innovators/data/models/user_model.dart';
import 'package:innovators/data/provider_values.dart';
import 'package:innovators/view/employer_screen/resume_form.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 50),
                      child: Text(
                        '${provider.loggedInUser?.firstName}',
                        style: const TextStyle(
                            fontSize: 30, fontFamily: "Times new roman"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextButton(
                        child: Text(provider.status),
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                statusOfEmployer? statusEnum =
                                    statusOfEmployer.openToWork;

                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ListTile(
                                        title: Text(provider.status),
                                        leading: Radio(
                                          value: statusOfEmployer.openToWork,
                                          groupValue: statusEnum,
                                          onChanged: (statusOfEmployer? value) {
                                            setState(() {
                                              provider.status = "open to work";
                                              statusEnum = value;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(provider.status),
                                        leading: Radio(
                                          value:
                                              statusOfEmployer.notSearchingWork,
                                          groupValue: statusEnum,
                                          onChanged: (statusOfEmployer? value) {
                                            setState(() {
                                              provider.status =
                                                  "not searching to job ";
                                              statusEnum = value;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(provider.status),
                                        leading: Radio(
                                          value: statusOfEmployer
                                              .activelySearchingForJob,
                                          groupValue: statusEnum,
                                          onChanged: (statusOfEmployer? value) {
                                            setState(() {
                                              provider.status =
                                                  "Actively searching for job";
                                              statusEnum = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              provider.hasResume
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 30,
                        height: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            "${provider.userResumeCard?.positionName}",
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontFamily: "arial",
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${provider.userResumeCard?.dateOfBirth}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: "arial",
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${provider.userResumeCard?.universityName} student",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: "arial",
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${provider.userResumeCard?.tellNumber}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: "arial",
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${provider.userResumeCard?.email}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: "arial",
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "${provider.userResumeCard?.social?.replaceAll(',', '\n')}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: "arial",
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage: NetworkImage(
                                        "${provider.userResumeCard?.imageLink}",
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // provider.userResumeCard
                            const Divider(
                              indent: 20,
                              endIndent: 20,
                              thickness: 2,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(23.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Experience',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          '${provider.userResumeCard?.experience}',
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 25.0),
                                        child: Text(
                                          'Skills:',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 20),
                                        child: Text(
                                          '${provider.userResumeCard?.skills?.replaceAll(',', '\n')}',
                                          maxLines: 20,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 38.0),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text("See Resume file "),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 150.0),
                      child: Center(
                        child: Column(
                          children: [
                            TextButton(
                              child: const Text(
                                "You don't have a resume",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResumeForm(),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
