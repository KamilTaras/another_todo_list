import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../taskModel.dart';
import 'donePage.dart';
import 'genericTaskPage.dart';
import 'inProgressPage.dart';
import 'toDoPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TasksModel>(context, listen: false);

    var todoTasksPage = GenericTaskPage(
      pageTitle: 'To-Do Tasks',
      taskList: model.toDoList,
      addTaskCallback: (String _) {
        model.addTaskToTodo();
      },
      clearTasksCallback: () {
        model.clearTodoTasks();
      },
      onTaskDismissed: (String task) {
        model.moveTodoTaskToInProgress(task);
      },
    );

    var inProgressPage = GenericTaskPage(
      pageTitle: 'To-Do Tasks',
      taskList: model.inProgressList,
      addTaskCallback: (String _) {
        model.addTaskToInProgress();
      },
      clearTasksCallback: () {
        model.clearInProgressTasks();
      },
      onTaskDismissed: (String task) {
        model.moveInProgressTaskToTodo(task);
      },
    );

    var donePage = GenericTaskPage(
      pageTitle: 'To-Do Tasks',
      taskList: model.inProgressList,
      addTaskCallback: (String _) {
        model.addTaskToInProgress();
      },
      clearTasksCallback: () {
        model.clearInProgressTasks();
      },
      onTaskDismissed: (String task) {
        model.moveInProgressTaskToTodo(task);
      },
    );
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Another ToDo list"),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.assignment),
              ),
              Tab(
                icon: Icon(Icons.loop),
              ),
              Tab(
                icon: Icon(Icons.check_circle),
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            todoTasksPage,
            inProgressPage,
            donePage
          ],
        ),
      ),
    );
  }
}
