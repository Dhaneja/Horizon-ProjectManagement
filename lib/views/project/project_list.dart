import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/views/project/project_tile.dart';
import 'package:provider/provider.dart';

class ProjectList extends StatefulWidget {
  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {

    //Provider
    final horizonProjects = Provider.of<List<Project>>(context) ?? [];

    //Pass the data to a Tile
    return ListView.builder(
      itemBuilder: (context, index){
        return ProjectTile(project: horizonProjects[index]);
      },
      itemCount: horizonProjects.length,
    );
  }
}

