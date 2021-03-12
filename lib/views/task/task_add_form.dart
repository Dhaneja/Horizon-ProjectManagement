import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/services/database_task.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';

// ignore: must_be_immutable
class TaskAddForm extends StatefulWidget {

  //Constructor
  String projectIdValue, projectNameValue;
  TaskAddForm({this.projectIdValue, this.projectNameValue});

  @override
  _TaskAddFormState createState() => _TaskAddFormState(projectIdValue, projectNameValue);
}

class _TaskAddFormState extends State<TaskAddForm> {

  String currentEmployee;

  String empId;

  String projectIdValue, projectNameValue;
  _TaskAddFormState(this.projectIdValue,this.projectNameValue);

  //FormKey Instance
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //Local Variables
  String _tid = '';
  String _tName = '';
  String _tStatus = '';
  String _tEmployee = '';
  String _tEmployeeId = '';
  String _tProjectId = '';
  String _tProjectName = '';

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
            decoration: textInputStyle.copyWith(hintText: 'Task Name',labelText: 'Task Name'),
            validator: (val) => val.isEmpty ? 'Please Enter Task Name' : null,
            onChanged: (val) => setState(() => _tName = val),
          ),


          SizedBox(height: 20.0,),
          //StreamBuilder to access the stream to fetch values using a query
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

                  empId = "${snap.get('employeeId').toString()}";

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


          //Add Task Data using addTaskData Method in TaskDatabaseService
          SizedBox(height: 20.0,),

          RaisedButton(
              color: Colors.blue[400],
              child: Text(
                'Add',
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
                       _tEmployeeId = empId,
                        _tProjectId = projectIdValue,
                      _tProjectName = projectNameValue
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
