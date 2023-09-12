import 'package:flutter/material.dart';
import 'package:hive_practice/addStudent/addStundent.dart';
import 'package:hive_practice/addStudent/dbFunctons.dart';
import 'package:hive_practice/addStudent/listStundernt.dart';

class DbPage extends StatelessWidget {
  DbPage({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AddStundent(),
          Expanded(child: ListStudentWidget())
        ],
      ),
    );
  }
  
}
