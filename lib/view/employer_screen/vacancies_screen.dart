import 'package:flutter/material.dart';
import 'package:innovators/data/provider_values.dart';
import 'package:innovators/view/employer_screen/vacancy_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class VacanciesScreen extends StatefulWidget {
  const VacanciesScreen({Key? key}) : super(key: key);

  @override
  State<VacanciesScreen> createState() => _VacanciesScreenState();
}

class _VacanciesScreenState extends State<VacanciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(builder: (context, provider, child) {
      return RefreshIndicator(
          onRefresh: () => provider.readVacancy(),
          child: provider.hasListOfVacancies == true
              ? Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ListView.builder(
                    itemCount: provider.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 4),
                        child: Container(
                          height: 100,
                          child: Card(
                            color: Colors.blue[100],
                            child: ListTile(
                              onTap: () {
                                print("${provider.docs[index].positionName}");
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.bottomToTop,
                                    child: VacancyDetail(
                                      vacancy: provider.docs[index],
                                    ),
                                  ),
                                );
                              },
                              minLeadingWidth: 30,
                              title: Center(
                                  child: Text(
                                '${provider.docs[index].positionName}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )),
                              leading: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amber,
                                ),
                                width: 80,
                                height: 40,
                                child: Center(
                                  child:
                                      Text('${provider.docs[index].location}'),
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 100,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: provider.docs[index].type ==
                                                  "Online"
                                              ? Colors.green
                                              : Colors.red),
                                      child: Center(
                                        child: Text(
                                          provider.docs[index].type ??
                                              'Offline',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      )),
                                  Container(
                                      width: 100,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          provider.docs[index].companyName
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                offset: Offset(0, 12),
                                color: Colors.black.withOpacity(.6),
                                spreadRadius: -9)
                          ]),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: OutlinedButton(
                    onPressed: () => provider.readVacancy(),
                    child: const Text('Refresh'),
                  ),
                ));
    });
  }
}
