import 'package:flutter/material.dart';

class TasksModel extends ChangeNotifier {
  List<String> toDoList = ["To-Do task 1"];
  List<String> inProgressList = ["in progress task 1"];
  List<String> doneList = ["done task 1"];


  void transfer_from_toDoList_to_inProgress(String task) {
    toDoList.remove(task);
    inProgressList.add(task);
    notifyListeners();
  }

  void transfer_from_inProgress_to_done(String task) {
    inProgressList.remove(task);
    doneList.add(task);
    notifyListeners();
  }

  void transfer_from_doneList_to_inProgress(String task) {
    doneList.remove(task);
    inProgressList.add(task);
    notifyListeners();
  }
  void transfer_from_inProgress_to_toDo(String task) {
    inProgressList.remove(task);
    toDoList.add(task);
    notifyListeners();
  }



// Add, Remove, or Move tasks methods here
// Call notifyListeners() after modifying the lists
}