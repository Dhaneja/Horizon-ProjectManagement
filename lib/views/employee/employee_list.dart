import 'package:flutter/material.dart';
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

      //Provider
      final horizonUsers = Provider.of<List<Employee>>(context) ?? [];

      //Pass the data to a Tile
      return ListView.builder(
        itemBuilder: (context, index) {
          return EmployeeTile(employee: horizonUsers[index]);
        },
        itemCount: horizonUsers.length,
      );
    }
  }

