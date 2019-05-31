import 'package:flutter/material.dart';

class QuotesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 50, 15, 50),
      child:Column(
      children:<Widget>[ 
        Text('Simplicity is the ultimate sophistication', style: TextStyle(fontSize: 18),),
        Align(alignment:Alignment(0.6,0),child:Text('Leonardo Da Vinci',textAlign: TextAlign.end,style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),))
      ]
    )
    );
  }
}