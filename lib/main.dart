import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:innovators/route.dart';
import 'package:innovators/view/on_boarding/onboarding_screen.dart';
import 'package:innovators/view/splash_page/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/provider_values.dart';
import 'data/core.dart';

int? isViewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt(ISVIEWED);
  runApp(ChangeNotifierProvider(
      create: (context) => ScreenIndexProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:
          isViewed != 0 ? OnboardScreen.routeName : SplashScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
