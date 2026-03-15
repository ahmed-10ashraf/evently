import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/models/task_model.dart';
import 'package:flutter/material.dart';

class DetailsProvider extends ChangeNotifier{

  TaskModel? taskModel;

  getTaskDetails(TaskModel task) async {
    var model = await FirebaseFunctions.getTask(task);
    taskModel = model.data();
    notifyListeners();
  }

  deleteTask(TaskModel task) async {
    await FirebaseFunctions.deleteTask(task);
    notifyListeners();
  }

  String getDate() {
    DateFormat formatter = DateFormat('dd MMMM');
    DateTime tempDate = DateTime.fromMillisecondsSinceEpoch(taskModel!.date);
    return formatter.format(tempDate);
  }

  String getTime(){
    String timeString = taskModel!.time.substring(10, 15);
    DateTime tempDate = DateFormat("HH:mm").parse(timeString);
    String formattedTime = DateFormat("h:mm a").format(tempDate); // Output: 2:30 PM
    return formattedTime;
  }
}