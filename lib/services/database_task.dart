
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:horizon/model/task.dart';

class TaskDatabaseService{

  final String tid;
  TaskDatabaseService({this.tid});

  //Task Collection Reference
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');


  //Add Task Data
  Future addTaskData(String taskName, String taskStatus, String taskEmployee, String taskEmployeeId, String taskProjectId, String taskProjectName) async {

    return await taskCollection.add({

      'taskId': taskCollection.doc().id,
      'taskName': taskName,
      'taskStatus':taskStatus,
      'taskEmployee':taskEmployee,
      'taskEmployeeId': taskEmployeeId,
      'taskProjectId':taskProjectId,
      'taskProjectName' :taskProjectName

    });
  }

  //Update Task Data
  Future updateTaskData( String taskId, String taskName, String taskStatus, String taskEmployee, String taskEmployeeId, String taskProjectId, String taskProjectName) async {

    try {
      return await taskCollection.where('taskId', isEqualTo: tid).get().then((value) => value.docs.forEach((element) { element.reference.update(
          {
          'taskId': taskId,
          'taskName': taskName,
          'taskStatus': taskStatus,
          'taskEmployee': taskEmployee,
          'taskEmployeeId': taskEmployeeId,
          'taskProjectId': taskProjectId,
          'taskProjectName': taskProjectName
          });
      })
      );
    }catch(error){
      print(error);
    }

  }

  //Task data from snapshot
  Task _taskDataFromSnapshot(QuerySnapshot snapshot) {
/*    return snapshot.docs.forEach((doc) {*/
    return Task(
        taskId: snapshot.docs[0].data()['taskId'],
        taskName: snapshot.docs[0].data()['taskName'],
        taskStatus: snapshot.docs[0].data()['taskStatus'],
        taskEmployee: snapshot.docs[0].data()['taskEmployee'],
        taskEmployeeId: snapshot.docs[0].data()['taskEmployeeId'],
        taskProjectId:  snapshot.docs[0].data()['taskProjectId'],
        taskProjectName: snapshot.docs[0].data()['taskProjectName']

    );
  }


  //Task list from Snapshot
  List<Task> _taskListFromSnapshot(QuerySnapshot snapshot){
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

  
  //Get Task List Employee wise into a Stream for Employee Homepage
  Stream<List<Task>> get employeeTask {
    return taskCollection.where('taskEmployeeId', isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots()
        .map(_taskListFromSnapshot);
  }


  //Get task data into a stream
  Stream<Task> get taskData {
    return  taskCollection.where('taskId', isEqualTo: tid).snapshots()
        .map((_taskDataFromSnapshot));
  }


}