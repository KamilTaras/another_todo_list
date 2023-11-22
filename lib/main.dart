import 'package:flutter/material.dart';

import 'Pages/homePage.dart';

void main() => runApp(MyApp());

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
