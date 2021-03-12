import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/views/task/task_employee_tile.dart';
import 'package:provider/provider.dart';

class TaskHomeList extends StatefulWidget {
  @override
  _TaskHomeListState createState() => _TaskHomeListState();
}

class _TaskHomeListState extends State<TaskHomeList> {
  @override
  Widget build(BuildContext context) {

    //Provider
    final taskHome = Provider.of<List<Task>>(context) ?? [];

    //Pass data to a Tile
    return ListView.builder(
        itemBuilder: (context, index){
          return TaskEmployeeTile(taskHomeList: taskHome[index]);
        },
      itemCount: taskHome.length,
    );
  }
}
