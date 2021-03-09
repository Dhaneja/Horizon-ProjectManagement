import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/services/database_task.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';

class TaskForm extends StatefulWidget {

  String taskValue;
  TaskForm({this.taskValue});

  @override
  _TaskFormState createState() => _TaskFormState(taskValue);
}

class _TaskFormState extends State<TaskForm> {

  String taskValue;
  _TaskFormState(this.taskValue);

  final _formKey = GlobalKey<FormState>();
  final List<String> assignedEmployee = [];

  String _tid;
  String _tName;
  String _tStatus;
  String _tEmployee;
  String _tProjectId;


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<Task>(
      stream: TaskDatabaseService(tid:taskValue).taskData,
        builder: (context, snapshot){
        if(snapshot.hasData){

          Task task = snapshot.data;

          return Form(
            key: _formKey,
              child:Column(
                children: <Widget>[
                  Text(
                    'Task',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: task.taskName,
                    decoration: textInputStyle.copyWith(hintText: task.taskName),
                    validator: (val) => val.isEmpty ? 'Please Enter Task Name' : null,
                    onChanged: (val) => setState(() => _tName = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    decoration: textInputStyle.copyWith(hintText: task.taskStatus),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: task.taskEmployee,
                    decoration: textInputStyle.copyWith(hintText: task.taskEmployee),
                    validator: (val) => val.isEmpty ? 'Please Enter Assigned Employee' : null,
                    onChanged: (val) => setState(() => _tEmployee = val),
                  ),


                  RaisedButton(
                      color: Colors.lightGreen,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        try{
                          if(_formKey.currentState.validate()){
                            await TaskDatabaseService(tid: taskValue)
                                .updateTaskData(
                                _tid ?? task.taskId,
                                _tName ?? task.taskName,
                                _tStatus ?? task.taskStatus,
                                _tEmployee ?? task.taskEmployee,
                                _tProjectId ?? task.projectId
                            );
                            Navigator.pop(context);
                          }
                        }catch(error){
                          print(error);
                        }
                      }
                  ),
                ],
              ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}
