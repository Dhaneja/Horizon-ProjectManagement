import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/services/database.dart';
import 'package:horizon/views/home/admin_home.dart';
import 'package:horizon/views/project/project_home.dart';

class AuthService{



  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create Employee object based on FirebaseUser
  Employee _userfromFirebaseUser(User user){
    return user != null ? Employee(eid: user.uid) : null;
  }

  //Auth Change User Stream
  Stream<Employee> get employee{
    return _auth.authStateChanges()
        //.map((User user) => _userfromFirebaseUser(user));
        .map(_userfromFirebaseUser);
  }


  //Sign in Anonymously

  Future signInAnonymous() async {

    try{

      UserCredential credential = await _auth.signInAnonymously();
      User user = credential.user;
      return _userfromFirebaseUser(user);

    }catch(error){

      print(error.toString());
      return null;

    }

  }

  //Sign in with Email & Password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      User user = credential.user;
      return _userfromFirebaseUser(user);

    }catch(error){
      print(error.toString());
      return null;
    }
  }



  //Register with Email & Password
  Future registerWithEmailAndPassword(String email, String password, String name, String type) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user;

      //create a new document for the user with eid
      await DatabaseService(eid: user.uid).updateUserData(user.uid, name, email, password, type);

      return _userfromFirebaseUser(user);

    }catch(error){
      print(error.toString());
      return null;
    }
  }


  //Password reset email
  Future passwordReset(String email) async{
    try {
      _auth.sendPasswordResetEmail(email: email);
    }catch(error){
      print(error);
    }
  }


  //Delete User with Auth







  //Sign Out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(error){
      print(error.toString());
      return null;
    }
  }

}