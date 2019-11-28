import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todoapp/blocs/user_bloc_provider.dart';
import 'package:todoapp/models/classes/task.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/models/widgets/intray_todo_widget.dart';

class IntrayPage extends StatefulWidget {
  final String apiKey;
  IntrayPage({this.apiKey});
  @override
  _IntrayPage createState() => _IntrayPage();
}

class _IntrayPage extends State<IntrayPage> {
  List<Task> taskList = [];
  TaskBloc tasksBloc;

  @override
  void initState() {
    tasksBloc = TaskBloc(widget.apiKey);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: darkGrayColor,
        child: StreamBuilder(
          stream: tasksBloc.getTasks,
          initialData: [],
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot != null) {
              if (snapshot.data.length > 0) {
                return _buildReorderableList(context, snapshot.data);
              }
              else if (snapshot.data.length == 0){
                  return Center(child: Text("No Task"));
              }else if(snapshot.hasError){
                return Container();
              }
              
              return CircularProgressIndicator();
            }
           
            // taskList = snapshot.data;
            return _buildReorderableList(context, snapshot.data);
          },
        ));
  }

  Widget _buildListTitle(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId.toString()),
      title: IntrayTodo(title: item.title),
    );
  }

  Widget _buildReorderableList(BuildContext context, List<Task> taskList) {
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

  // Future<List<Task>> getList() async {
  //   List<Task> tasks = await taskBloc.getUserTasks(widget.apiKey);
  //   return tasks;

  // }
}
