import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/views/home/admin_developer_form.dart';
import 'package:horizon/views/home/admin_employee_setting_form.dart';
import 'package:horizon/views/home/admin_projectmanager_form.dart';

class EmployeeTile extends StatelessWidget {

  final Employee employee;
  EmployeeTile({this.employee});

    @override
    Widget build(BuildContext context) {
      String empValue;
      String empType = employee.eType;


      //Select Employee Image According to Employee Type
      AssetImage getImage(empType){
        if (empType == 'System Admin'){

          return AssetImage('assets/admin1.png');

        }else if (empType == 'Project Manager'){

          return AssetImage('assets/pm1.png');

        }else if (empType == 'Developer'){

          return AssetImage('assets/dev2.png');

        }
        return AssetImage('assets/pm.png');
      }


      //Popup the modalBottomSheet for Employee Form Admin View
      void _showEmployeePanel() {
        showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
          return Container(
            height: MediaQuery.of(context).size.height * 0.75 ,
            decoration: new BoxDecoration(
              color: Colors.grey[100],
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: AdminEmployeeForm(empValue: empValue),
          );
        });
      }

      //Popup the modalBottomSheet for Employee Form for Developer
      void _showDeveloperPanel() {
        showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
          return Container(
            height: MediaQuery.of(context).size.height * 0.85 ,
            decoration: new BoxDecoration(
              color: Colors.grey[100],
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: AdminDeveloperForm(empValue: empValue),
          );
        });
      }

      //Popup the modalBottomSheet for Project Manager Form
      void _showProjectManagerPanel() {
        showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
          return Container(
            height: MediaQuery.of(context).size.height * 0.85 ,
            decoration: new BoxDecoration(
              color: Colors.grey[100],
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: AdminProjectManagerForm(empValue: empValue),
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
              backgroundColor: Colors.grey[100],
              backgroundImage: getImage(empType),
            ),

            title: Text(employee.eName),
            subtitle: Text(employee.eType),

            onTap: () {
            //Get the employee id to a String variable to pass into the next screen
              empValue = employee.eid.toString();

              //Select which Modal Bottom sheet to display according to user type
              if (empType == 'Developer') {

                _showDeveloperPanel();

              }
              else if (empType == 'Project Manager') {

                _showProjectManagerPanel();

              } else if (empType == 'System Admin') {

                _showEmployeePanel();

              }

            },
          ),
        ),
      );
    }
  }
