import 'package:flutter/material.dart';

class IntroProvider extends ChangeNotifier{
  int currentPageIndex = 0;

  void changePage (int val){
    currentPageIndex = val;
    notifyListeners();
  }
}