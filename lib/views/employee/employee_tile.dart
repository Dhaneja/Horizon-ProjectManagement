import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';

class EmployeeTile extends StatelessWidget {

  final Employee employee;
  EmployeeTile({this.employee});

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[100],
            ),
            title: Text(employee.eName),
            subtitle: Text(employee.eType),
          ),
        ),
      );
    }
  }
