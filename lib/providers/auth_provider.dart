import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider  extends ChangeNotifier{

  User? user;
  UserModel? userModel;

  void authProvider() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      initUser();
    }
  }

  void initUser() async {
    userModel = await FirebaseFunctions.getUser();
    notifyListeners();
  }
}