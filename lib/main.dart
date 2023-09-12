import 'package:flutter/material.dart';
import 'package:hive_practice/addStudent/dbFunctons.dart';
import 'package:hive_practice/addStudent/home.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDataBase();
  runApp(
   const MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      
      home:DbPage()
    );
  }
}