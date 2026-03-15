import 'package:easy_localization/easy_localization.dart';
import 'package:evently_details/core/firebase_functions.dart';
import 'package:evently_details/models/task_model.dart';
import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier{

  TaskModel? taskModel;

  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  List<String> categories = [
    'Birthday',
    'Meeting',
    'Book Club',
    'Exhibition',
    'Sport',
  ];

  getTaskDetails(TaskModel task) async {
    var model = await FirebaseFunctions.getTask(task);
    taskModel = model.data();
    if (taskModel != null) {
      selectedIndex = categories.indexOf(taskModel!.category);
      if (selectedIndex == -1) selectedIndex = 0;
    }
    notifyListeners();
  }

  void changeIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }

  void changeDate(DateTime date){
    selectedDate = date;
    notifyListeners();
  }

  void changeTime(TimeOfDay time){
    selectedTime = time;
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

  editEvent(TaskModel taskModel) async {
    await FirebaseFunctions.updateTask(taskModel);
    notifyListeners();
  }
}