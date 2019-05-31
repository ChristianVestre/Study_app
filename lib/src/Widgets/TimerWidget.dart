import 'package:flutter/material.dart';
import '../Blocs/BlocProvider.dart';
import '../Blocs/StudyCardStackBloc.dart';
import '../Services/StopwatchService.dart';

class TimerWidget extends StatelessWidget {
  StudyCardStackBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<StudyCardStackBloc>(context);
    return Container(
        padding: EdgeInsets.only(top:40),
        child: Column(children: [
      StreamBuilder(
        stream: _bloc.timerController,
        builder: (BuildContext context, AsyncSnapshot<TimerService> snapshot) {
          if (snapshot.data != null) {
            return AnimatedBuilder(
                animation: snapshot.data,
                child: Container(height: 100, margin: EdgeInsets.all(10),),
                builder: (BuildContext context, Widget child) {
                  return Text('Time spent on card: \n${snapshot.data.currentDuration}',textAlign: TextAlign.center,style: TextStyle(fontSize: 18),);
                });
          } else {
            return Container();
          }
        },
      ),
      StreamBuilder(
        stream: _bloc.averageTime ,
        builder: (BuildContext context, AsyncSnapshot<Duration> snapshot){
          if (snapshot.data !=null){
          return Container(
            padding: EdgeInsets.all(20),
            child: Text('Average time spent per card: \n${snapshot.data}', textAlign: TextAlign.center,));
          
          } else {
            return Container(

            );
          }
        },
      ),
    ]));
  }
}
