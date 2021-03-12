import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/employee/developer_tasks.dart';
import 'package:horizon/views/employee/employee_home.dart';

class AdminDeveloperForm extends StatefulWidget {

  String empValue;
  AdminDeveloperForm({this.empValue});

  @override
  _AdminDeveloperFormState createState() => _AdminDeveloperFormState(empValue);
}

class _AdminDeveloperFormState extends State<AdminDeveloperForm> {

  String empValue;
  _AdminDeveloperFormState(this.empValue);

/*  _EmployeeFormState(this.employeeid);
  final DocumentSnapshot employeeid;*/

  final _formKey = GlobalKey<FormState>();
  final List<String> employeeTypes = ['Project Manager', 'Developer', 'System Admin'];


  String _eid;
  String _eEmail;
  String _ePassword;
  String _eName;
  String _eType;

  String empName;


  @override
  Widget build(BuildContext context) {



    return StreamBuilder<Employee>(
        stream: DatabaseService(eid: empValue).employeeData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            Employee employee = snapshot.data;

            empName = employee.eName ;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Employee Data',
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
                  //dropdown
                  DropdownButtonFormField(
                    /*value: null,*/
                    value: _eType ?? employee.eType,
                    decoration: textInputStyle.copyWith(hintText: 'Employee Type', labelText: 'Employee Type'),
                    items: employeeTypes.map((employeeType) {
                      return DropdownMenuItem(
                        value: employeeType,
                        child: Text('$employeeType'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _eType = val),
                  ),

                  //Update Button
                  SizedBox(height: 10.0),

                  RaisedButton(
                      color: Colors.lightBlueAccent,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          await DatabaseService(eid: empValue).updateUserData(
                              _eid ?? empValue,
                              _eName ?? employee.eName,
                              _eEmail ?? employee.eEmail,
                              _ePassword ?? employee.ePassword,
                              _eType ?? employee.eType
                          );
                          Navigator.pop(context);
                        }
                      }
                  ),

                  RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Tasks',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        print(empName);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DeveloperTask(empValue, empName))
                        );
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
                        await AuthService().passwordReset(employee.eEmail);
                        print(employee.eEmail);
                      }
                  ),

                  //Delete Password Button
                  SizedBox(height: 10.0),

                  RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Delete Employee Account',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        FirebaseFirestore.instance
                            .collection('users')
                            .where('employeeId',isEqualTo: employee.eid)
                            .get().then((value) {
                          value.docs.forEach((element) {
                            FirebaseFirestore.instance.collection('users').doc(employee.eid).delete().then((value) {
                              print('Success!');
                              Navigator.pop(context);
                            });
                          });
                        });
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
