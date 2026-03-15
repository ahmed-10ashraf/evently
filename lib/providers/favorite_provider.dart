import 'dart:async';
import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/models/task_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier{
  bool isLoading = false;
  String errorMassage = '';
  List<TaskModel> tasks = [];
  StreamSubscription? streamSubscription;

  getFavoriteTasks() {
    if(streamSubscription != null) {
      streamSubscription!.cancel();
    }
    streamSubscription = FirebaseFunctions.getFavoriteTasks().listen((event) {
      tasks = event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }
}