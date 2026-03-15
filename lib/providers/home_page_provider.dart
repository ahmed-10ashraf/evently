import 'dart:async';
import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/models/task_model.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<String> categories = [
    'All',
    'Birthday',
    'Meeting',
    'Book Club',
    'Exhibition',
    'Sport',
  ];

  List<TaskModel> events = [];

  bool isLoading = false;
  String errorMassage = '';
  StreamSubscription? streamSubscription;

  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    getStreamTasks();
    notifyListeners();
  }

  deleteTask(int index) async {
    FirebaseFunctions.deleteTask(events[index]);
    events.removeAt(index);
    notifyListeners();
  }

  getStreamTasks() {
    if(streamSubscription != null) {
      streamSubscription!.cancel();
    }
    streamSubscription = FirebaseFunctions.getStreamTasks(
      category: selectedIndex == 0 ? null : categories[selectedIndex],
    ).listen((event) {
      events = event.docs.map((e) => e.data()).toList();
      notifyListeners();
    });
  }

  getTasks() async {
    isLoading = true;

    try {
      var list = await FirebaseFunctions.getTasks();
      events = list.docs.map((e) => e.data()).toList();
    } catch (e) {
      errorMassage = e.toString();
      print('Error : ${e.toString()}');
    }
    isLoading = false;
    notifyListeners();
  }
}
