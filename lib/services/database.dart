import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String eid;
  DatabaseService({this.eid});

  //Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String employeeName, String employeeEmail, String employeePassword, String employeeType) async {

    return await userCollection.doc(eid).set({
      'employeeName' : employeeName,
      'eployeeEmail' : employeeEmail,
      'employeePassword' : employeePassword,
      'employeeType' : employeeType,
    });

  }



}