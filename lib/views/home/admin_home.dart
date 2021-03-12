import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/auth_service.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/views/employee/employee_add_form.dart';
import 'package:horizon/views/project/employee_setting_form.dart';
import 'package:horizon/views/project/onhold_project_view.dart';
import 'package:provider/provider.dart';
import '../employee/employee_list.dart';

class AdminHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    //Popup the modalBottomSheet for Employee Add Form
    void _showEmployeeAddPanel() {
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
          child: EmployeeAddForm(),
        );
      });
    }


    //Popup the modalBottomSheet for Admin Data Edit Form
    void _showCurrentEmployeePanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: new BoxDecoration(
            color: Colors.grey[100],
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


    //Stream Provider to List the Employees using horizonUsers
    return StreamProvider<List<Employee>>.value(

      //Get data from horizonUsers stream in DatabaseService
      value: DatabaseService().horizonUsers,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Administrator'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {

                //Display the Modal Bottom Sheet to add employee Data
                _showEmployeeAddPanel();

                },
            ),

            IconButton(
                icon: Icon(Icons.error),
                color: Colors.red[100],
                onPressed: ()  {

                  //Display On hold Projects
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OnHoldProjectView())
                  );
                }
            ),

            IconButton(

                icon: Icon(Icons.settings),

                onPressed: ()  {

                  //Current Employee Details panel
                  _showCurrentEmployeePanel();

                }
            ),

          ],
        ),
        body: EmployeeList(),
      ),
    );
  }
}
