
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/services/auth_service.dart';

class ProjectDatabaseService{

  //Constructor
  final String pid;
  ProjectDatabaseService({this.pid});

  //Projects collection Reference
  final CollectionReference projectCollection = FirebaseFirestore.instance.collection('projects');

  //Tasks collection Reference
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');

  //Add Project Data
  Future addProjectData(String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus, String employeeId, String projectHoldReason) async {
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
      'projectHoldReason': projectHoldReason,
    });
    
  }


  //Update Project Data
  Future updateProjectData( String projectId, String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus, String employeeId, String projectHoldReason) async {

    try {
      return await projectCollection.where('projectId', isEqualTo: pid).get().then((value) => value.docs.forEach((element) { element.reference.update(
          {
            'projectId': projectId,
            'projectName': projectName,
            'startDate': startDate,
            'endDate': endDate,
            'projectCost': projectCost,
            'projectManager': projectManager,
            'projectClient': projectClient,
            'projectStatus': projectStatus,
            'employeeId': employeeId,
            'projectHoldReason': projectHoldReason,
          });
      })
      );
    }catch(error){
      print(error);
    }

  }


  //Project list from snapshot
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
          empId:  doc.data()['employeeId'] ?? '',
          pHoldReason: doc.data()['projectHoldReason'] ?? ''
      );
    }).toList();
  }

  //Task list from snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
        taskId: doc.data()['taskId'] ?? '',
        taskName: doc.data()['taskName'] ?? '',
        taskStatus: doc.data()['taskStatus'] ?? '',
        taskEmployee: doc.data()['taskEmployee'] ?? '',
        taskProjectId: pid
      );
    }).toList();
  }


  //Project Data from Snapshot
  Project _projectDataFromSnapshot(QuerySnapshot snapshot) {

      return Project(

          pid: snapshot.docs[0].data()['projectId'],
          pName: snapshot.docs[0].data()['projectName'],
          sDate: snapshot.docs[0].data()['startDate'],
          eDate: snapshot.docs[0].data()['endDate'],
          pCost: snapshot.docs[0].data()['projectCost'],
          pManager: snapshot.docs[0].data()['projectManager'],
          pClient: snapshot.docs[0].data()['projectClient'],
          pStatus: snapshot.docs[0].data()['projectStatus'],
          empId: snapshot.docs[0].data()['employeeId'],
          pHoldReason: snapshot.docs[0].data()['projectHoldReason']

      );
    }


  //Get projects into a stream
  Stream<List<Project>> get horizonProjects {
    return projectCollection.where('employeeId', isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots()
        .map(_projectListFromSnapshot);
  }

  //Get task list for a project into a stream
  Stream<List<Task>> get horizonTasks {
    return taskCollection.where('taskProjectId', isEqualTo: pid).snapshots()
        .map(_taskListFromSnapshot);
  }

  //Get project data into a stream
   Stream<Project> get projectData {
    return  projectCollection.where('projectId', isEqualTo: pid).snapshots()
        .map((_projectDataFromSnapshot));
  }

  //Get Project list which are on hold to a stream
  Stream<List<Project>> get holdProjects {
    return projectCollection.where('projectStatus', isEqualTo: 'On hold').snapshots()
        .map(_projectListFromSnapshot);
  }


}