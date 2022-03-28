import 'package:flutter/material.dart';
import 'package:innovators/view/login/login_screen.dart';
import 'package:innovators/view/login/registration_screen.dart';
import 'package:innovators/view/on_boarding/onboarding_screen.dart';
import 'view/views.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => OnboardScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RegistrationScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case WelcomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
