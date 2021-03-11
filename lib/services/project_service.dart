import 'package:horizon/services/database_project.dart';
import 'file:///F:/Esoft/Android/horizon/lib/views/home/project_home.dart';

class ProjectService{

  //Pass Data to ProjectDatabaseService
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