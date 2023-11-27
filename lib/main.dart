import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/homePage.dart';
import 'taskModel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TasksModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Input Widget',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: HomePage());
  }
}
