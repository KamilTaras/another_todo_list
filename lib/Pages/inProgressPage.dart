import 'package:another_todo_list/taskModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InProgressTasksPage extends StatelessWidget {
  const InProgressTasksPage({super.key,});

 // for constructor -> listtype
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
                model.moveInProgressTaskToTodo(model.inProgressList[index]);
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
     TasksModel model = Provider.of<TasksModel>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration.collapsed(hintText: 'Write a task to do'),
        controller: model.taskController,
        onSubmitted: (String value) {
          model.addTaskToInProgress();
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
            onPressed: model.addTaskToInProgress,
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
// class TasksList extends StatelessWidget {
//   final List<String> tasks;
//   final Function(String) onDismissed;
//   final bool isChecked;
//
//   const TasksList({
//     Key? key,
//     required this.tasks,
//     required this.onDismissed,
//     this.isChecked = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         return Dismissible(
//           key: UniqueKey(),
//           onDismissed: (_) => onDismissed(tasks[index]),
//           child: ListTile(
//             title: Card(
//               color: Colors.deepPurple.shade50,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 child: CheckboxListTile(
//                   title: Text(
//                     tasks[index],
//                     style: TextStyle(
//                       decoration: isChecked
//                           ? TextDecoration.lineThrough
//                           : TextDecoration.none,
//                     ),
//                   ),
//                   value: isChecked,
//                   onChanged: (bool? value) {
//                     // Your toggle logic here
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class TextInputField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final Function(String) onSubmit;
//
//   const TextInputField({
//     Key? key,
//     required this.hintText,
//     required this.controller,
//     required this.onSubmit,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         decoration: InputDecoration.collapsed(hintText: hintText),
//         controller: controller,
//         onSubmitted: onSubmit,
//       ),
//     );
//   }
// }
//
// class ActionButtons extends StatelessWidget {
//   final VoidCallback onAddPressed;
//   final VoidCallback onDeleteAllPressed;
//
//   const ActionButtons({
//     Key? key,
//     required this.onAddPressed,
//     required this.onDeleteAllPressed,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           ElevatedButton(
//             onPressed: onAddPressed,
//             child: Text("Add"),
//           ),
//           ElevatedButton(
//             onPressed: onDeleteAllPressed,
//             child: Text("Delete all"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class ConfirmationDialog extends StatelessWidget {
//   final String title;
//   final String content;
//   final VoidCallback onConfirm;
//   final VoidCallback onCancel;
//
//   const ConfirmationDialog({
//     Key? key,
//     required this.title,
//     required this.content,
//     required this.onConfirm,
//     required this.onCancel,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: <Widget>[
//         TextButton(
//           child: const Text('No', style: TextStyle(color: Colors.black54)),
//           onPressed: onCancel,
//         ),
//         TextButton(
//           style: TextButton.styleFrom(backgroundColor: Colors.red.shade200),
//           child: const Text('Yes', style: TextStyle(color: Colors.black54)),
//           onPressed: onConfirm,
//         ),
//       ],
//     );
//   }
// }
//
//
