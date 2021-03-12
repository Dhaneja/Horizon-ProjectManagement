import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/services/database_task.dart';
import 'package:horizon/views/task/task_add_form.dart';
import 'package:horizon/views/task/task_list.dart';
import 'package:provider/provider.dart';

class TaskHome extends StatelessWidget {

  //Constructor
  TaskHome(this.projectIdValue, this.projectNameValue);
  final String projectIdValue, projectNameValue;


  @override
  Widget build(BuildContext context) {

    //Popup the modalBottomSheet for Task Add Form
    void _showTaskAddPanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.65 ,
          decoration: new BoxDecoration(
            color: Colors.grey[200],
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: TaskAddForm(projectIdValue: projectIdValue, projectNameValue: projectNameValue),
        );
      });
    }

    //Stream Provider to List the Tasks using horizonTasks
    return StreamProvider<List<Task>>.value(

        //Get data from horizonTasks stream in ProjectDatabaseService
        value: ProjectDatabaseService(pid: projectIdValue).horizonTasks,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text('Tasks'),
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            actions: <Widget>[

              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {

                    //Display Modal Bottom sheet to add task
                    _showTaskAddPanel();

                  }
              ),
            ]
        ),
        body: TaskList(),
      ),
    );
  }
}
