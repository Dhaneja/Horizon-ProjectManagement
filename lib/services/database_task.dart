
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDatabaseService{

  final String pid;
  TaskDatabaseService({this.pid});

  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');

  Future updateTaskData(String taskName, String taskEmployee, String taskStatus) async {

    return await taskCollection.doc(pid).set({

      'taskName': taskName,
      'taskEmployee' : taskEmployee,
      'taskStatus' : taskStatus,

    });

  }

}