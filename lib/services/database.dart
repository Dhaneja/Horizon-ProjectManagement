import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/model/employee.dart';

class DatabaseService {

  final String eid;
  DatabaseService({this.eid});

  //Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String employeeId,String employeeName, String employeeEmail, String employeePassword, String employeeType) async {

    return await userCollection.doc(eid).set({
      'employeeId' : employeeId,
      'employeeName' : employeeName,
      'employeeEmail' : employeeEmail,
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

  //Employee Data from Snapshot
  Employee _employeeDataFromSnapshot(DocumentSnapshot snapshot){
    return Employee(
      eid: snapshot.data()['employeeId'],
      eName: snapshot.data()['employeeName'],
      eEmail: snapshot.data()['employeeEmail'],
      ePassword: snapshot.data()['employeePassword'],
      eType: snapshot.data()['employeeType']
    );
  }


  //get user stream
  Stream<List<Employee>> get horizonUsers {
    return userCollection.snapshots()
        .map(_employeeListFromSnapshot);
  }

  //get user doc stream
  Stream<Employee> get employeeData{
    return userCollection.doc(eid).snapshots()
        .map((_employeeDataFromSnapshot));
  }

  //Delete User with Auth
  Future deleteUser() {
    return userCollection.doc(eid).delete();
  }
}