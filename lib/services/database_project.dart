
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/model/project.dart';

class ProjectDatabaseService{

  final CollectionReference projectCollection = FirebaseFirestore.instance.collection('projects');

  Future updateProjectData(String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus) async {

    return await projectCollection.doc().set({
      'projectName' : projectName,
      'startDate' : startDate,
      'endDate' : endDate,
      'projectCost' : projectCost,
      'projectManager' : projectManager,
      'projectClient' : projectClient,
      'projectStatus' : projectStatus,
    });

  }


  //project list from snapshot
  List<Project> _projectListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Project(
          projectName: doc.data()['projectName'] ?? '',
          startDate: doc.data()['startDate'] ?? '',
          endDate: doc.data()['endDate'] ?? '',
          projectCost: doc.data()['projectCost'] ?? '',
          projectManager: doc.data()['projectManager'] ?? '',
          projectClient: doc.data()['projectClient'] ?? '',
          projectStatus: doc.data()['projectStatus'] ?? ''
      );
    }).toList();
  }

  //get employees stream
  Stream<List<Project>> get projects {
    return projectCollection.snapshots()
        .map(_projectListFromSnapshot);
  }

}