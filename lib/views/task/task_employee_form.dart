import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/services/database_task.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';

// ignore: must_be_immutable
class EmployeeTaskForm extends StatefulWidget {

  //Constructor
  String taskIdValue;
  EmployeeTaskForm({this.taskIdValue});


  @override
  _EmployeeTaskFormState createState() => _EmployeeTaskFormState(taskIdValue);
}


class _EmployeeTaskFormState extends State<EmployeeTaskForm> {

  String taskIdValue;
  _EmployeeTaskFormState(this.taskIdValue);

  //FormKey Instance
  final _formKey = GlobalKey<FormState>();
  final List<String> taskStatus = ['Ongoing','Finished','Cancelled','On hold'];

  //Local variables
  String _tId;
  String _tName;
  String _tStatus;
  String _tEmployee;
  String _tEmployeeId;
  String _tProjectId;
  String _tProjectName;


  @override
  Widget build(BuildContext context) {

    //StreamBuilder to access the stream to fetch values
    return StreamBuilder<Task>(

        //Get data from taskData stream in TaskDatabaseService
        stream: TaskDatabaseService(tid:taskIdValue).taskData,
        builder: (context, snapshot){
          if(snapshot.hasData){

            Task task = snapshot.data;

            return Form(

              key: _formKey,
              child:Column(

                children: <Widget>[

                  Text(task.taskProjectName,
                    style: TextStyle(fontSize: 18.0),
                  ),


                  SizedBox(height: 40.0),

                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    decoration: textInputStyle.copyWith(hintText: task.taskName),
                  ),


                  SizedBox(height: 40.0,),

                  DropdownButtonFormField(
/*                  value: null,*/
                    value: _tStatus ?? task.taskStatus,
                    decoration: textInputStyle.copyWith(hintText: 'Project Status',labelText: 'Project Status'),
                    items: taskStatus.map((tStatus) {
                      return DropdownMenuItem(
                        value: tStatus,
                        child: Text('$tStatus'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _tStatus = val),
                  ),


                  //Update Data using updateTaskData in TaskDatabaseService
                  SizedBox(height: 40.0,),

                  RaisedButton(
                      color: Colors.lightBlueAccent,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        try{
                          if(_formKey.currentState.validate()){
                            await TaskDatabaseService(tid: taskIdValue)
                                .updateTaskData(
                                _tId ?? task.taskId ?? taskIdValue,
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
