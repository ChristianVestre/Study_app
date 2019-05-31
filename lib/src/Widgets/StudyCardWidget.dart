import 'package:flutter/material.dart';
import '../Models/StudyCardModel.dart';
import '../Blocs/BlocProvider.dart';
import '../Blocs/StudyCardStackBloc.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

enum CardSide { frontSide, backSide }

class AnimatedStudyCard extends StatefulWidget {
  AnimatedStudyCard({Key key, this.studyCard}) : super(key: key);
  StudyCard studyCard;
  AnimatedStudyCardState createState() => AnimatedStudyCardState();
}

List<Color> pastelColors = [
  Color.fromRGBO(255, 178, 214, 1),
  Color.fromRGBO(252, 246, 189, 1),
  Color.fromRGBO(208, 244, 222, 1),
  Color.fromRGBO(169, 222, 249, 1),
  Color.fromRGBO(228, 193, 249, 1),
  Color.fromRGBO(240, 255, 240, 1),
  Color.fromRGBO(244, 160, 226, 1),
  Color.fromRGBO(190, 255, 239, 1)
];

class StudyCardWidget extends StatelessWidget {
  StudyCardWidget(
      {Key key,
      this.studyCard,
      this.cardSide,
      this.animationController,
      this.color})
      : super(key: key);
  AnimationController animationController;
  CardSide cardSide;
  Color color;
  StudyCard studyCard;
  StudyCardStackBloc _bloc;

  @override
  Widget build(BuildContext context) {
    //  print(studyCard.question);
    String _shownString;
    bool _isBackSide = true;
    switch (cardSide) {
      case CardSide.frontSide:
        _shownString = studyCard.question;
        _isBackSide = false;
        break;
      case CardSide.backSide:
        _shownString = studyCard.answer;
    }
    _bloc = BlocProvider.of<StudyCardStackBloc>(context);
    return GestureDetector(
      child: _isBackSide
          ? Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]),
                  borderRadius: BorderRadius.circular(8),
                  color: pastelColors[studyCard.colorIndex]),
              height: 250,
              child: Stack(children: [
                Center(child: Text(_shownString)),
                /*    Align(alignment: Alignment(-1, 0),
              child: RotatedBox(quarterTurns: 1,child: Text('Swipe left if you know the answer', style: TextStyle(fontSize: 8),)),),
              Align(alignment: Alignment(1, 0),
              child: RotatedBox(quarterTurns: 3,child: Text('Swipe right if have no idea about the answer know', style: TextStyle(fontSize: 8),)),),
              Align(alignment: Alignment(0, 1),
              child: Text('Swipe down if you kinda know the answer', style: TextStyle(fontSize: 8),)) */
              ]))
          : Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]),
                  borderRadius: BorderRadius.circular(8),
                  color: pastelColors[studyCard.colorIndex]),
              height: 250,
              child: Center(child: Text(_shownString))),
      onVerticalDragEnd: _isBackSide
          ? (DragEndDetails details) {
              if (details.primaryVelocity.compareTo(0) == -1) {
                if (animationController.isCompleted ||
                    animationController.velocity > 0) {
                  animationController.reverse();
                } else {
                  animationController.reverse();
                }
              } else {
                if (animationController.isCompleted ||
                    animationController.velocity > 0) {
                  _bloc.mediumCardReshuffle(studyCard);
                  animationController.reverse();
                } else {
                  animationController.reverse();
                  //animationController.forward();
                }
              }
            }
          : (DragEndDetails details) {
              if (details.primaryVelocity != 0) {
                if (animationController.isCompleted ||
                    animationController.velocity > 0) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              }
            },
    );
  }
}

class AnimatedStudyCardState extends State<AnimatedStudyCard>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  StudyCardStackBloc _bloc;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _frontScale = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    //  ThemeData theme = Theme.of(context);'
    _bloc = BlocProvider.of<StudyCardStackBloc>(context);
    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          child: GestureDetector(
              child: StudyCardWidget(
                studyCard: widget.studyCard,
                cardSide: CardSide.backSide,
                animationController: _controller,
                color: Colors.grey,
              ),
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity.compareTo(0) == -1) {
                  _bloc.easyCardReshuffle(widget.studyCard);
                  _controller.reverse();
                } else {
                  _bloc.hardCardReshuffle(widget.studyCard);
                  _controller.reverse();
                }
              },
              onVerticalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity.compareTo(0) == -1) {
                  _bloc.mediumCardReshuffle(widget.studyCard);
                  _controller.reverse();
                }
              }),
          animation: _backScale,
          builder: (BuildContext context, Widget child) {
            final Matrix4 transform = Matrix4.identity()
              ..scale(1.0, _backScale.value, 1.0);
            return Transform(
              transform: transform,
              alignment: FractionalOffset.center,
              child: child,
            );
          },
        ),
        AnimatedBuilder(
          child: StudyCardWidget(
            studyCard: widget.studyCard,
            cardSide: CardSide.frontSide,
            animationController: _controller,
            color: Colors.grey,
          ),
          animation: _frontScale,
          builder: (BuildContext context, Widget child) {
            final Matrix4 transform = Matrix4.identity()
              ..scale(1.0, _frontScale.value, 1.0);
            return Transform(
              transform: transform,
              alignment: FractionalOffset.center,
              child: child,
            );
          },
        ),
      ],
    );
  }
}
