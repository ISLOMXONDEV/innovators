import 'package:flutter/material.dart';

class ServiceMainScreen extends StatefulWidget {
  const ServiceMainScreen({Key? key}) : super(key: key);

  @override
  State<ServiceMainScreen> createState() => _ServiceMainScreenState();
}

class _ServiceMainScreenState extends State<ServiceMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ServiceMainScreen'),
      ),
    );
  }
}
