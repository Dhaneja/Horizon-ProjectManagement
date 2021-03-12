import 'package:flutter/material.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';


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


      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Login'),
        actions: <Widget>[
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child:SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[

              SizedBox(height: 20.0,),

              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/horizon.png', height: 100, width: 100,),
              ),

              SizedBox(height: 5.0,),
              Text('Horizon Pvt Ltd', style: TextStyle(fontSize: 20.0),),

              SizedBox(height: 40.0,),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Email',labelText: 'Email'),
                validator: (emailValue) => emailValue.isEmpty ? 'Email cannot be empty' : null,
                onChanged: (emailValue){
                  setState(() => email = emailValue);

                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputStyle.copyWith(hintText: 'Password',labelText: 'Password'),
                obscureText: true,
                validator: (emailValue) => emailValue.length < 6 ? 'Weak Password, Please enter a strong password' : null,
                onChanged: (passwordValue){
                  setState(() => password = passwordValue);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.blue[400],
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
