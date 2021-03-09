import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/views/task/task_employee_form.dart';

class TaskEmployeeTile extends StatelessWidget {

  final Task taskHomeList;
  TaskEmployeeTile({this.taskHomeList});

  @override
  Widget build(BuildContext context) {
    String taskIdValue;

    void _showEmployeeTaskPanel() {
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
          child: EmployeeTaskForm(taskIdValue: taskIdValue),
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
          title: Text(taskHomeList.taskName),
          subtitle: Text('For  ${taskHomeList.taskProjectName} '),
          onTap: () {
            taskIdValue = taskHomeList.taskId.toString();
            print(taskIdValue);
            _showEmployeeTaskPanel();
          },
        ),
      ),

    );
  }
}
