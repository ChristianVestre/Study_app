import 'package:flutter/material.dart';
import './src/Pages/CardPage.dart';
import 'package:sqflite/sqflite.dart';
import './src/Database/Database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CardPage(),
    );
  }
}
