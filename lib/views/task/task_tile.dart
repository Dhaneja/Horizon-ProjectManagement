import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/views/task/task_setting_form.dart';

class TaskTile extends StatelessWidget {

  final Task task;
  TaskTile({this.task});

  @override
  Widget build(BuildContext context) {
    String taskValue;
    String taskStat = task.taskStatus;

    //Select Color according to task Status
    Color getColor(taskStat){
      if (taskStat == 'Ongoing'){

        return Colors.yellow[200];

      }else if (taskStat == 'Finished'){

        return Colors.green[200];

      }else if (taskStat == 'Cancelled'){

        return Colors.brown[200];

      }else if (taskStat == 'On hold'){

        return Colors.red[200];

      }
      return Colors.grey[200];
    }

    //Popup the modalBottom
    void _showTaskPanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.65 ,
          decoration: new BoxDecoration(
            color: Colors.grey[200],
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
            backgroundColor: getColor(taskStat),
          ),
          title: Text(task.taskName),
          subtitle: Text('Assigned to:  ${task.taskEmployee} '),
          onTap: () {
            taskValue = task.taskId.toString();

            //Show Task Details Panel
            _showTaskPanel();

          },
        ),
      ),

    );
  }
}
