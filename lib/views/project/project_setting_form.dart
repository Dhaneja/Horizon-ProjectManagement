import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/task/task_home.dart';

// ignore: must_be_immutable
class ProjectForm extends StatefulWidget {

  //Constructor
  String projectIdValue, projectNameValue;
  ProjectForm({this.projectIdValue, this.projectNameValue});

  @override
  _ProjectFormState createState() => _ProjectFormState(projectIdValue, projectNameValue);
}

class _ProjectFormState extends State<ProjectForm> {

  String projectIdValue, projectNameValue;
  _ProjectFormState(this.projectIdValue, this.projectNameValue);

  //FormKey Instance
  final _formKey = GlobalKey<FormState>();
  final List<String> projectStatus = ['Ongoing','Finished','Cancelled','On hold'];

  //Local Variables
  String _pid;
  String _pName;
  String _pStartDate;
  String _pEndDate;
  String _pCost;
  String _pManager;
  String _pClient;
  String _pStatus;
  String _empId;
  String _pHoldReason = '';


  @override
  Widget build(BuildContext context) {


    //StreamBuilder to access the stream to fetch values
    return StreamBuilder<Project>(

      //Get data from projectData stream in ProjectDatabaseService
      stream: ProjectDatabaseService(pid:projectIdValue).projectData,
      builder: (context, snapshot){
        if (snapshot.hasData){

          Project project = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                Text(

                  'Project Details',
                  style: TextStyle(fontSize: 18.0),

                ),


                SizedBox(height: 20.0),

                TextFormField(

                  initialValue: project.pName,
                  decoration: textInputStyle.copyWith(hintText: 'Project Name', labelText: 'Project Name'),
                  validator: (val) => val.isEmpty ? 'Please Enter Project Name' : null,
                  onChanged: (val) => setState(() => _pName = val),

                ),


                SizedBox(height: 20.0),

                TextFormField(
                  initialValue: project.pClient,
                  decoration: textInputStyle.copyWith(hintText: 'Project Client', labelText: 'Project Client'),
                  validator: (val) => val.isEmpty ? 'Please Enter Client Name' : null,
                  onChanged: (val) => setState(() => _pClient = val),
                ),


                SizedBox(height: 20.0),

                Text('Start Date:  ${project.sDate}'),


                SizedBox(height: 20.0),

                Text('End Date:  ${project.eDate}'),


                SizedBox(height: 20.0),

                TextFormField(
                  initialValue: project.pCost,
                  decoration: textInputStyle.copyWith(hintText: 'Project Cost',labelText: 'Project Cost'),
                  validator: (val) => val.isEmpty ? 'Please Enter Project Cost' : null,
                  onChanged: (val) => setState(() => _pCost = val),
                ),


                SizedBox(height: 20.0),

                DropdownButtonFormField(
                  value: _pStatus ?? project.pStatus,
                  decoration: textInputStyle.copyWith(hintText: 'Project Status',labelText: 'Project Status'),
                  items: projectStatus.map((proStatus) {
                    return DropdownMenuItem(
                      value: proStatus,
                      child: Text('$proStatus'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _pStatus = val),
                ),


                SizedBox(height: 20.0,),

                TextFormField(
                  initialValue: project.pHoldReason,
                  decoration: textInputStyle.copyWith(hintText: 'If Project OnHold, Reason', labelText: 'On hold Reason'),
                  onChanged: (val) => setState(() => _pHoldReason = val),
                ),


                SizedBox(height: 20.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    //Update data using updateProjectData method in ProjectDatabaseService
                    SizedBox(height: 20.0),

                    RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {

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
                                  _empId ?? project.empId,
                                  _pHoldReason ?? project.pHoldReason
                              );
                              Navigator.pop(context);
                            }

                        }

                    ),

                    //Prompt to Task list related to the selected project
                    SizedBox(height: 20.0, width: 40.0,),

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
