import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/core.dart';
import '../../../data/provider_values.dart';
import '../../login/login_screen.dart';

class BottomUserInfo extends StatelessWidget {
  final bool isCollapsed;

  const BottomUserInfo({
    Key? key,
    required this.isCollapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenIndexProvider>(builder: (context, provider, child) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: isCollapsed ? 70 : 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
        ),
        child: isCollapsed
            ? Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: provider.userResumeCard?.imageLink != null
                              ? Image.network(
                                  "${provider.userResumeCard!.imageLink.toString()}",
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "https://images.pexels.com/photos/8294560/pexels-photo-8294560.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "${provider.loggedInUser?.firstName}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${provider.loggedInUser?.secondName}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            logout(context);
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: provider.userResumeCard?.imageLink != null
                            ? Image.network(
                                "${provider.userResumeCard!.imageLink.toString()}",
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://images.pexels.com/photos/8294560/pexels-photo-8294560.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        logout(context);
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(USER_MODE));
    prefs.remove(USER_MODE);

    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.routeName, ModalRoute.withName('/'));
  }
}
