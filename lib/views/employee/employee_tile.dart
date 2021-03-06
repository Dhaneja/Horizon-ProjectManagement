import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/views/home/employee_form.dart';

class EmployeeTile extends StatelessWidget {

  final Employee employee;
  EmployeeTile({this.employee});

    @override
    Widget build(BuildContext context) {

      void _showEmployeePanel() {
        showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: new BoxDecoration(
              color: Colors.brown[100],
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: EmployeeForm(),
          );
        });
      }

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
            onTap: () {
              _showEmployeePanel();
            },
          ),
        ),
      );
    }
  }
