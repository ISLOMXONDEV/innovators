import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/provider_values.dart';

class MyServices extends StatefulWidget {
  const MyServices({Key? key}) : super(key: key);

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
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
    return Consumer<ScreenIndexProvider>(
      builder: (context, provider, child) {
        return RefreshIndicator(
          onRefresh: () => provider.readServices(),
          child: provider.hasPosts == true
              ? Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ListView.builder(
                    itemCount: provider.myServices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 5.0, right: 5, top: 4),
                        child: Container(
                          height: 350,
                          child: Card(
                            color: Colors.green[50],
                            child: ListTile(
                              minLeadingWidth: 30,
                              title: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 20,
                                                      offset:
                                                          const Offset(0, 12),
                                                      color: Colors.amber
                                                          .withOpacity(.6),
                                                      spreadRadius: -9)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.amber,
                                              ),
                                              width: 80,
                                              height: 40,
                                              child: Center(
                                                child: Text(
                                                  '${provider.myServices[index].serviceName}',
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 20,
                                                    offset: const Offset(0, 12),
                                                    color: Colors.black
                                                        .withOpacity(.6),
                                                    spreadRadius: -9)
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white),
                                          child: Center(
                                            child: Text(
                                              provider.myServices[index]
                                                  .serviceProvider
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Details:\n\n${provider.myServices[index].serviceDetails}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, right: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Location:\n${provider.myServices[index].serviceLocation}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Container(
                                              width: 100,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.lightBlue,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 20,
                                                      offset:
                                                          const Offset(0, 12),
                                                      color: Colors.blue
                                                          .withOpacity(.9),
                                                      spreadRadius: -9)
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${provider.myServices[index].serviceTgAccount}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              if (provider.myServices[index]
                                                      .serviceTgAccount !=
                                                  null) {
                                                _launchUrl(
                                                    "https://t.me/${provider.myServices[index].serviceTgAccount}");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Founder don\'t have Telegram');
                                              }
                                            },
                                            child: const Text(
                                              "Go to chat",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                                          provider
                                                              .myServices[index]
                                                              .serviceContactNumber
                                                              .toString());
                                                    })
                                                : null,
                                            child: _hasCallSupport
                                                ? const Text(
                                                    'Call',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : const Text(
                                                    'Calling not\n supported',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green[600],
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 20,
                                            offset: const Offset(0, 12),
                                            color: Colors.green.withOpacity(.9),
                                            spreadRadius: -9)
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "\$ ${provider.myServices[index].servicePayment} monthly",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green[900],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+${provider.myServices[index].serviceContactNumber}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 20,
                                  offset: const Offset(0, 12),
                                  color: Colors.black.withOpacity(.6),
                                  spreadRadius: -9)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: OutlinedButton(
                    onPressed: () => provider.readServices(),
                    child: const Text('Refresh'),
                  ),
                ),
        );
      },
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
