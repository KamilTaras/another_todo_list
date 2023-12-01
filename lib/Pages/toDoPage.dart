import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../taskModel.dart';

class ToDoTasksPage extends StatelessWidget {
  const ToDoTasksPage({super.key});

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          listOfTasks(context),
          Divider(),
          userInput(context),
          Divider(),
          bottomButtons(context),
        ],
      ),
    );
  }

  Flexible listOfTasks(BuildContext context) {
    final model = Provider.of<TasksModel>(context, listen: true);
    return Flexible(
      child: ListView.builder(
        itemCount: model.toDoList.length,
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          onDismissed: (dismissDirection) {
            model.moveTodoTaskToInProgress(model.toDoList[index]);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Task moved to in progress')),
            );
          },
          child: ListTile(
            title: Card(
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: textWithCheckbox(context, index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding userInput(BuildContext context) {
    final model = Provider.of<TasksModel>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: 'Write a task to do'),
        controller: model.taskController,
        onSubmitted: (String value) {
          model.addTaskToTodo();
        },
      ),
    );
  }

  Widget  bottomButtons(BuildContext context) {
    final model = Provider.of<TasksModel>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: model.addTaskToTodo,
            child: Text("Add"),
          ),
          ElevatedButton(
            onPressed: () => dialogBuilder(context, model),
            child: Text("Delete all"),
          ),
        ],
      ),
    );
  }

  CheckboxListTile textWithCheckbox(BuildContext context, int index) {
    final model = Provider.of<TasksModel>(context);
    String task = model.toDoList[index];
    return CheckboxListTile(
      title: Text(
        task,
        style: TextStyle(
          decoration: model.checked[task] ?? false
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      value: model.checked[task] ?? false,
      onChanged: (bool? value) {
        model.toggleTaskStatus(task, value!);
      },
    );
  }

  dialogBuilder(BuildContext context, TasksModel model) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to delete all tasks?'),
          content: const Text(
              'Are you sure that you want to delete all of the tasks?'),
          actions: <Widget>[
            TextButton(
              style:
                  TextButton.styleFrom(backgroundColor: Colors.green.shade200),
              child: const Text('No', style: TextStyle(color: Colors.black54)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red.shade200),
              child: const Text('Yes', style: TextStyle(color: Colors.black54)),
              onPressed: () {
                model.clearTodoTasks(); // Clear tasks using model
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
