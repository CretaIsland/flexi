import 'package:flutter/material.dart';

class FlexiPageManager extends ChangeNotifier {

  String _currentPageName = "/device/list";
  String get currentPageName => _currentPageName;

  // switch page
  void switchPage(String pageName) {
    _currentPageName = pageName;
    notifyListeners();
  }

}