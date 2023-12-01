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

  void addTaskToTodo() {
    String newTask = taskController.text.trim();
    if (newTask.isNotEmpty) {
      toDoList.add(newTask);
      taskController.clear();
      notifyListeners();
    }
  }

  void addTaskToInProgress() {
    String newTask = taskController.text.trim();
    if (newTask.isNotEmpty) {
      inProgressList.add(newTask);
      taskController.clear();
      notifyListeners();
    }
  }

  void addTaskToDone() {
    String newTask = taskController.text.trim();
    if (newTask.isNotEmpty) {
      doneList.add(newTask);
      taskController.clear();
      notifyListeners();
    }
  }


  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void moveTodoTaskToInProgress(String task) {
    toDoList.remove(task);
    inProgressList.add(task);
    notifyListeners();
  }

  void moveInProgressTaskToDone(String task) {
    inProgressList.remove(task);
    doneList.add(task);
    notifyListeners();
  }

  void moveDoneTaskToInProgress(String task) {
    doneList.remove(task);
    inProgressList.add(task);
    notifyListeners();
  }

  void moveInProgressTaskToTodo(String task) {
    inProgressList.remove(task);
    toDoList.add(task);
    notifyListeners();
  }

  void clearTodoTasks() {
    toDoList.clear();
    checked.clear();
    notifyListeners();
  }

  void clearInProgressTasks(){
    inProgressList.clear();
    notifyListeners();
  }

  void clearDoneTasks(){
    doneList.clear();
    notifyListeners();
  }

  void toggleTaskStatus(String task, bool isChecked) {
    checked[task] = isChecked;
    notifyListeners();
  }

}
