import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/database_task.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';

class TaskAddForm extends StatefulWidget {

  String projectValue;
  TaskAddForm({this.projectValue});

  @override
  _TaskAddFormState createState() => _TaskAddFormState(projectValue);
}

class _TaskAddFormState extends State<TaskAddForm> {

  var nowEmployee, currentEmployee;

  String projectValue;
  _TaskAddFormState(this.projectValue);

  final _formKey = GlobalKey<FormState>();

  List<String> _assignEmployee=<String>['New', 'Senpai'];

  bool loading = false;

  String _tid = '';
  String _tName = '';
  String _tStatus = '';
  String _tEmployee = '';
  String _tProjectId = '';

  String projectName = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Form(

      key: _formKey,
      child:Column(
        children: <Widget>[
          Text(
            'Task',
            style: TextStyle(fontSize: 18.0),
          ),

          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputStyle.copyWith(hintText: 'Task Name'),
            validator: (val) => val.isEmpty ? 'Please Enter Task Name' : null,
            onChanged: (val) => setState(() => _tName = val),
          ),

          SizedBox(height: 20.0),
/*          DropdownButtonFormField(
            decoration: textInputStyle.copyWith(hintText: 'Assign Employee'),

          ),
          */


/*          DropdownButton(
              items: _assignEmployee.map((value) => DropdownMenuItem(
                  child: Text(
                    value,

                  ),
                value: value,
              )).toList(),
              onChanged: (selectedEmployee){
                setState(() {
                  nowEmployee=selectedEmployee;
                });
              },
            value: nowEmployee,
            isExpanded: false,
            hint: Text('Assign Employee'),
          ),*/
          SizedBox(height: 20.0,),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                            currentEmployee = employeeValue;
                            print(currentEmployee);
                          });
                        },
                      value: currentEmployee,
                      isExpanded: false,
                      hint: new Text('Choose Employee'),
                    ),
                  ],
                );
              }else{
                return Loading();
              }
              }
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
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await TaskDatabaseService()
                        .addTaskData(
                        _tName,
                        _tStatus = 'Ongoing',
                        currentEmployee,
                        _tProjectId = projectValue,
                    );
                    if(result == null){
                      setState(() {
                        error = 'Please Enter All Details';
                        loading = false;
                      });
                    }
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
  }
}
