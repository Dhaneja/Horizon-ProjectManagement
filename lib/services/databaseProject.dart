
import 'package:cloud_firestore/cloud_firestore.dart';

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
}