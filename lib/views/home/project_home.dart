import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/services/database_project.dart';
import 'package:horizon/views/project/employee_setting_form.dart';
import 'package:horizon/views/project/project_add_form.dart';
import 'package:horizon/views/project/project_list.dart';
import 'package:provider/provider.dart';

class ProjectHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Popup the modalBottomSheet for Project Add Form
    void _showProjectAddPanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.85 ,
          decoration: new BoxDecoration(
            color: Colors.grey[100],
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: ProjectAddForm(),
        );
      });
    }


    //Popup the modalBottomSheet for Current Employee Data Edit Form
    void _showCurrentEmployeePanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: new BoxDecoration(
            color: Colors.grey[100],
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: EmployeeForm(),
        );
      });
    }

    //Stream Provider to List the Projects using horizonProjects
    return StreamProvider<List<Project>>.value(
      //Get data from horizonProjects stream in DatabaseService
      value: ProjectDatabaseService().horizonProjects,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Projects'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[

            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {

                //Display the Modal Bottom Sheet to add Project Data
                _showProjectAddPanel();

              }
                ),

            IconButton(
                icon: Icon(Icons.settings),

                onPressed: ()  {

                  //Current Employee Details panel
                  _showCurrentEmployeePanel();

                }
            ),
       ]
      ),

        body: ProjectList(),

      ),
   );
  }
}

