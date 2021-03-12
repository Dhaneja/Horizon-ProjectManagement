import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'file:///F:/Esoft/Android/horizon/lib/views/home/project_home.dart';
import 'package:intl/intl.dart';


class ProjectAddForm extends StatefulWidget {

  @override
  _ProjectAddState createState() => _ProjectAddState();
}

class _ProjectAddState extends State<ProjectAddForm> {


  //Required Date Format
  DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  //Current Date
  DateTime date = DateTime.now();

  //Other variables required for date selection
  DateTime startDate;
  DateTime endDate;
  String _displayStartDate;
  String _displayEndDate;
  String passStartDate;
  String passEndDate;


  bool loading = false;


  final _formKey = GlobalKey<FormState>();

  //Text field initialization
  String projectName = '';
  String projectCost = '';
  String finalStartDate = '';
  String finalEndDate = '';
  String projectClient = '';
  String projectStatus = 'On hold';
  String employeeId = FirebaseAuth.instance.currentUser.uid;
  String projectHoldReason = '';

  String error = '';

  String projectManager = '';



  @override
  Widget build(BuildContext context) {

    //Pass the current date in required Format
    _displayStartDate = dateFormat.format(date);
    _displayEndDate = dateFormat.format(date);

    return loading ? Loading() : Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(

              children: <Widget>[

                SizedBox(height: 20.0,),

                //Stream Builder to fetch Employee Date (of Current User using Firebase uid)
                StreamBuilder<Employee>(
                    stream: DatabaseService(eid: FirebaseAuth.instance.currentUser.uid).employeeData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Employee employee = snapshot.data;

                        projectManager = employee.eName;

                      }
                      print(projectManager);
                      return Text('Welcome, $projectManager', style: TextStyle(fontSize: 20.0),);
                    }),


                SizedBox(height: 20.0,),

                TextFormField(
                  decoration: textInputStyle.copyWith(hintText: 'Project Name',labelText: 'Project Name'),
                  onChanged: (projectNameInput){
                    setState(() {
                      projectName = projectNameInput;
                    });
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please Enter Project Name';
                    }
                    return null;
                  },
                ),


                SizedBox(height: 20.0,),

                //Square Area to include Text Field for Start Date
                InkWell(

                  onTap: () async {

                    //Stops keyboard from appearing
                    FocusScope.of(context).requestFocus(new FocusNode());

                    //Show Date Picker
                    startDate = await _selectDateTime(context, startDate);

                    //Pass the fetched Date in required Format
                    finalStartDate = dateFormat.format(startDate);
                    passStartDate = 'StartDate : $finalStartDate';

                  },

                  //This will prevent from the pointer being displayed
                  child: IgnorePointer(

                    //Text Field
                    child: new TextFormField(
                      decoration: textInputStyle.copyWith(hintText: passStartDate  ?? 'Start Date: $_displayStartDate'   ,suffixIcon: Icon(Icons.calendar_today) ),

                    ),
                  ),

                ),


                SizedBox(height: 20.0,),

                //Square Area to include Text Field for End Date
                InkWell(

                  onTap: () async {

                    //Stops keyboard from appearing
                    FocusScope.of(context).requestFocus(new FocusNode());

                    //Show Date Picker
                    endDate = await _selectDateTime(context, endDate);

                    //Pass the fetched Date in required Format
                    finalEndDate = dateFormat.format(endDate);
                    passEndDate = 'End Date : $finalEndDate';

                    print('Returned Start Date $startDate');
                    print('Returned String Start Date $_displayStartDate');
                    print('Returned End Date $endDate');
                    print('Returned String End Date $_displayEndDate');

                  },

                  child: IgnorePointer(
                    child: new TextFormField(
                      decoration: textInputStyle.copyWith(hintText: passEndDate  ?? 'End Date: $_displayEndDate'   , suffixIcon: Icon(Icons.calendar_today) ),

                    ),
                  ),

                ),


                SizedBox(height: 20.0,),

                TextFormField(
                  decoration: textInputStyle.copyWith(hintText: 'Project Cost',labelText: 'Project Cost'),
                  onChanged: (projectCostInput){
                    setState(() {
                      projectCost = projectCostInput;
                    });
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please Enter Project Cost';
                    }
                    return null;
                  },
                ),


                SizedBox(height: 20.0,),

                TextFormField(
                  decoration: textInputStyle.copyWith(hintText: 'Project Client', labelText: 'Project Client'),
                  onChanged: (projectClientInput){
                    setState(() {
                      projectClient = projectClientInput;
                    });
                  },
                  validator: (value){
                    if(value.isEmpty){
                      return 'Please Enter Project Client Name';
                    }
                    return null;
                  },
                ),


                SizedBox(height: 20.0,),

                //Button to Update the Entered Data using Project Service
                RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Create Project',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {

                      if (_formKey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await ProjectDatabaseService().addProjectData(projectName, finalStartDate, finalEndDate, projectCost, projectManager, projectClient, projectStatus, employeeId, projectHoldReason);
                        if (result == null){
                          setState(() {
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
              ],
            ),
      ),
    );
  }


  //Method to select Date using DateTimePicker
  Future<DateTime> _selectDateTime(BuildContext context, DateTime datePicked) async{
    final DateTime picked = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2005),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != datePicked){
      print(picked);
      setState(() {
        datePicked = picked;
      });
    }
    return datePicked;

  }

}
