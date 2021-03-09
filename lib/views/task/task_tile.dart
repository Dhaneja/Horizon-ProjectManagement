import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/views/task/task_setting_form.dart';

class TaskTile extends StatelessWidget {

  final Task task;
  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    String taskValue;

    void _showTaskPanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.65 ,
          decoration: new BoxDecoration(
            color: Colors.brown[100],
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: TaskForm(taskValue: taskValue),
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
            backgroundColor: Colors.brown[100],
          ),
          title: Text(task.taskName),
          subtitle: Text('Assigned to:  ${task.taskEmployee} '),
          onTap: () {
            taskValue = task.taskId.toString();
            print(taskValue);
            /*        FirebaseFirestore.instance.collection('project').doc(selectedDoc)*/
/*           projectRef.get().then((snapshot) {
             snapshot.docs.forEach((doc) {
               tempVal = (doc.data()['B5Eu6fj70iGdoSX27E0k']);
               });
           });*/
            //print(FirebaseFirestore.instance.collection('projects').doc().data['projectId']);
/*            print(tempVal);
            print(projectValue)*/;
            _showTaskPanel();
          },
        ),
      ),

    );
  }
}
