import 'package:flutter/material.dart';
import 'package:hive_practice/addStudent/dataModel.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> StudentListNotifier = ValueNotifier([]);

late Database _db;

Future<void> initializeDataBase() async {
  _db = await openDatabase('Student_db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE student(id INTEGER PRIMARY KEY,name TEXT,age TEXT)');
  });
}

addStudent(StudentModel value) async {
  //StudentListNotifier.value.add(value);
  // final studentDB = await Hive.openBox<StudentModel>("student_db");
  // await studentDB.add(value);
  // value.id = _id;
  await _db.rawInsert(
      'INSERT INTO student(name,age)VALUES(?,?)', [value.name, value.age]);
  getAllStudents();
  //StudentListNotifier.value.add(value);
  //StudentListNotifier.notifyListeners();
}

getAllStudents() async {
  //final studentDB = await Hive.openBox<StudentModel>("student_db");

  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);
  StudentListNotifier.value.clear();
  _values.forEach((map) {
    final student = StudentModel.fromMap(map);
    StudentListNotifier.value.add(student);
  });
  StudentListNotifier.notifyListeners();
}

Future<void> deleteStudent(StudentModel data) async {
  // final studentDB = await Hive.openBox<StudentModel>("student_db");
  // await studentDB.deleteAt(id);
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [data.id]);
  getAllStudents();
}

Future<void> updateStudent(String newName, String newAge, int id) async {
  // final studentDB = await Hive.openBox<StudentModel>("student_db");
  // await studentDB.put(index, updateStudent);
  await _db.rawUpdate('UPDATE student SET name = ?, age = ? WHERE id =?',
      [newName, newAge, id]);
  getAllStudents();
}
