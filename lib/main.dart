import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:horizon/services/auth_service.dart';
import 'package:horizon/views/wrappers/wrapper.dart';
import 'package:provider/provider.dart';

import 'model/employee.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String emp;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Employee>.value(
      value: AuthService().employee,
      child: MaterialApp(

        //Forward to Wrapper
        home: Wrapper(),

      ),
    );
  }
}

