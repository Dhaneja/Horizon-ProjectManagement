import 'package:flutter/material.dart';
import 'package:horizon/views/authenticate/register.dart';
import 'package:horizon/views/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signInStatus = true;
  void toggleView() {
    setState(() => signInStatus = !signInStatus);
  }

  @override
  Widget build(BuildContext context) {
    if(signInStatus) {
      return SignIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}
