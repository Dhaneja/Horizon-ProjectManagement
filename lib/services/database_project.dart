
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/services/authservice.dart';

class ProjectDatabaseService{

  final String pid;
  ProjectDatabaseService({this.pid});

  //Collection Reference
  final CollectionReference projectCollection = FirebaseFirestore.instance.collection('projects');


  Future addProjectData(String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus, String employeeId) async {
    return await projectCollection.add({
      'projectId' : projectCollection.doc().id,
      'projectName': projectName,
      'startDate': startDate,
      'endDate': endDate,
      'projectCost': projectCost,
      'projectManager': projectManager,
      'projectClient': projectClient,
      'projectStatus': projectStatus,
      'employeeId': employeeId,
    });
    
  }

  Future updateProjectData(String projectId, String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus, String employeeId) async {


    return await projectCollection.doc(pid).set({
      'projectId' : projectId,
      'projectName' : projectName,
      'startDate' : startDate,
      'endDate' : endDate,
      'projectCost' : projectCost,
      'projectManager' : projectManager,
      'projectClient' : projectClient,
      'projectStatus' : projectStatus,
      'employeeId' : employeeId,
    });

  }


  //project list from snapshot
  List<Project> _projectListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Project(
          pid: doc.data()['projectId'] ?? '',
          pName: doc.data()['projectName'] ?? '',
          sDate: doc.data()['startDate'] ?? '',
          eDate: doc.data()['endDate'] ?? '',
          pCost: doc.data()['projectCost'] ?? '',
          pManager: doc.data()['projectManager'] ?? '',
          pClient: doc.data()['projectClient'] ?? '',
          pStatus: doc.data()['projectStatus'] ?? '',
          empId:  doc.data()['employeeId'] ?? ''
      );
    }).toList();
  }

  Project _projectDataFromSnapshot(DocumentSnapshot snapshot){


    return Project(
      pid: snapshot.data()['projectId'],
      pName: snapshot.data()['projectName'],
      sDate: snapshot.data()['startDate'],
      eDate: snapshot.data()['endDate'],
      pCost: snapshot.data()['projectCost'],
      pManager: snapshot.data()['projectManager'],
      pClient: snapshot.data()['projectClient'],
      pStatus: snapshot.data()['projectStatus'],
      empId: snapshot.data()['employeeId']
    );
  }


  //get project stream
  Stream<List<Project>> get horizonProjects {
    return projectCollection.snapshots()
        .map(_projectListFromSnapshot);
  }

  //get project doc stream
  Stream<Project> get projectData{
    return projectCollection.doc(pid).snapshots()
        .map((_projectDataFromSnapshot));
  }



}