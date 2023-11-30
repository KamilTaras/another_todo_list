import 'package:flutter/material.dart';

class TasksModel extends ChangeNotifier {
  List<String> toDoList = [
    "To-Do task 1 From provider",
    "To-Do task 2 From provider",
  ];
  List<String> inProgressList = ["in progress task 1"];
  List<String> doneList = ["done task 1"];

  Map<String, bool> checked = {};

  TextEditingController taskController = TextEditingController();

  void addTaskTo_todoList() {
    String newTask = taskController.text.trim();
    if (newTask.isNotEmpty) {
      toDoList.add(newTask);
      taskController.clear();
      notifyListeners();
    }
  }

  void addTaskTo_InProgressList() {
    String newTask = taskController.text.trim();
    if (newTask.isNotEmpty) {
      inProgressList.add(newTask);
      taskController.clear();
      notifyListeners();
    }
  }

  void addTaskTo_DoneList() {
    String newTask = taskController.text.trim();
    if (newTask.isNotEmpty) {
      doneList.add(newTask);
      taskController.clear();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Dispose the controller when the model is disposed
    taskController.dispose();
    super.dispose();
  }

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

  void clearTasks() {
    toDoList.clear();
    checked.clear();
    notifyListeners();
  }

  void toggleTaskStatus(String task, bool isChecked) {
    checked[task] = isChecked;
    notifyListeners();
  }
// Add, Remove, or Move tasks methods here
// Call notifyListeners() after modifying the lists
}
