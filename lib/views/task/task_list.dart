import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/views/task/task_tile.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {

    //Provider
    final horizonTasks = Provider.of<List<Task>>(context) ?? [];

    //Pass the data to a Tile
    return ListView.builder(
        itemBuilder: (context, index){
          return TaskTile(task: horizonTasks[index]);
        },
      itemCount: horizonTasks.length,
    );

  }
}
