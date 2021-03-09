
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/services/authservice.dart';

class ProjectDatabaseService{

  final String pid;
  ProjectDatabaseService({this.pid});

  //Collection Reference
  final CollectionReference projectCollection = FirebaseFirestore.instance.collection('projects');

  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');


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



  Future updateProjectData( String projectId, String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus, String employeeId) async {

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
          });
      })
      );
    }catch(error){
      print(error);
    }

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

  //project list from snapshot
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




  updateProject(selectedProject, newValues){
    FirebaseFirestore.instance
        .collection('projects')
        .doc(selectedProject)
        .update(newValues)
        .catchError((error){
      print(error);
    });
  }




  Project _projectDataFromSnapshot(QuerySnapshot snapshot) {
/*    return snapshot.docs.forEach((doc) {*/
      return Project(


          pid: snapshot.docs[0].data()['projectId'],
          pName: snapshot.docs[0].data()['projectName'],
          sDate: snapshot.docs[0].data()['startDate'],
          eDate: snapshot.docs[0].data()['endDate'],
          pCost: snapshot.docs[0].data()['projectCost'],
          pManager: snapshot.docs[0].data()['projectManager'],
          pClient: snapshot.docs[0].data()['projectClient'],
          pStatus: snapshot.docs[0].data()['projectStatus'],
          empId: snapshot.docs[0].data()['employeeId']
          /*empId: (doc['employeeId'])*/
      );
    }
  /*}*/



/*    return Project(


      pid: snapshot.docs.data()['projectId'],
      pName: snapshot.docs[pid].data()['projectName'],
      sDate: snapshot.data()['startDate'],
      eDate: snapshot.data()['endDate'],
      pCost: snapshot.data()['projectCost'],
      pManager: snapshot.data()['projectManager'],
      pClient: snapshot.data()['projectClient'],
      pStatus: snapshot.data()['projectStatus'],
      empId: snapshot.data()['employeeId']
    );*/



  //get project stream
  Stream<List<Project>> get horizonProjects {
    return projectCollection.where('employeeId', isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots()
        .map(_projectListFromSnapshot);
  }




  Stream<List<Task>> get horizonTasks {
    return taskCollection.where('taskProjectId', isEqualTo: pid).snapshots()
        .map(_taskListFromSnapshot);
  }




  //get project doc stream
   Stream<Project> get projectData {
    return  projectCollection.where('projectId', isEqualTo: pid).snapshots()
        .map((_projectDataFromSnapshot));
  }
/*  getProjects() async{
    return await FirebaseFirestore.instance.collection('projects').snapshots();
  }*/


}