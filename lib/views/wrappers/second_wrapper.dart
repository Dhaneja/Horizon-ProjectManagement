import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/employee/employee_home.dart';
import 'package:horizon/views/home/admin_home.dart';
import 'package:horizon/views/home/project_home.dart';
import 'package:horizon/views/task/task_home.dart';

class SecondWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //StreamBuilder to access the stream to fetch values
    return StreamBuilder<QuerySnapshot>(

      //Get data from instant stream
      stream: FirebaseFirestore.instance.collection('users').where('employeeId', isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

        if(snapshot.hasError){

          return Loading();

        }switch(snapshot.connectionState){

          case ConnectionState.waiting: return Loading();

          default:

            return checkType(snapshot.data);
        }
      }
    );
  }

  //Check user type and decide on the HomePage using FireStore Query
  checkType(QuerySnapshot snapshot){

    if (snapshot.docs[0].data()['employeeType'] == 'System Admin'){

      return AdminHome();

    }else if (snapshot.docs[0].data()['employeeType'] == 'Project Manager'){

      return ProjectHome();

    }

    else if (snapshot.docs[0].data()['employeeType'] == 'Developer'){

      return EmployeeHome();

    }
  }
}
