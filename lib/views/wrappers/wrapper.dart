import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'file:///F:/Esoft/Android/horizon/lib/views/wrappers/second_wrapper.dart';
import 'package:horizon/views/authenticate/authenticate.dart';
import 'package:horizon/views/authenticate/sign_in.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<Employee>(context);


    //Return either LogIn Page or Second Wrapper depending on Firebase Auth
    if (currentUser == null) {


      return SignIn();
    } else {

      return SecondWrapper();

    }
  }

}




