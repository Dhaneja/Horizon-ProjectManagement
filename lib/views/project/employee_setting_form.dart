import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';


class EmployeeForm extends StatefulWidget {


  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {


  final _formKey = GlobalKey<FormState>();
  final List<String> employeeTypes = ['Project Manager', 'Developer', 'System Admin'];


  String _eid;
  String _eEmail;
  String _ePassword;
  String _eName;
  String _eType;

  String currentEmployeeId = FirebaseAuth.instance.currentUser.uid;
  String currentEmployeeEmail = FirebaseAuth.instance.currentUser.email;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Employee>(
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
                    decoration: textInputStyle.copyWith(hintText: 'Employee Name'),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _eName = val),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    enabled: false,
                    readOnly: true,
/*                    initialValue: employee.eEmail,*/
                    decoration: textInputStyle.copyWith(hintText: employee.eEmail),
/*                    validator: (val) => val.isEmpty ? 'Please enter a email' : null,*/
/*                    onChanged: (val) => setState(() => _eEmail = val),*/
                  ),
/*            SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputStyle.copyWith(hintText: 'Employee Password'),
                  validator: (val) => val.isEmpty ? 'Please enter a password' : null,
                  onChanged: (val) => setState(() => _ePassword = val),
                ),*/

                  //DropDownBox
                  SizedBox(height: 20.0),
                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    decoration: textInputStyle.copyWith(hintText: employee.eType),
                  ),
                  //dropdown
/*                  DropdownButtonFormField(
                    *//*value: null,*//*
                    value: _eType ?? employee.eType,
                    decoration: textInputStyle.copyWith(hintText: 'Employee Type'),
                    items: employeeTypes.map((employeeType) {
                      return DropdownMenuItem(
                        value: employeeType,
                        child: Text('$employeeType'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _eType = val),
                  ),*/


                  //Update Button
                  SizedBox(height: 10.0),

                  RaisedButton(
                      color: Colors.lightGreen,
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