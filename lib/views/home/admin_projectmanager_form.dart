import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/auth_service.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/project/admin_project_view.dart';

// ignore: must_be_immutable
class AdminProjectManagerForm extends StatefulWidget {

  String empValue;
  AdminProjectManagerForm({this.empValue});

  @override
  _AdminProjectManagerFormState createState() => _AdminProjectManagerFormState(empValue);
}

class _AdminProjectManagerFormState extends State<AdminProjectManagerForm> {

  String empValue;
  _AdminProjectManagerFormState(this.empValue);

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

    //StreamBuilder to access the stream to fetch values
    return StreamBuilder<Employee>(

      //Get data from employeeDate stream in DatabaseService
        stream: DatabaseService(eid: empValue).employeeData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            Employee employee = snapshot.data;

            empName = employee.eName;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  Text(

                    'Update Project Manager Data',
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


                  SizedBox(height: 20.0),

                  DropdownButtonFormField(

                    value: _eType ?? employee.eType,
                    decoration: textInputStyle.copyWith(hintText: 'Employee Type',labelText: 'Employee Name'),
                    items: employeeTypes.map((employeeType) {
                      return DropdownMenuItem(
                        value: employeeType,
                        child: Text('$employeeType'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _eType = val),
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

                  //Prompt to Project list created by the selected Project Manager
                  RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Projects',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        print(_eName);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminProjectView(empValue, empName))
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
