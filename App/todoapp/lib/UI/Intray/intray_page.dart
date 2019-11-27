import 'package:flutter/material.dart';
import 'package:todoapp/models/classes/task.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/models/widgets/intray_todo_widget.dart';

class IntrayPage extends StatefulWidget {
  @override
  _IntrayPage createState() => _IntrayPage();
}

class _IntrayPage extends State<IntrayPage> {
  List<Task> taskList = [];
  @override
  Widget build(BuildContext context) {
    taskList = getList();
    return Container(
      color: darkGrayColor,
      child: _buildReorderableList(context),
    );
  }

  Widget _buildListTitle(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId),
      title: IntrayTodo(title: item.title),
    );
  }

  Widget _buildReorderableList(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: ReorderableListView(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
          children: taskList
              .map((Task item) => _buildListTitle(context, item))
              .toList(),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              Task item = taskList[oldIndex];
              taskList.remove(item);
              taskList.insert(newIndex, item);
            });
          }),
    );
  }

  List<Task> getList() {
    for (int i = 0; i < 10; i++) {
      taskList.add(Task("My first task" + i.toString(), false, i.toString()));
    }
    return taskList;
  }
}
