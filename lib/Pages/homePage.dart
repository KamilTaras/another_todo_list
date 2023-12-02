import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../taskModel.dart';
import 'genericTaskPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

//TODO: Work on middle page to define effect on left and right side
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TasksModel>(context, listen: false);
    var todoList = model.todoList;
    var inProgressList = model.inProgressList;
    var doneList = model.doneList;


    var todoTasksPage = GenericTaskPage(
      pageTitle: 'To-Do Tasks',
      taskList: todoList,

      //Todo: Safely remove this (String _)
      addTaskCallback: (String _) {
        model.addTaskToList(todoList);
      },
      clearTasksCallback: () {
        model.clearList(todoList);
      },
      onTaskDismissed: (String task) {
        model.moveTaskFromTo(task,todoList,inProgressList);
      },
    );

    var inProgressPage = GenericTaskPage(
      pageTitle: 'In Progress Tasks',
      taskList: inProgressList,
      addTaskCallback: (String _) {
        model.addTaskToList(inProgressList);

      },
      clearTasksCallback: () {
        model.clearList(inProgressList);
      },
      onTaskDismissed: (String task) {
        model.moveTaskFromTo(task,inProgressList,todoList);
      },
    );

    var donePage = GenericTaskPage(
      pageTitle: 'Done Tasks',
      taskList: doneList,
      addTaskCallback: (String _) {
        model.addTaskToList(doneList);
      },
      clearTasksCallback: () {
        model.clearList(inProgressList);
      },
      onTaskDismissed: (String task) {
        model.moveTaskFromTo(task,doneList,inProgressList);
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
