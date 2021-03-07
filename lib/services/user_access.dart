import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/views/authenticate/sign_in.dart';
import 'package:horizon/views/home/admin_home.dart';
import 'package:horizon/views/home/home.dart';
import 'package:flutter/material.dart';


class UserAccess {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget handleUser() {
    return new StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot){
        if(snapshot.hasData){
          return Home();
        }else{
          return SignIn();
        }
      }
    );
  }

  authorizeAccess(BuildContext context){
    FirebaseFirestore.instance
        .collection('users')
        .where('employeeId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
          if (value.docs[0].exists){
            if(value.docs[0].data()['employeeType'] == 'System Admin'){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminHome()));
            }else{
              print('Not Authorized');
            }
          }
/*          value.docs.forEach((element) {
            FirebaseFirestore.instance.collection('users')
                .where('employeeType', isEqualTo: 'Admin')
                .get()
                .then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AdminHome()));
            });
          });*/
    }


    );
  }

}