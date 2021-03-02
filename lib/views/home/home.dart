import 'package:flutter/material.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/views/home/admin_home.dart';
import 'package:horizon/views/project/project_home.dart';
import '../project/project_add.dart';

class Home extends StatelessWidget {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Horizon Home'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _authService.signOut();

            },
          )
        ],
      ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                RaisedButton(
                    color: Colors.orangeAccent[400],
                    child: Text(
                      'Projects',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminHome())
                      );
                    }
                ),
              ],
          )
        ),
      )
    );
  }
}
