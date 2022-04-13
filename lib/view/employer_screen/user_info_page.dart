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
    return RefreshIndicator(
      onRefresh: () =>
          Provider.of<ScreenIndexProvider>(context, listen: false).readUser(),
      child: Consumer<ScreenIndexProvider>(
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
                          child: Text(provider.loggedInUser?.status == 'on'
                              ? "open to work"
                              : "not searching for job"),
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
                                  return SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ListTile(
                                          title: const Text("Open to work"),
                                          leading: Radio(
                                            value: 'on',
                                            groupValue: String,
                                            onChanged: (Object? value) {
                                              setState(() {
                                                provider.loggedInUser?.status ==
                                                    "on";
                                                provider.updateStatus(
                                                    value.toString());
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text(
                                              "Not searching to job"),
                                          leading: Radio(
                                            value: 'of',
                                            groupValue: String,
                                            onChanged: (Object? value) {
                                              setState(() {
                                                provider.loggedInUser?.status ==
                                                    "off";
                                                provider.updateStatus(
                                                    value.toString());
                                              });
                                            },
                                          ),
                                        ),
                                        // ListTile(
                                        //   title:
                                        //       Text("Actively searching for job"),
                                        //   leading: Radio(
                                        //     value: statusOfEmployer
                                        //         .activelySearchingForJob,
                                        //     groupValue: statusEnum,
                                        //     onChanged: (statusOfEmployer? value) {
                                        //       setState(() {
                                        //         provider.status =
                                        //             "Actively searching for job";
                                        //         statusEnum = value;
                                        //       });
                                        //     },
                                        //   ),
                                        // ),
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
                          height: MediaQuery.of(context).size.width,
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
                                  const Padding(
                                    padding: EdgeInsets.only(left: 50),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: CircleAvatar(
                                        radius: 40.0,
                                        backgroundImage:
                                            // provider.userResumeCard?.imageLink !=
                                            //             null ||
                                            //         provider.userResumeCard
                                            //                 ?.imageLink !=
                                            //             'null'
                                            //     // ? NetworkImage(
                                            //     "${provider.userResumeCard?.imageLink}",
                                            //   )
                                            //  :
                                            NetworkImage(
                                          "https://images.pexels.com/photos/52608/pexels-photo-52608.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
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
                                            style:
                                                const TextStyle(fontSize: 20),
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
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                              "About me: \n${provider.userResumeCard?.about}"),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
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
                        child: provider.userResumeCard == null
                            ? Center(
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
                                              builder: (context) =>
                                                  ResumeForm(),
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        "Refresh",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      onPressed: () {
                                        provider.readUser();
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
      ),
    );
  }
}
