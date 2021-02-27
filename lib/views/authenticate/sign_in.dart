import 'package:flutter/material.dart';
import 'package:horizon/services/authservice.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();

  //Text field initialization
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Horizon PM Software'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                onChanged: (emailValue){
                  setState(() => email = emailValue);

                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
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
                  print(email);
                  print(password);
                },
              )
            ],
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
