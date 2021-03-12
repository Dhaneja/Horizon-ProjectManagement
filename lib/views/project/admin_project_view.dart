import 'package:flutter/material.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/views/project/employee_setting_form.dart';
import 'package:horizon/views/project/project_list.dart';
import 'package:provider/provider.dart';

class AdminProjectView extends StatelessWidget {

  AdminProjectView(this.empValue, this.empName);
  final String empValue, empName;

  @override
  Widget build(BuildContext context) {


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


    return StreamProvider<List<Project>>.value(

      value: DatabaseService(eid: empValue).adminProjectManagerProject,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text('Projects of $empName'),
            backgroundColor: Colors.blue[400],
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: ()  {
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

