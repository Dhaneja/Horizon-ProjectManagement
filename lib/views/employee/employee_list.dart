import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/views/employee/employee_tile.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {
      final horizonUsers = Provider.of<List<Employee>>(context);

      return ListView.builder(
        itemBuilder: (context, index) {
          return EmployeeTile(employee: horizonUsers[index]);
        },
        itemCount: horizonUsers.length,);
    }
  }

