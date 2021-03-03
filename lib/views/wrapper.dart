import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/views/authenticate/authenticate.dart';
import 'package:horizon/views/home/home.dart';
import 'package:horizon/views/project/project_home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final currentUser = Provider.of<Employee>(context);

    //return either Home or Authenticate widget
    if (currentUser == null){
      return Authenticate();
    }else{
      return Home();
    }
    
  }
}
