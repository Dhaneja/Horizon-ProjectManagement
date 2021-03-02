import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  @override
  Widget build(BuildContext context) {

    final horizonUsers = Provider.of<QuerySnapshot>(context);
    //print(horizonUsers);

    for (var doc in horizonUsers.docs){
      print(doc.data);
    }

    return Container();
  }
}
