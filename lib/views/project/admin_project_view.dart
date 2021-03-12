import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/views/authenticate/sign_in.dart';
import 'package:horizon/views/project/employee_setting_form.dart';
import 'package:horizon/views/project/project_add_form.dart';
import 'package:horizon/views/project/project_list.dart';
import 'package:provider/provider.dart';

class AdminProjectView extends StatelessWidget {

  final AuthService _authService = AuthService();

  AdminProjectView(this.empValue, this.empName);
  final String empValue, empName;

  @override
  Widget build(BuildContext context) {

    void _showProjectAddPanel() {
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
          child: ProjectAddForm(),
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


    return StreamProvider<List<Project>>.value(

      value: DatabaseService(eid: empValue).adminProjectManagerProject,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text('Projects of $empName'),
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            actions: <Widget>[
/*          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _authService.signOut();
              return SignIn();
          }
        ),*/
/*              IconButton(
                  icon: Icon(Icons.add),
                  *//*color: Colors.black,*//*
                  *//*label: Text('Add'),*//*
                  onPressed: () {
*//*                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProjectAdd()));*//*
                    _showProjectAddPanel();
                  }
              ),*/
              IconButton(
                  icon: Icon(Icons.settings),
                  /*color: Colors.black,*/
                  /*label: Text('Add'),*/
                  onPressed: ()  {
                    _showCurrentEmployeePanel();
                  }
              ),
/*            FlatButton.icon(
              icon: Icon(Icons.create),
              //label: Text('update'),
              onPressed: () => _projectDataPanel(),
            )*/
            ]
        ),
        body: ProjectList(),
      ),
    );
  }
}

