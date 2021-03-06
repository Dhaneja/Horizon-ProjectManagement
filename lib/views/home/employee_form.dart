import 'package:flutter/material.dart';
import 'package:horizon/shared/constants.dart';

class EmployeeForm extends StatefulWidget {
  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> employeeTypes = ['Project Manager', 'Developer', 'System Admin'];


  String _eEmail;
  String _ePassword;
  String _eName;
  String _eType;

  @override
  Widget build(BuildContext context) {
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
              decoration: textInputStyle.copyWith(hintText: 'Employee Name'),
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _eName = val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputStyle.copyWith(hintText: 'Employee Email'),
              validator: (val) => val.isEmpty ? 'Please enter a email' : null,
              onChanged: (val) => setState(() => _eEmail = val),
            ),
/*            SizedBox(height: 20.0),
            TextFormField(
              decoration: textInputStyle.copyWith(hintText: 'Employee Password'),
              validator: (val) => val.isEmpty ? 'Please enter a password' : null,
              onChanged: (val) => setState(() => _ePassword = val),
            ),*/
            SizedBox(height: 20.0),
            //dropdown
            DropdownButtonFormField(
 /*             value: _eType ?? 'Employee Type',*/
              decoration: textInputStyle.copyWith(hintText: 'Employee Type'),
              items: employeeTypes.map((employeeType) {
                return DropdownMenuItem(
                  value: employeeType,
                  child: Text('$employeeType'),
                );
              }).toList(),
              onChanged: (val) => setState(() => _eType = val),
            ),
            //slider
            SizedBox(height: 10.0),
            RaisedButton(
              color: Colors.lightGreen,
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(_eEmail);
                  print(_eType);
                }
            ),
            SizedBox(height: 10.0),
            RaisedButton(
                color: Colors.orange,
                child: Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {

                }
            ),
          ],
        )

    );
  }
}
