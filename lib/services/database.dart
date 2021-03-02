import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/model/project.dart';

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

  //project list from snapshot
  List<Project> _projectlistFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Project(
        projectName: doc.data()['projectName'] ?? '',
        startDate: doc.data()['startDate'] ?? '',
        endDate: doc.data()['endDate'] ?? '',
        projectCost: doc.data()['projectCost'] ?? '',
        projectManager: doc.data()['projectManager'] ?? '',
        projectClient: doc.data()['projectClient'] ?? '',
        projectStatus: doc.data()['projectStatus'] ?? ''
      );
    });
  }

  //get user stream
  Stream<QuerySnapshot> get horizonUsers {
    return userCollection.snapshots();
  }

}