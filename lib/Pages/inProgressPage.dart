import 'package:another_todo_list/taskModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InProgressTasksPage extends StatefulWidget {
  const InProgressTasksPage({super.key});

  @override
  State<InProgressTasksPage> createState() => _InProgressTasksPageState();
}

class _InProgressTasksPageState extends State<InProgressTasksPage> with AutomaticKeepAliveClientMixin {

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
        itemCount: model.inProgressList.length,
        itemBuilder: (context, index) =>
            Dismissible(
              key: UniqueKey(),
              onDismissed: (dismissDirection) {
                model.transfer_from_inProgress_to_toDo(model.inProgressList[index]);
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
          model.addTaskTo_todoList();
        },
      ),
    );
  }

  CheckboxListTile textWithCheckbox(BuildContext context, int index) {
    final model = Provider.of<TasksModel>(context);
    String task = model.inProgressList[index];
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


  Widget bottomButtons(BuildContext context) {
    final model = Provider.of<TasksModel>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: model.addTaskTo_InProgressList,
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
              TextButton.styleFrom(),
              child: const Text('No', style: TextStyle(color: Colors.black54)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red.shade200),
              child: const Text('Yes', style: TextStyle(color: Colors.black54)),
              onPressed: () {
                model.clearTasks(); // Clear tasks using model
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

