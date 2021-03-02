

import 'package:horizon/services/database_project.dart';

class ProjectService{

  Future createProject(String projectName, String startDate, String endDate, String projectCost, String projectManager, String projectClient, String projectStatus) async {

    try{

      await ProjectDatabaseService().updateProjectData(projectName, startDate, endDate, projectCost, projectManager, projectClient, projectStatus);

          return null;

    }catch(error){

      print(error.toString());
      return null;


    }

  }

}