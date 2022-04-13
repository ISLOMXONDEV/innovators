import 'package:flutter/material.dart';
import 'package:innovators/view/views.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              WelcomeScreen.routeName,
            );
            // Navigator.pop(context);
          },
          child: const Text('Oops your internet connection is bad'),
        ),
      ),
    );
  }
}
