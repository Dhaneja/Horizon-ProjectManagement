import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/views/project/project_setting_form.dart';


class ProjectTile extends StatelessWidget {

  final Project project;
  ProjectTile({this.project});


  @override
  Widget build(BuildContext context) {
    String projectIdValue, projectNameValue;
    String tempVal;

    String projectStat = project.pStatus;
    
    Color getColor(projectStat){
      if (projectStat == 'Ongoing'){
        /*projectColor = 'Colors.yellow[400]';*/
        return Colors.yellow[200];
      }else if (projectStat == 'Finished'){
        /*projectColor = 'Colors.green[400]';*/
        return Colors.green[200];
      }else if (projectStat == 'Cancelled'){
        /*projectColor = 'Colors.brown[400]';*/
        return Colors.brown[200];
      }else if (projectStat == 'On hold'){
        /*projectColor = 'Colors.red[400]';*/
        return Colors.red[200];
      }
      return Colors.grey[200];
    }



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
   /*        FirebaseFirestore.instance.collection('project').doc(selectedDoc)*/
/*           projectRef.get().then((snapshot) {
             snapshot.docs.forEach((doc) {
               tempVal = (doc.data()['B5Eu6fj70iGdoSX27E0k']);
               });
           });*/
           //print(FirebaseFirestore.instance.collection('projects').doc().data['projectId']);
           print(tempVal);
           print(projectIdValue);
           _showProjectPanel();
          },
        ),
      ),
    );
  }
}
