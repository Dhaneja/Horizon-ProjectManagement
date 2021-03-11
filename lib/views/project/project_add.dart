import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/services/project_service.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/project/project_home.dart';
import 'package:intl/intl.dart';


class ProjectAdd extends StatefulWidget {



  final Function toggleView;
  ProjectAdd({this.toggleView});

  @override
  _ProjectAddState createState() => _ProjectAddState();
}

class _ProjectAddState extends State<ProjectAdd> {


  DateFormat dateFormat = DateFormat('dd-MM-yyyy');

/*  String _dateStart = '';
  String _dateEnd = '';*/

/*  DateTime selectedDate = DateTime.now();*/

  DateTime date = DateTime.now();
  String _displayStartDate;
  String _displayEndDate = '';
  String returnedDate;
  String _startDate;


/*  final DateTime now = DateTime.now();*/
/*  final DateFormat formatter = DateFormat('dd-MM-yyyy');*/
/*  String _dateTime = DateFormat('dd-MM-yyyy').format(now);*/

  bool loading = false;
  final AuthService _authService = AuthService();
  final ProjectService _projectService = ProjectService();
  final _formKey = GlobalKey<FormState>();

  //Text field initialization
  String projectName = '';
/*  String startDate = '';*/
  String endDate = '';
  String projectCost = '';

  String projectClient = '';
  String projectStatus = 'On hold';
  String employeeId = FirebaseAuth.instance.currentUser.uid;

  String error = '';

  String projectManager = '';



  @override
  Widget build(BuildContext context) {


    /*_dateStart =  dateFormat.format(DateTime.now());*/
    /*_dateEnd =  dateFormat.format(DateTime.now());*/
    _displayStartDate = dateFormat.format(date);


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
              StreamBuilder<Employee>(
                  stream: DatabaseService(eid: FirebaseAuth.instance.currentUser.uid).employeeData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Employee employee = snapshot.data;

                      projectManager = employee.eName;

                    }
                    print(projectManager);
                    return Text('Welcome, $projectManager', style: TextStyle(fontSize: 15.0),);
                  }),

              SizedBox(height: 40.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Name'),
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


              InkWell(

                onTap: () async {

                  //Stops keyboard from appearing
                  FocusScope.of(context).requestFocus(new FocusNode());

                  //Show Date Picker
                  /*final selectedDate =*/
                  await _selectedDateTime(context);
                  _displayStartDate = dateFormat.format(date);


/*                  if (selectedDate == null) return;

                  print(selectedDate);

                  setState(() {
                    this.selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                    );
                  });*/

                },

                child: IgnorePointer(
                  child: new TextFormField(
                    decoration: textInputStyle.copyWith(hintText:/*'Start Date : $_displayStartDate'*/ 'Starting Date: $_displayStartDate'   , suffixIcon: Icon(Icons.calendar_today) ),

/*                    validator: (String value){
                      print('date:: ${date.toString()}');
                      if (value.isEmpty){
                        return 'Date Required';
                      }
                      return null;
                    },*/
/*                    onSaved: (String val){
                      strDate = val;
                    },*/
                  ),
                ),

              ),


/*              TextFormField(



                decoration: textInputStyle.copyWith(hintText: dateFormat.format(selectedDate) , suffixIcon: Icon(Icons.calendar_today) ),

                onTap: () async {

                  FocusScope.of(context).requestFocus(new FocusNode());

                  final selectedDate = await _selectedDateTime(context);
                  if(selectedDate == null ) return;

                  print (selectedDate);

                  setState(() {
                    this.selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                    );
                  });



                },

                onChanged: (nowSelectedDate){
                  setState(() {
                    selectedDate = dateFormat.parse(nowSelectedDate);
                  });
                },
              ),*/














/*              SizedBox(height: 20.0,),

              TextFormField(

                decoration: textInputStyle.copyWith(hintText:'End Date : $_dateEnd', suffixIcon: Icon(Icons.calendar_today) ),

                onTap: ()
              ),*/



              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Cost'),
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


/*              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Manager'),
                onChanged: (projectManagerInput){
                  setState(() {
                    projectManager = projectManagerInput;
                  });
                },
              ),*/



              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Client'),
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
/*              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Project Status'),
                onChanged: (projectStatusInput){
                  setState(() {
                    projectStatus = projectStatusInput;
                  });
                },
              ),*/
              SizedBox(height: 20.0,),
              RaisedButton(
                  color: Colors.orangeAccent[400],
                  child: Text(
                    'Create Project',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    print(projectName);
                    print(_displayStartDate);
                    print(_displayStartDate);
                    print(projectCost);
                    print(projectManager);
                    print(projectClient);
                    print(projectStatus);
                    print(employeeId);


                    if (_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _projectService.createProject(projectName, _displayStartDate, _displayEndDate, projectCost, projectManager, projectClient, projectStatus, employeeId);
/*                      loading = false;*/
                      if (result == null){
                        setState(() {
/*                          error = 'Please enter all details';*/
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

  Future<void> _selectedDateTime(BuildContext context) async{

    final now = DateTime.now();
    final DateTime picked = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2005),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != date){
      print(picked);
      setState(() {
        date = picked;
      });
    }

  }

}
