import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/second_wrapper.dart';
import 'package:horizon/shared/user_identify.dart';
import 'package:horizon/views/authenticate/authenticate.dart';
import 'package:horizon/views/authenticate/register.dart';
import 'package:horizon/views/employee/employee_home.dart';
import 'package:horizon/views/home/admin_home.dart';
import 'package:horizon/views/home/home.dart';
import 'package:horizon/views/project/project_home.dart';
import 'package:horizon/views/task/task_home.dart';
import 'package:provider/provider.dart';
import 'package:horizon/shared/loading.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<Employee>(context);


    //return either Home or Authenticate widget
    if (currentUser == null) {
      return Authenticate();
    } else {
      return SecondWrapper();
    }
  }

}
/*    _selectInterface(){
     FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('users')
          .where('employeeId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        var userType = value.docs[0].data()['employeeType'];
        if (userType == "System Admin"){
          print(userType);
          return AdminHome();
          var loading = false;
        }
        else if (userType == "Project Manager"){
          print(userType);
          return ProjectHome();
          var loading = false;
        }
        else{
          print(userType);
          return EmployeeHome();
          var loading = false;
        }
      });
    }*/



