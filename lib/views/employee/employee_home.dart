import 'package:flutter/material.dart';
import 'package:horizon/model/task.dart';
import 'package:horizon/services/database_task.dart';
import 'package:horizon/views/project/employee_setting_form.dart';
import 'package:horizon/views/task/task_employee_list.dart';
import 'package:provider/provider.dart';

class EmployeeHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Popup the modalBottomSheet for Employee Form
    void _showCurrentEmployeePanel() {
      showModalBottomSheet<dynamic>(isScrollControlled: true, backgroundColor: Colors.transparent, context: context, builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height * 0.75 ,
          decoration: new BoxDecoration(
            color: Colors.grey[200],
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

    //Stream Provider to List the Tasks using TaskHomeList
    return StreamProvider<List<Task>>.value(

      //TaskDatabaseService used to access the stream employeeTask
      value: TaskDatabaseService().employeeTask,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text('Tasks'),
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            actions: <Widget>[

              //Icon to display the Current Employee details panel
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: ()  {
                    _showCurrentEmployeePanel();
                  }
              ),
            ]
        ),

        body: TaskHomeList(),

      ),
    );
  }
}
