import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database.dart';
import 'package:provider/provider.dart';
import '../employee/employee_list.dart';

class AdminHome extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Employee>>.value(
      value: DatabaseService().horizonUsers,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Admin Home'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _authService.signOut();
              },
            )
          ],
        ),
        body: EmployeeList(),
      ),
    );
  }
}
