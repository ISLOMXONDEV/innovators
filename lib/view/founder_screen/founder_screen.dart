import 'package:flutter/material.dart';

class FounderMainScreen extends StatefulWidget {
  const FounderMainScreen({Key? key}) : super(key: key);

  @override
  State<FounderMainScreen> createState() => _FounderMainScreenState();
}

class _FounderMainScreenState extends State<FounderMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FounderMainScreen'),
      ),
    );
  }
}
