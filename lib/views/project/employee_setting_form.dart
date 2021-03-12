import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/auth_service.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/authenticate/sign_in.dart';


class EmployeeForm extends StatefulWidget {

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {

  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  final List<String> employeeTypes = ['Project Manager', 'Developer', 'System Admin'];

  //Local Variables
  String _eid;
  String _eEmail;
  String _ePassword;
  String _eName;
  String _eType;

  //Current employee uid and email using FirebaseAuth
  String currentEmployeeId = FirebaseAuth.instance.currentUser.uid;
  String currentEmployeeEmail = FirebaseAuth.instance.currentUser.email;


  @override
  Widget build(BuildContext context) {
    //Stream Provider to List the Employees Details using employeeData
    return StreamBuilder<Employee>(

      //Get data from employeeData stream in DatabaseService
        stream: DatabaseService(eid: currentEmployeeId).employeeData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            Employee employee = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  Text(
                    'Employee Profile',
                    style: TextStyle(fontSize: 18.0),
                  ),


                  SizedBox(height: 20.0),

                  TextFormField(
                    initialValue: employee.eName,
                    decoration: textInputStyle.copyWith(hintText: 'Employee Name',labelText: 'Employee Name'),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _eName = val),
                  ),


                  SizedBox(height: 20.0),

                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    decoration: textInputStyle.copyWith(hintText: employee.eEmail),
                  ),


                  //DropDownBox
                  SizedBox(height: 20.0),

                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    decoration: textInputStyle.copyWith(hintText: employee.eType),
                  ),


                  //Update Data using updateUserData method in DatabaseService
                  SizedBox(height: 10.0),

                  RaisedButton(
                      color: Colors.lightBlueAccent,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(eid: currentEmployeeId ).updateUserData(
                              _eid ?? currentEmployeeId,
                              _eName ?? employee.eName,
                              _eEmail ?? employee.eEmail,
                              _ePassword ?? employee.ePassword,
                              _eType ?? employee.eType
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),


                  //Reset Password Button
                  SizedBox(height: 10.0),

                  RaisedButton(
                      color: Colors.orange,
                      child: Text(
                        'Reset Password',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await AuthService().passwordReset(currentEmployeeEmail);
                        print(employee.eEmail);
                      }
                  ),


                  SizedBox(height: 10.0),

                  RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Log Out',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await _authService.signOut();
                        Navigator.pop(context);
                        return SignIn();
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