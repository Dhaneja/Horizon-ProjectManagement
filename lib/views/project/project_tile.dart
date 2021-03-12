import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/views/project/project_setting_form.dart';


class ProjectTile extends StatelessWidget {

  //Constructor
  final Project project;
  ProjectTile({this.project});


  @override
  Widget build(BuildContext context) {

    String projectIdValue, projectNameValue;

    String projectStat = project.pStatus;

    //Select Color according to project Status
    Color getColor(projectStat){

      if (projectStat == 'Ongoing'){

        return Colors.yellow[200];

      }else if (projectStat == 'Finished'){

        return Colors.green[200];

      }else if (projectStat == 'Cancelled'){

        return Colors.brown[200];

      }else if (projectStat == 'On hold'){

        return Colors.red[200];

      }
      return Colors.grey[200];
    }



    //Popup the modalBottomSheet for Project Add Form
    void _showProjectPanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.95 ,
          decoration: new BoxDecoration(
            color: Colors.grey[200],
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: ProjectForm(projectIdValue: projectIdValue, projectNameValue: projectNameValue),
        );

      });
    }



    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(

          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: getColor(projectStat),
          ),

          title: Text(project.pName),
          subtitle: Text('by  ${project.pClient} '),

          onTap: () {
           projectIdValue = project.pid.toString();
           projectNameValue = project.pName.toString();

           //Project Edit Panel
           _showProjectPanel();

           },
        ),
      ),
    );
  }
}
