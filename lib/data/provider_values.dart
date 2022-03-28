import 'package:flutter/cupertino.dart';

class ScreenIndexProvider extends ChangeNotifier {
  int? screenIndex = 0;

  void updateIndex(int? number) {
    screenIndex = number;
    notifyListeners();
  }
}
