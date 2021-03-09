import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/project_service.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/project/project_home.dart';


class ProjectAdd extends StatefulWidget {



  final Function toggleView;
  ProjectAdd({this.toggleView});

  @override
  _ProjectAddState createState() => _ProjectAddState();
}

class _ProjectAddState extends State<ProjectAdd> {

  DateTime _dateTime;

  bool loading = false;
  final AuthService _authService = AuthService();
  final ProjectService _projectService = ProjectService();
  final _formKey = GlobalKey<FormState>();

  //Text field initialization
  String projectName = '';
  String startDate = '';
  String endDate = '';
  String projectCost = '';
  String projectManager = '';
  String projectClient = '';
  String projectStatus = '';
  String employeeId = FirebaseAuth.instance.currentUser.uid;

  String error = '';



  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Create Project'),
        actions: <Widget>[
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
          child: Column(

            children: <Widget>[

              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Name'),
                onChanged: (projectNameInput){
                  setState(() {
                    projectName = projectNameInput;
                  });
                },
              ),
              SizedBox(height: 20.0,),

/*              RaisedButton(
                child: Text(_dateTime == null ? 'Choose Starting Date' : _dateTime.toString()),
                  onPressed: null
              ),*/

              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Start Date'),
                onChanged: (startDateInput){
                  setState(() {
                    startDate = startDateInput;
                  });
                },
              ),

              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'End Date'),
                onChanged: (endDateInput){
                  setState(() {
                    endDate = endDateInput;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Cost'),
                onChanged: (projectCostInput){
                  setState(() {
                    projectCost = projectCostInput;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Manager'),
                onChanged: (projectManagerInput){
                  setState(() {
                    projectManager = projectManagerInput;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Client'),
                onChanged: (projectClientInput){
                  setState(() {
                    projectClient = projectClientInput;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Status'),
                onChanged: (projectStatusInput){
                  setState(() {
                    projectStatus = projectStatusInput;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                  color: Colors.orangeAccent[400],
                  child: Text(
                    'Create Project',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _projectService.createProject(projectName, startDate, endDate, projectCost, projectManager, projectClient, projectStatus, employeeId);
                      if (result == null){
                        setState(() {
                          error = 'Please enter all details';
                          loading = false;
                        });
                      }else
                      {
                        loading = false;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ProjectHome())
                        );

                      }
                    }

                  }
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
