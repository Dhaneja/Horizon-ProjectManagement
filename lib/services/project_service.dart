

import 'package:horizon/services/database_project.dart';

class ProjectService{

  Future createProject(String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus, String employeeId) async {

    try{

      await ProjectDatabaseService().addProjectData(projectName, startDate, endDate, projectCost, projectManager, projectClient, projectStatus, employeeId);

          return null;

    }catch(error){

      print(error.toString());
      return null;


    }

  }

}