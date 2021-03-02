import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';


class ProjectTile extends StatelessWidget {

  final Project project;
  ProjectTile({this.project});

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
          title: Text(project.projectName),
          subtitle: Text('by  ${project.projectClient} '),
        ),
      ),
    );
  }
}
