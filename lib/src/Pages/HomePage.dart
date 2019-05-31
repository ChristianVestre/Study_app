import 'package:flutter/material.dart';
import '../Database/Database.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(child: Text('Stacks of cards'), decoration: BoxDecoration(color: Color.fromRGBO(255, 248, 248, 1)),),
          Container(height: MediaQuery.of(context).size.height / 2
          ),
        ],
      ),
    );
  }
}