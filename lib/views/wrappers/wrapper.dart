import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'file:///F:/Esoft/Android/horizon/lib/views/wrappers/second_wrapper.dart';
import 'package:horizon/views/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

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



