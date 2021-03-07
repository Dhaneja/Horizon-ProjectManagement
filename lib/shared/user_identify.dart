import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/home/admin_home.dart';
import 'package:horizon/views/project/project_home.dart';
import 'package:horizon/views/task/task_home.dart';
import 'loading.dart';

class UserIdentify extends StatelessWidget {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    loading = true;
    FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .where('employeeId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      var userType = value.docs[0].data()['employeeType'];
      if (userType == "System Admin"){
        print(userType);
/*        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdminHome()));*/
loading = false;
return AdminHome();
      }
      else if (userType == "Project Manager"){
        print(userType);
/*        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProjectHome()));*/

return ProjectHome();
      }
      else if (userType == "Developer"){
        print(userType);
/*        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TaskHome()));*/
return TaskHome();
      }
    });
  /*
    return Scaffold(
      backgroundColor: Colors.brown[300],
      body: Center(
        child: FlutterLogo(
          size: 200,
        ),
        ),
      );*/
    return Loading();
  }
}
