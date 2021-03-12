import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/views/employee/employee_add_form.dart';
import 'package:horizon/views/project/employee_setting_form.dart';
import 'package:horizon/views/project/onhold_project_view.dart';
import 'package:provider/provider.dart';
import '../employee/employee_list.dart';

class AdminHome extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {


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



    return StreamProvider<List<Employee>>.value(
      value: DatabaseService().horizonUsers,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Administrator'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
/*            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              textColor: Colors.white,
              onPressed: () async {
                await _authService.signOut();
                return SignIn();
              },
            ),*/
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                _showEmployeeAddPanel();
/*                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register())
                );*/
              },
            ),

            IconButton(
                icon: Icon(Icons.error),
                /*color: Colors.black,*/
                /*label: Text('Add'),*/
                onPressed: ()  {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OnHoldProjectView())
                  );
                }
            ),

            IconButton(
                icon: Icon(Icons.settings),
                /*color: Colors.black,*/
                /*label: Text('Add'),*/
                onPressed: ()  {
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
