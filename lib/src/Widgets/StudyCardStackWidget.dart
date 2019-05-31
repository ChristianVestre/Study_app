import 'package:flutter/material.dart';
import '../Models/StudyCardModel.dart';
import '../Blocs/StudyCardStackBloc.dart';
import '../Blocs/BlocProvider.dart';
import './StudyCardWidget.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class StackOfStudyCardWidget extends StatefulWidget {
  StackOfStudyCardWidget({
    Key key,
    @required this.stackOfStudyCards,
  }) : super(key: key);

  final List<StudyCard> stackOfStudyCards;

  @override
  _StackOfStudyCardWidgetState createState() => _StackOfStudyCardWidgetState();
}

class _StackOfStudyCardWidgetState extends State<StackOfStudyCardWidget> {
  StudyCardStackBloc _cardStackBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // As the context should not be used in the "initState()" method,
    // prefer using the "didChangeDependencies()" when you need
    // to refer to the context at initialization time
    _initBloc();
  }

  @override
  void didUpdateWidget(StackOfStudyCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // as Flutter might decide to reorganize the Widgets tree
    // it is preferable to recreate the links
    _disposeBloc();
    _initBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  // This routine is reponsible for creating the links
  void _initBloc() {
    // Retrieve the BLoC that handles the Card stack content
    _cardStackBloc = BlocProvider.of<StudyCardStackBloc>(context);
  }

  void _disposeBloc() {
    _cardStackBloc?.dispose();
  }

  Widget _buildCard() {
    return Align(
      alignment: Alignment(0, -1),
      child: Container(
        // height: MediaQuery.of(context).size.height / 1.3,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Container(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Stack(
              children: widget.stackOfStudyCards.map((studyCard) {
            print(studyCard.question);
            int index = widget.stackOfStudyCards.indexOf(studyCard);
            return GestureDetector(
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    height: 200,
                    child: Center(child: Text(studyCard.question))),
                onVerticalDragEnd: (DragDownDetails) =>
                    _cardStackBloc.removeStudyCardFromStack(studyCard));
          }).toList()),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }
}
