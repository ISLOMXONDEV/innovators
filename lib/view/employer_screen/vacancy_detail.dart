import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovators/data/models/projects_model.dart';
import 'package:url_launcher/url_launcher.dart';

class VacancyDetail extends StatefulWidget {
  static const String routeName = '/vacancy-detailed';
  VacancyDetail({Key? key, required this.vacancy}) : super(key: key);
  Vacancy vacancy;

  @override
  State<VacancyDetail> createState() => _VacancyDetailState();
}

class _VacancyDetailState extends State<VacancyDetail> {
  bool _hasCallSupport = false;
  Future<void>? _launched;

  initState() {
    super.initState();
    canLaunch('tel:123').then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('${widget.vacancy.companyName} '),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  offset: const Offset(0, 12),
                  color: Colors.blueAccent.withOpacity(.9),
                  spreadRadius: -9)
            ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width - 25,
            height: MediaQuery.of(context).size.height - 190,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Position name:",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 20),
                      child: Container(
                        alignment: Alignment.center,
                        width: 190,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                offset: const Offset(0, 12),
                                color: Colors.blueAccent.withOpacity(.9),
                                spreadRadius: -9)
                          ],
                        ),
                        child: Text(
                          "${widget.vacancy.positionName}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Company:",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20),
                      child: Text(
                        "${widget.vacancy.companyName}",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.blueAccent,
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: Text(
                        "Email:",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20),
                      child: Container(
                        alignment: Alignment.center,
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                offset: const Offset(0, 12),
                                color: Colors.blueAccent.withOpacity(.9),
                                spreadRadius: -9)
                          ],
                        ),
                        child: Text(
                          "${widget.vacancy.contactEmail}",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 2.0,
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            "Mobile Number:",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green[900],
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    offset: const Offset(0, 12),
                                    color: Colors.green.withOpacity(.9),
                                    spreadRadius: -9)
                              ],
                            ),
                            child: Text(
                              "${widget.vacancy.contactNumber}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, left: 0),
                          child: Text(
                            "Location:",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    offset: const Offset(0, 12),
                                    color: Colors.orange.withOpacity(.9),
                                    spreadRadius: -9)
                              ],
                            ),
                            child: Text(
                              "${widget.vacancy.location}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          child: Text(
                            "Type:",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              color: widget.vacancy.type == "Online"
                                  ? Colors.red
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    offset: const Offset(0, 12),
                                    color: Colors.black.withOpacity(.5),
                                    spreadRadius: -9)
                              ],
                            ),
                            child: Text(
                              widget.vacancy.type ?? "Online",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 10),
                          child: Text(
                            "Telegram Username:",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 8),
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 20,
                                    offset: const Offset(0, 12),
                                    color: Colors.blue.withOpacity(.9),
                                    spreadRadius: -9)
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "@${widget.vacancy.telegramChatLink}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            child: Text(
                              "Details:\n\n${widget.vacancy.details}",
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 2,
                          indent: 40,
                          endIndent: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 10),
                          child: Text(
                            "Requirements:\n\n${widget.vacancy.requirements}",
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height - 600,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20,
                              offset: const Offset(0, 12),
                              color: Colors.blue.withOpacity(.5),
                              spreadRadius: -9)
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          if (widget.vacancy.telegramChatLink != null) {
                            _launchUrl(
                                "https://t.me/${widget.vacancy.telegramChatLink}");
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Founder don\'t have Telegram');
                          }
                        },
                        child: const Text(
                          "Go to chat",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: _hasCallSupport
                            ? () => setState(() {
                                  _launched = _makePhoneCall(
                                      widget.vacancy.contactNumber.toString());
                                })
                            : null,
                        child: _hasCallSupport
                            ? const Text('Make phone call')
                            : const Text('Calling not supported'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String _url) async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {}
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
