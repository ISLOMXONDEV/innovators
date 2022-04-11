import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/data/provider_values.dart';
import 'package:innovators/view/founder_screen/project_form.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../all_users_general_components/drawer.dart';

class FounderInfoWidget extends StatefulWidget {
  const FounderInfoWidget({Key? key}) : super(key: key);

  @override
  State<FounderInfoWidget> createState() => _FounderInfoWidgetState();
}

class _FounderInfoWidgetState extends State<FounderInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(builder: (context, provider, child) {
      var image = provider.project?.avatarImage;
      print(image);
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: provider.hasProject
            ? Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.blueGrey[200],
                            // : Colors.orangeAccent[200],
                            child: Image.network(
                              //  provider.project?.avatarImage == "null"
                              //      ?
                              "https://images.pexels.com/photos/3913031/pexels-photo-3913031.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
                              //     : "${provider.project?.avatarImage}",
                              ,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 80, 10, 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://images.pexels.com/photos/3831136/pexels-photo-3831136.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
                                            // image == null
                                            //    ?

                                            //: "${provider.project?.avatarImage}",
                                            ),
                                      ),
                                      title: Align(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Tg acc: ${provider.project?.tgAccount} \ne-mail: ${provider.project?.founder}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Founder',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[400]),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${provider.project?.foundData}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[400]),
                                  ),
                                ],
                              ),
                              const Text(
                                'Details:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${provider.project?.details}",
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.blueAccent),
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Text('Go to chat  '),
                                  Icon(Icons.mark_chat_read_outlined)
                                ],
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Colors.blueAccent),
                              onPressed: () {},
                              child: const Text('See Vacancies'),
                            )
                          ],
                        )
                        // SizedBox(
                        //   height: 60,
                        //   child: ListView.builder(
                        //     itemBuilder: (context, index) {
                        //       return ListTile(
                        //         leading: CircleAvatar(
                        //           backgroundImage: NetworkImage(
                        //             "${provider.project.avatarImage}",
                        //           ),
                        //         ),
                        //         title: Text(
                        //           "${provider.project.employers![index]!.firstName} ${provider.project.employers![0]!.secondName}"
                        //               .toString(),
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.grey[700]),
                        //         ),
                        //         subtitle: Text(
                        //           '${provider.project.employers![index]!.email}',
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.grey[400]),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 140,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${provider.project?.projectsName}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Icon(
                                  Icons.security,
                                  color: Colors.grey[500],
                                  size: 30,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${provider.project?.foundData}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                    letterSpacing: 0.7,
                                  ),
                                ),
                                Text(
                                  "${provider.project!.segment}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500],
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "${provider.project!.address}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[400],
                                    letterSpacing: 0.8,
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
              )
            : Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectForm(),
                        ));
                  },
                  child: const Text("You dont have a project"),
                ),
              ),
      );
    });
  }
}
