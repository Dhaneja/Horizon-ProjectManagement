import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database_project.dart';
import 'file:///F:/Esoft/Android/horizon/lib/views/project/employee_setting_form.dart';
import 'package:horizon/views/project/project_add.dart';
import 'package:horizon/views/project/project_list.dart';
import 'package:provider/provider.dart';

class ProjectHome extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showCurrentEmployeePanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.65 ,
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


    return StreamProvider<List<Project>>.value(
      value: ProjectDatabaseService().horizonProjects,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Projects'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _authService.signOut();
          }
        ),
            IconButton(
              icon: Icon(Icons.add),
              /*color: Colors.black,*/
              /*label: Text('Add'),*/
              onPressed: () async {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProjectAdd()));
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

