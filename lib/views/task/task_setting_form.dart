import 'package:cloud_firestore/cloud_firestore.dart';
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

  var currentEmployee;

  String taskValue;
  _TaskFormState(this.taskValue);

  final _formKey = GlobalKey<FormState>();
  final List<String> assignedEmployee = [];

  String _tid;
  String _tName;
  String _tStatus;
  String _tEmployee;
  String _tEmployeeId;
  String _tProjectId;
  String _tProjectName;


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

                  SizedBox(height: 20.0,),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('users').where('employeeType', isEqualTo: 'Developer').snapshots(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          List<DropdownMenuItem> employeeItems=[];
                          for(int i=0;i<snapshot.data.docs.length;i++){
                            DocumentSnapshot snap = snapshot.data.docs[i];
                            employeeItems.add(
                                DropdownMenuItem(
                                  child: Text(
                                    snap.get('employeeName').toString(),
                                  ),
                                  value: "${snap.get('employeeName').toString()}",

                                )

                            );

                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.person),
                              SizedBox(width: 10.0,),
                              DropdownButton(
                                items: employeeItems,
                                onChanged: (employeeValue){
                                  print(employeeValue);
                                  setState(() {
                                    print(employeeValue);
                                    _tEmployee = employeeValue;
                                    print(_tEmployee);
                                  });
                                },
                                value: _tEmployee,
                                isExpanded: false,
                                hint: new Text(task.taskEmployee ?? 'Choose Employee'),
                              ),
                            ],
                          );
                        }else{
                          return Loading();
                        }
                      }
                  ),


                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        try{
                          if(_formKey.currentState.validate()){
                            await TaskDatabaseService(tid: taskValue)
                                .updateTaskData(
                                _tid ?? task.taskId ?? taskValue,
                                _tName ?? task.taskName,
                                _tStatus ?? task.taskStatus,
                                _tEmployee ?? task.taskEmployee,
                                _tEmployeeId ?? task.taskEmployeeId,
                                _tProjectId ?? task.taskProjectId,
                              _tProjectName ?? task.taskProjectName
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
