import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../taskModel.dart';

class GenericTaskPage extends StatelessWidget {
  final String pageTitle;
  final List<String> taskList;
  final Function(String) addTaskCallback;
  final Function clearTasksCallback;
  final Function(String) onTaskDismissed;

  const GenericTaskPage({
    Key? key,
    required this.pageTitle,
    required this.taskList,
    required this.addTaskCallback,
    required this.clearTasksCallback,
    required this.onTaskDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TasksModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body: Column(
        children: [
          Expanded(
            child: TasksList(
              tasks: taskList,
              onDismissed: onTaskDismissed,
            ),
          ),
          Divider(),
          TextInputField(
            hintText: 'Write a task...',
            controller: model.taskController,
            onSubmit: (value) => addTaskCallback(value),
          ),
          Divider(),
          ActionButtons(
            onAddPressed: () => addTaskCallback(model.taskController.text),
              onDeleteAllPressed: () => DialogHelper.showDeleteConfirmationDialog(
                context,
                model,
                    () {
                  clearTasksCallback();
                  Navigator.of(context).pop();
                },
              ),
          ),
        ],
      ),
    );
  }
}

class DialogHelper {
  static void showDeleteConfirmationDialog(
      BuildContext context, TasksModel model, VoidCallback onConfirm) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Do you want to delete all tasks?',
          content: 'Are you sure that you want to delete all of the tasks?',
          onConfirm: onConfirm,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}

class TasksList extends StatelessWidget {
  final List<String> tasks;
  final Function(String) onDismissed;
  final bool isChecked;

  const TasksList({
    Key? key,
    required this.tasks,
    required this.onDismissed,
    this.isChecked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (_) => onDismissed(tasks[index]),
          child: ListTile(
            title: Card(
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CheckboxListTile(
                  title: Text(
                    tasks[index],
                    style: TextStyle(
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  value: isChecked,
                  onChanged: (bool? value) {
                    // Your toggle logic here
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onSubmit;

  const TextInputField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: hintText),
        controller: controller,
        onSubmitted: onSubmit,
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onAddPressed;
  final VoidCallback onDeleteAllPressed;

  const ActionButtons({
    Key? key,
    required this.onAddPressed,
    required this.onDeleteAllPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: onAddPressed,
            child: Text("Add"),
          ),
          ElevatedButton(
            onPressed: onDeleteAllPressed,
            child: Text("Delete all"),
          ),
        ],
      ),
    );
  }
}


class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text('No', style: TextStyle(color: Colors.black54)),
          onPressed: onCancel,
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.red.shade200),
          child: const Text('Yes', style: TextStyle(color: Colors.black54)),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}





