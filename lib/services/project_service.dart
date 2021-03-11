

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/views/project/project_home.dart';

class ProjectService{

  Future createProject(String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus, String employeeId) async {

    try{

      await ProjectDatabaseService().addProjectData(projectName, startDate, endDate, projectCost, projectManager, projectClient, projectStatus, employeeId);

          return ProjectHome();

    }catch(error){

      print(error.toString());
      return null;
      
    }

  }
  

  

}