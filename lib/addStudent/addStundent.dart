import 'package:flutter/material.dart';
import 'package:hive_practice/addStudent/dataModel.dart';
import 'package:hive_practice/addStudent/dbFunctons.dart';


class AddStundent extends StatelessWidget {
  AddStundent({super.key});
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 30, top: 20),
        child: Column(
          children: [
            Text(
              'Add studetn details',
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                onAddStudentButtonClicked();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  onAddStudentButtonClicked() async {
    final _name = _nameController.text;
    final _age = _ageController.text;
    if (_name.isEmpty || _age.isEmpty) {
      return null;
    } else {
      print("$_name $_age");

      final StudentModel _student = StudentModel(name: _name, age: _age);

      addStudent(_student);
    }
  }
}
