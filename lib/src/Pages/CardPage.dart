import 'package:flutter/material.dart';
import '../Blocs/BlocProvider.dart';
import '../Blocs/StudyCardStackBloc.dart';
import '../Models/StudyCardModel.dart';
import '../Widgets/StudyCardWidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../Widgets/TopChart.dart';
import '../Models/TopBarModel.dart';
import '../Widgets/BottomBarWidget.dart';


class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<String> _mockData = ['What is ACID?', 'What is ACA?', 'What is WAL?'];

  StudyCardStackBloc _bloc = StudyCardStackBloc();
  List<StudyCard> _stackOfStudyCard = [];
  @override
  Widget build(BuildContext context) {
    // print(_mockData);
    
    return BlocProvider(
        bloc: _bloc,
        child: StreamBuilder(
            stream: _bloc.studyCardsStack,
            builder: (BuildContext context,
              AsyncSnapshot<List<StudyCard>> snapshot) {
              if (snapshot.data != null) {
                int _index = 0;
                //_stackOfStudyCard = snapshot.data;
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: <Widget>[
                      Container(
                       // padding: EdgeInsets.all(10),
                       margin: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height / 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:PercentOfDomainBarChart(),),),
                      Align(
                        alignment: Alignment(0, -1),
                        child: Container(
                          // height: MediaQuery.of(context).size.height / 1.3,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.8,
                            child: Stack(
                                children: snapshot.data.map((studyCard) {
                              //      print(studyCard.question);
                              int index = snapshot.data.indexOf(studyCard);
                              if (studyCard.used == false) {
                                _index += 1;
                                return Align(
                                  alignment:
                                      Alignment(0, ((_index) * 1.05 - _index)),
                                  child: AnimatedStudyCard(studyCard:studyCard)
                                );
                              } else {
                                return Container();
                              }
                            }).toList()),
                          ),
                        ),
                      ),
                      Expanded(child:BottomBarWidget())
                    ],
                  ),
            //      floatingActionButton: FloatingActionButton(
             //         onPressed: () => {_bloc.resetCardStack(), _index = 0}),
                );
              } else {
                return Scaffold(body: Container());
              }
            }));
  }
}
