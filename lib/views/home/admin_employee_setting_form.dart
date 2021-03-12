import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/auth_service.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';

class AdminEmployeeForm extends StatefulWidget {

  //Constructor
  String empValue;
  AdminEmployeeForm({this.empValue});

  @override
  _AdminEmployeeFormState createState() => _AdminEmployeeFormState(empValue);
}

class _AdminEmployeeFormState extends State<AdminEmployeeForm> {

  String empValue;
  _AdminEmployeeFormState(this.empValue);

  //FormKey Instance
  final _formKey = GlobalKey<FormState>();
  final List<String> employeeTypes = ['Project Manager', 'Developer', 'System Admin'];

  //Local Variables
  String _eid;
  String _eEmail;
  String _ePassword;
  String _eName;
  String _eType;


  @override
  Widget build(BuildContext context) {

    //StreamBuilder to access the stream to fetch values
    return StreamBuilder<Employee>(

      //Get data from employeeDate stream in DatabaseService
      stream: DatabaseService(eid: empValue).employeeData,
      builder: (context, snapshot) {

        if(snapshot.hasData){

          Employee employee = snapshot.data;

          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  Text(
                    'Update Employee Data',
                    style: TextStyle(fontSize: 18.0),
                  ),


                  SizedBox(height: 20.0),
                  //Edit Employee Name
                  TextFormField(
                    initialValue: employee.eName,
                    decoration: textInputStyle.copyWith(hintText: 'Employee Name',labelText: 'Employee Name'),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _eName = val),
                  ),


                  SizedBox(height: 20.0),
                  //Display Employee Email
                  TextFormField(
                    enabled: false,
                    readOnly: true,
                    decoration: textInputStyle.copyWith(hintText: employee.eEmail),),


                  SizedBox(height: 20.0),

                  //DropDoenBox to change Employee Type
                  DropdownButtonFormField(
                    value: _eType ?? employee.eType,
                    decoration: textInputStyle.copyWith(hintText: 'Employee Type',labelText: 'Employee Type'),
                    items: employeeTypes.map((employeeType) {
                      return DropdownMenuItem(
                        value: employeeType,
                        child: Text('$employeeType'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _eType = val),
                  ),


                  //Update Employee data using updateUserData in DatabaseService
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
