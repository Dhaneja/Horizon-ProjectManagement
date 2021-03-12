import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/model/employee.dart';
import 'package:horizon/model/project.dart';
import 'package:horizon/model/task.dart';

class DatabaseService {

  final String eid;
  DatabaseService({this.eid});

  //Users Collection Reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  //Tasks Collection Reference
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');

  //Projects Collection Reference
  final CollectionReference projectCollection = FirebaseFirestore.instance.collection('projects');

  //Update Employee Data Function
  Future updateUserData(String employeeId,String employeeName, String employeeEmail, String employeePassword, String employeeType) async {

    return await userCollection.doc(eid).set({
      'employeeId' : employeeId,
      'employeeName' : employeeName,
      'employeeEmail' : employeeEmail,
      'employeePassword' : employeePassword,
      'employeeType' : employeeType,
    });

  }


  //Employee list from snapshot
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

  //Task list from Snapshot
  List<Task> _taskDevListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
          taskId: doc.data()['taskId'] ?? '',
          taskName: doc.data()['taskName'] ?? '',
          taskStatus: doc.data()['taskStatus'] ?? '',
          taskEmployee: doc.data()['taskEmployee'] ?? '',
          taskEmployeeId: doc.data()['taskEmployeeId'] ?? '',
          taskProjectId: doc.data()['taskProjectId'] ?? '',
          taskProjectName: doc.data()['taskProjectName'] ?? ''
      );
    }).toList();

  }


  //Project list from snapshot
  List<Project> _projectPMListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Project(
          pid: doc.data()['projectId'] ?? '',
          pName: doc.data()['projectName'] ?? '',
          sDate: doc.data()['startDate'] ?? '',
          eDate: doc.data()['endDate'] ?? '',
          pCost: doc.data()['projectCost'] ?? '',
          pManager: doc.data()['projectManager'] ?? '',
          pClient: doc.data()['projectClient'] ?? '',
          pStatus: doc.data()['projectStatus'] ?? '',
          empId:  doc.data()['employeeId'] ?? ''
      );
    }).toList();
  }

  //Delete User with Auth
  Future deleteUser() {
    return userCollection.doc(eid).delete();
  }


  //Get user stream
  Stream<List<Employee>> get horizonUsers {
    return userCollection.snapshots()
        .map(_employeeListFromSnapshot);
  }

  //Get user doc stream
  Stream<Employee> get employeeData{
    return userCollection.doc(eid).snapshots()
        .map((_employeeDataFromSnapshot));
  }

  //Get Task according to EmployeeId to a stream
  Stream<List<Task>> get adminEmployeeTask {
    return taskCollection.where('taskEmployeeId', isEqualTo: eid).snapshots()
        .map(_taskDevListFromSnapshot);
  }

  //Get Projects employee wise to a stream
  Stream<List<Project>> get adminProjectManagerProject {
    return projectCollection.where('employeeId', isEqualTo: eid).snapshots()
        .map(_projectPMListFromSnapshot);
  }





}