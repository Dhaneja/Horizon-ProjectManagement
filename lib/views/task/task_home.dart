import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/services/database_task.dart';
import 'package:horizon/views/task/task_list.dart';
import 'package:provider/provider.dart';

class TaskHome extends StatelessWidget {

  TaskHome(this.projectValue);
  final String projectValue;


  /*
  String projectValue;
  ProjectForm({this.projectValue});*/


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
        value: ProjectDatabaseService(pid: projectValue).horizonTasks,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
            title: Text('Tasks'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  /*color: Colors.black,*/
                  /*label: Text('Add'),*/
                  onPressed: () async {

                  }
              ),
              IconButton(
                  icon: Icon(Icons.settings),
                  /*color: Colors.black,*/
                  /*label: Text('Add'),*/
                  onPressed: ()  {

                  }
              ),
            ]
        ),
        body: TaskList(),
      ),
    );
  }
}
