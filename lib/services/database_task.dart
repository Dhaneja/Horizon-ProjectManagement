
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/model/task.dart';

class TaskDatabaseService{

  final String tid;
  TaskDatabaseService({this.tid});

  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');


/*  Future updateTaskData(String taskId, String taskName, String taskEmployee, String taskStatus) async {

    return await taskCollection.doc(pid).set({

      'taskId' : taskId,
      'taskName': taskName,
      'taskEmployee' : taskEmployee,
      'taskStatus' : taskStatus,

    });

  }*/

  Future updateTaskData( String taskId, String taskName, String taskStatus, String taskEmployee, String projectId) async {

    try {
      return await taskCollection.where('taskId', isEqualTo: tid).get().then((value) => value.docs.forEach((element) { element.reference.update(
          {
          'taskId': taskId,
          'taskName': taskName,
          'taskStatus': taskStatus,
          'taskEmployee': taskEmployee,
          'projectId': projectId,
          });
      })
      );
    }catch(error){
      print(error);
    }

  }

  Task _taskDataFromSnapshot(QuerySnapshot snapshot) {
/*    return snapshot.docs.forEach((doc) {*/
    return Task(
        taskId: snapshot.docs[0].data()['taskId'],
        taskName: snapshot.docs[0].data()['taskName'],
        taskStatus: snapshot.docs[0].data()['taskStatus'],
        taskEmployee: snapshot.docs[0].data()['taskEmployee'],
        projectId:  snapshot.docs[0].data()['projectId']

    );
  }

  Stream<Task> get taskData {
    return  taskCollection.where('taskId', isEqualTo: tid).snapshots()
        .map((_taskDataFromSnapshot));
  }


}