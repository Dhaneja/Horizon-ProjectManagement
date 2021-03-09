import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/services/user_access.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/home/admin_home.dart';
import 'package:horizon/views/home/home.dart';
import 'package:horizon/views/project/project_home.dart';
import 'package:horizon/views/task/task_home.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field initialization
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Welcome to Horizon pvt ltd'),
/*        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],*/
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Email Address'),
                validator: (emailValue) => emailValue.isEmpty ? 'Email cannot be empty' : null,
                onChanged: (emailValue){
                  setState(() => email = emailValue);

                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (emailValue) => emailValue.length < 6 ? 'Weak Password, Please enter a strong password' : null,
                onChanged: (passwordValue){
                  setState(() => password = passwordValue);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.orangeAccent[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    loading = false;
                    dynamic result = await _authService.signInWithEmailAndPassword(email, password);

                    if (result == null) {
                      setState(() {
                        error = 'Login Failed';
                        loading = false;
                      });
                    }else{
                      error = 'Login Failed';
                    }
                  }
                }
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
          ),
        ),

        /*child: RaisedButton(
          child: Text('Sign in Anonymously'),
          onPressed: () async{
            dynamic result = await _authService.signInAnonymous();
            if (result == null){
              print('Error signing in');
            }else{
              print('Signed in');
              print(result.eid);
            }
          },
        ),*/
      ),
    );
  }
}
