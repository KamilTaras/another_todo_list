import 'package:flutter/material.dart';

class ToDoTasksPage extends StatefulWidget {
  const ToDoTasksPage({super.key});

  @override
  State<ToDoTasksPage> createState() => _ToDoTasksPageState();
}

class _ToDoTasksPageState extends State<ToDoTasksPage>
    with AutomaticKeepAliveClientMixin {
  // static List<String> toDoList = ["To-Do task 1"];
  Map<String, bool> checked = {};

  @override
  bool get wantKeepAlive => true;

  // @override
  // void initState() {
  //   super.initState();
  //   for (var taskIndex in toDoList) {
  //     checked[taskIndex] = false;
  //   }
  // }

  TextEditingController controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          listOfTasks(),
          Divider(),
          userInput(),
          Divider(),
          bottomButtons(),
        ],
      ),
    );
  }

  Flexible listOfTasks() {
    return Flexible(
        child: ListView.builder(
      itemCount: toDoList.length,
      itemBuilder: (context, index) => Dismissible(
        key: UniqueKey(),
        child: ListTile(
          title: SizedBox(
            // height: 50,
            child: Card(
                color: Colors.deepPurple.shade50,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: textWithCheckbox(index),
                    ))),
          ),
        ),
        onDismissed: (dismissDirection) {
          setState(() {
            toDoList.removeAt(index);
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Task number ${index + 1} dismissed')));
        },
      ),
    ));
  }

  Padding userInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextField(
          decoration:
              new InputDecoration.collapsed(hintText: 'Write a task to do'),
          controller: controller1,
          onSubmitted: (String value) {
            setState(() {
              // Add the task to the list
              toDoList.add(value.trim());
              // Clear the text field
              controller1.clear();
            });
          },
        ),
      ),
    );
  }

  Widget bottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                toDoList.add(controller1.text);
                controller1.clear();
              });
            },
            child: Text("Add")),
        ElevatedButton(
            onPressed: () => dialogBuilder(context), child: Text("Delete all"))
      ]),
    );
  }

  CheckboxListTile textWithCheckbox(int index) {
    return CheckboxListTile(
        title: Text(
          toDoList[index],
          style: TextStyle(
            decoration: checked[toDoList[index]] ?? false
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        value: checked[toDoList[index]] ?? false,
        onChanged: (bool? value) {
          setState(() {
            checked[toDoList[index]] = value!;
          });
        });
  }

  dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to delete all tasks?'),
          content: const Text(
              'Are you sure that you want to delete all of the tasks?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade200,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red.shade200,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                setState(() {
                  toDoList.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
