import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/views/authenticate/register.dart';
import 'package:horizon/views/authenticate/sign_in.dart';
import 'package:horizon/views/employee/employee_add_form.dart';
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



    return StreamProvider<List<Employee>>.value(
      value: DatabaseService().horizonUsers,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Admin Home'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              textColor: Colors.white,
              onPressed: () async {
                await _authService.signOut();
                return SignIn();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.person_add),
              label: Text('Add'),
              textColor: Colors.white,
              onPressed: () {
                _showEmployeeAddPanel();
/*                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register())
                );*/
              },
            )
          ],
        ),
        body: EmployeeList(),
      ),
    );
  }
}
