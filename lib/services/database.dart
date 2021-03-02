import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/model/employee.dart';

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

  //employee list from snapshot
  List<Employee> _employeeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Employee(
        eid: doc.data()['employeeId'] ?? '',
        eEmail: doc.data()['employeeEmail'] ?? '',
        eName: doc.data()['employeeName'] ?? '',
        ePassword: doc.data()['employeePassword'] ?? '',
        eType: doc.data()['employeeType'] ?? ''
      );
    }).toList();
  }


  //get user stream
  Stream<List<Employee>> get horizonUsers {
    return userCollection.snapshots()
        .map(_employeeListFromSnapshot);
  }

}