import 'package:flutter/material.dart';

class TasksModel extends ChangeNotifier {
  List<String> todoList = [
    "To-Do task 1 From provider",
    "To-Do task 2 From provider",
  ];
  List<String> inProgressList = ["in progress task 1"];
  List<String> doneList = ["done task 1"];
//TODO: I have to fix checkboxes...
  Map<String, bool> checked = {};

  TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void addTaskToList(List<String> list) {
    String newTask = taskController.text.trim();
    if (newTask.isNotEmpty) {
      list.add(newTask);
      taskController.clear();
      notifyListeners();
    }
  }

  void moveTaskFromTo(String task, List<String> listFrom, List<String> listTo) {
    listFrom.remove(task);
    listTo.add(task);
    notifyListeners();
  }

  void clearList(List<String> list) {
    list.clear();
    checked.clear();
    notifyListeners();
  }

  void toggleTaskStatus(String task, bool isChecked) {
    checked[task] = isChecked;
    notifyListeners();
  }
}
