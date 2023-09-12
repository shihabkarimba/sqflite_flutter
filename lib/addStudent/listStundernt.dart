import 'package:flutter/material.dart';
import 'package:hive_practice/addStudent/dataModel.dart';
import 'package:hive_practice/addStudent/dbFunctons.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: StudentListNotifier,
      builder: (context, NewValueStudentList, child) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (ctx, index) {
            final data = NewValueStudentList[index];

            return ListTile(
                title: Text(data.name),
                subtitle: Text(data.age),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          deleteDialog(data, ctx);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          editDialog(context, data);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 70, 0, 245),
                        ),
                      ),
                    ],
                  ),
                ));
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: NewValueStudentList.length,
        );
      },
    );
  }

  Future<void> deleteDialog(StudentModel data, BuildContext ctx) async {
    return showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Are you sure you want to delete the person'),
          actions: [
            TextButton(
              onPressed: () {
                deleteStudent(data);

                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  editDialog(BuildContext context, StudentModel data,) async {
    final _editAgeController = TextEditingController();
    final _editNameController = TextEditingController();
    // final updateStudent = StudentModel(
    //                   name: _editNameController.text,
    //                   age: _editAgeController.text);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _editNameController,
                      decoration: InputDecoration(
                          hintText: data.name.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _editAgeController,
                      decoration: InputDecoration(
                          hintText: data.age.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
              final updatedStudent = StudentModel(
                name: _editNameController.text,
                age: _editAgeController.text,
              );
              if(data != null){
                updateStudent(updatedStudent.name, updatedStudent.age, data.id!);
              }
              Navigator.pop(context);
            },
                child: const Text("Save"),
              )
            ],
          );
        });
  }    
}
