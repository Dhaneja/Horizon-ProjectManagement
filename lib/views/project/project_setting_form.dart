import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/task/task_home.dart';
import 'package:provider/provider.dart';

class ProjectForm extends StatefulWidget {

  String projectIdValue, projectNameValue;
  ProjectForm({this.projectIdValue, this.projectNameValue});

  @override
  _ProjectFormState createState() => _ProjectFormState(projectIdValue, projectNameValue);
}

class _ProjectFormState extends State<ProjectForm> {

  String projectIdValue, projectNameValue;
  _ProjectFormState(this.projectIdValue, this.projectNameValue);

  final _formKey = GlobalKey<FormState>();
  final List<String> projectStatus = ['Ongoing','Finished','Cancelled','On hold'];

  String _pid;
  String _pName;
  String _pStartDate;
  String _pEndDate;
  String _pCost;
  String _pManager;
  String _pClient;
  String _pStatus;
  String _empId;

  String docId;

  /*'B5Eu6fj70iGdoSX27E0k'*/

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<Project>(
      stream: ProjectDatabaseService(pid:projectIdValue).projectData,
      builder: (context, snapshot){
        if (snapshot.hasData){

          Project project = snapshot.data;



          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Project',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: project.pName,
                  decoration: textInputStyle.copyWith(hintText: project.pName),
                  validator: (val) => val.isEmpty ? 'Please Enter Project Name' : null,
                  onChanged: (val) => setState(() => _pName = val),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: project.pClient,
                  decoration: textInputStyle.copyWith(hintText: 'Project Client'),
                  validator: (val) => val.isEmpty ? 'Please Enter Client Name' : null,
                  onChanged: (val) => setState(() => _pClient = val),
                ),
                SizedBox(height: 20.0),
                Text('Start Date:  ${project.sDate}'),

/*                TextFormField(
                  initialValue: project.sDate,
                  decoration: textInputStyle.copyWith(hintText: project.sDate),
                  validator: (val) => val.isEmpty ? 'Please Enter Start Date' : null,
                  onChanged: (val) => setState(() => _pStartDate = val),
                ),*/
                SizedBox(height: 20.0),
                Text('End Date:  ${project.eDate}'),
/*                TextFormField(
                  initialValue: project.eDate,
                  decoration: textInputStyle.copyWith(hintText: project.eDate),
                  validator: (val) => val.isEmpty ? 'Please Enter End Date' : null,
                  onChanged: (val) => setState(() => _pEndDate = val),
                ),*/
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: project.pCost,
                  decoration: textInputStyle.copyWith(hintText: project.pCost),
                  validator: (val) => val.isEmpty ? 'Please Enter Project Cost' : null,
                  onChanged: (val) => setState(() => _pCost = val),
                ),
/*                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: project.pManager,
                  decoration: textInputStyle.copyWith(hintText: project.pManager),
                  validator: (val) => val.isEmpty ? 'Please Enter Project Manager' : null,
                  onChanged: (val) => setState(() => _pManager = val),
                ),*/
                SizedBox(height: 20.0),
                //dropdown
                DropdownButtonFormField(
/*                  value: null,*/
                  value: _pStatus ?? project.pStatus,
                  decoration: textInputStyle.copyWith(hintText: 'Project Status'),
                  items: projectStatus.map((proStatus) {
                    return DropdownMenuItem(
                      value: proStatus,
                      child: Text('$proStatus'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _pStatus = val),
                ),
                SizedBox(height: 10.0),

                RaisedButton(
                    color: Colors.lightGreen,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
/*                     docId = FirebaseFirestore.instance.collection('projects').doc(projectValue).get().toString();

                     print(docId);*/

                     try {
                       if (_formKey.currentState.validate()) {
                         await ProjectDatabaseService(pid: projectIdValue)
                             .updateProjectData(
                             _pid ?? projectIdValue,
                             _pName ?? project.pName,
                             _pStartDate ?? project.sDate,
                             _pEndDate ?? project.eDate,
                             _pCost ?? project.pCost,
                             _pManager ?? project.pManager,
                             _pClient ?? project.pClient,
                             _pStatus ?? project.pStatus,
                             _empId ?? project.empId
                         );
                         Navigator.pop(context);
                       }
                     }catch(error){
                       print(error);
                     }
                    }
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                    color: Colors.orange[400],
                    child: Text(
                      'Tasks',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TaskHome(projectIdValue, projectNameValue))
                      );
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
