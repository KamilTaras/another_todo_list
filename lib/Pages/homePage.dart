import 'package:flutter/material.dart';
import 'donePage.dart';
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
            ToDoTasksPage(),
            InProgressTasksPage(),
            DoneTasksPage()
          ],
        ),
      ),
    );
  }
}
