import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/views/project/project_list.dart';
import 'package:provider/provider.dart';

class ProjectHome extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Project>>.value(
      value: ProjectDatabaseService().projects,
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
       ]
      ),
        body: ProjectList(),
    ),
   );
  }
}

