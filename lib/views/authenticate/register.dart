import 'package:flutter/material.dart';
import 'package:horizon/services/authservice.dart';
import 'package:horizon/shared/constants.dart';
import 'package:horizon/shared/loading.dart';
import 'package:horizon/views/home/admin_home.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //Text field initialization
  String name = '';
  String email = '';
  String password = '';
  String type = '';
  String error = '';

  final List<String> employeeTypes = ['Project Manager', 'Developer', 'System Admin'];

  @override
  Widget build(BuildContext context) {
      return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Add Employee'),
          actions: <Widget>[
          ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputStyle.copyWith(hintText: 'Employee Name'),
                  validator: (nameValue) => nameValue.isEmpty ? 'Name cannot be empty' : null,
                  onChanged: (nameValue){
                    setState(() => name = nameValue);

                  },
                ),

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
                  validator: (passwordValue) => passwordValue.length < 6 ? 'Weak Password, Please enter a strong password' : null,
                  onChanged: (passwordValue){
                    setState(() => password = passwordValue);
                  },
                ),


                SizedBox(height: 20.0,),
                DropdownButtonFormField(
                  decoration: textInputStyle.copyWith(hintText: 'Employee Type'),
                  validator: (typeValue) => typeValue.isEmpty ? 'Employee Type cannot be empty' : null,
                  items: employeeTypes.map((employeeType) {
                    return DropdownMenuItem(
                      value: employeeType,
                      child: Text('$employeeType'),
                    );
                  }).toList(),
                  onChanged: (typeValue) => setState(() => type = typeValue),
                ),

                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.orangeAccent[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _authService.registerWithEmailAndPassword(email, password, name, type);
                      if(result == null){
                        setState(() {
                          error = 'Please enter a valid email';
                          loading = false;
                        });
                      }else
                        {
                          loading = false;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AdminHome())
                          );

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
        ),
      );
   }
}
