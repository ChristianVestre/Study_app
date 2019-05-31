import 'package:rxdart/rxdart.dart';
import './BlocProvider.dart';
import '../Models/StackOfCardsModel.dart';
import '../Models/StudyCardModel.dart';
import '../Models/TopBarModel.dart';
import '../Models/CardTimerModel.dart';
import 'dart:convert';
import '../Services/StopwatchService.dart';

class StudyCardStackBloc implements BlocBase {

  StackOfCards _stackOfCards = StackOfCards.fromJSON({'cardStackName':'DataBaseCards','cardInfo':[{'Question':'What is ACID?', 'Answer':'Atomicity, Consistency, Isolation, and Durability'},{'Question':'What is ACA?','Answer':'Avoids cascading aborts'},{'Question':'What is not steal?', 'Answer':'steal is....'}, {'Question':'What is force', 'Answer':'Force is a concept in regards to databases that...'}]});

  TopBarChart _topBar = TopBarChart(init: 1,medium: 1,easy: 1,easyPercentage: 0,mediumPercentage: 0,hard:1,hardPercentage: 0,total: 0);

  TimerService _timerService = TimerService();

  Duration _latestAverageTime = Duration();


  BehaviorSubject<List<StudyCard>> _studyCardsController = BehaviorSubject<List<StudyCard>>();
  Stream<List<StudyCard>> get studyCardsStack => _studyCardsController;

  BehaviorSubject<TopBarChart> _topBarController = BehaviorSubject<TopBarChart>();
  Stream<TopBarChart> get topBarController => _topBarController;

  BehaviorSubject<TimerService> _timerController = BehaviorSubject<TimerService>();
  Stream<TimerService> get timerController => _timerController;

  BehaviorSubject<Duration> _averageTimeController = BehaviorSubject<Duration>();
  Stream<Duration> get averageTime => _averageTimeController;

  int millisec = 0;

  @override
  void dispose() {
    _studyCardsController?.close();
    _topBarController?.close();
  }

  void removeStudyCardFromStack(StudyCard studyCard) {
     // _stackOfCards.cards.where((card) => studyCard == card).single.used = true;
      _postActionOnStack();
  }

  void resetCardStack() {
    _stackOfCards.cards.forEach((studyCard) => {studyCard.used = false});
    _stackOfCards.cards.shuffle();
    _postActionOnStack();
  }

  void easyCardReshuffle(StudyCard studyCard) {
    int _index = _stackOfCards.cards.indexOf(studyCard);
    _stackOfCards.cards.removeAt(_index);
    _stackOfCards.cards.insert(0, studyCard);
    //_timerService.reset();
    _postTimerChange();
    _addEasy();
    _postActionOnStack();
  }

  void mediumCardReshuffle(StudyCard studyCard) {
    int _index = _stackOfCards.cards.indexOf(studyCard);
    _stackOfCards.cards.removeAt(_index);
    _stackOfCards.cards.insert(_stackOfCards.cards.length - 2, studyCard);
    //_timerService.reset();
    _postTimerChange();
    _addMedium();
    _postActionOnStack();
  }


  void hardCardReshuffle(StudyCard studyCard) {
    int _index = _stackOfCards.cards.indexOf(studyCard);
    _stackOfCards.cards.removeAt(_index);
    _stackOfCards.cards.insert(_stackOfCards.cards.length - 1, studyCard);
    //_timerService.reset();
    _postTimerChange();
    _addHard();
    _postActionOnStack();
  }


  void _loadCards() {
   // _stackOfCards.cards.shuffle();
    _studyCardsController.sink.add(_stackOfCards.cards);
  }

  void _postActionOnStack() {
    //_stackOfCards.cards.shuffle();
    //_stackOfCards.cards.forEach((c) => print(c.question));
    _studyCardsController.sink.add(_stackOfCards.cards);
  }

  




//----------------------------------------------------------------------------------------------------------------------------------------------------------------


  void _reCalculateTopBar(){
    if (_topBar.init == 1) {
    _topBar.total =_topBar.easy + _topBar.medium + _topBar.hard;
    _topBar.easyPercentage =_topBar.easy / _topBar.total;
    _topBar.mediumPercentage =_topBar.medium / _topBar.total;
    _topBar.hardPercentage =_topBar.hard / _topBar.total;
    _topBar.init = 0;
    _topBar.easy -= 0.9999;
    _topBar.medium -= 0.9999;
    _topBar.hard -= 0.9999;
    } else {
    _topBar.total =_topBar.easy + _topBar.medium + _topBar.hard;
    _topBar.easyPercentage =_topBar.easy / _topBar.total;
    _topBar.mediumPercentage =_topBar.medium / _topBar.total;
    _topBar.hardPercentage =_topBar.hard / _topBar.total;
    }
   // print(_topBar.easy);
    //print(_topBar.medium);
    //print(_topBar.hard);
  }

 void _initTopBar() {
    _reCalculateTopBar();
    _topBarController.sink.add(_topBar);
  }

  void _addEasy(){
    _topBar.easy += 1;
    _reCalculateTopBar();
  }

  void _addMedium(){
    _topBar.medium += 1;
    _reCalculateTopBar();
  }

  void _addHard(){
    _topBar.hard += 1;
    _reCalculateTopBar();
  }

  //-----------------------------------------------------------------------------------------

  void _initStopWatch() {
    _timerController.sink.add(_timerService);
  }

  void _postTimerChange(){
    print(_timerService.currentDuration.inMilliseconds);
    _updateAverage();
    _timerService.reset();
    _timerService.start();
    _timerController.sink.add(_timerService);
  }


//-------------------------------------------------------------------------------------------

  void _initAverageTimer(){
    _timerService.start();
    _averageTimeController.add(_latestAverageTime);
  }

  void _updateAverage(){
    //print(_latestAverageTime);
    //print(_timerService.currentDuration.inMicroseconds);
    _latestAverageTime = Duration(microseconds:(( _latestAverageTime.inMicroseconds + _timerService.currentDuration.inMicroseconds) ~/ 2.0));
    print(_latestAverageTime.inSeconds);
    _postAverage();
  }

  void _postAverage(){
    _averageTimeController.add(_latestAverageTime);
  }


    StudyCardStackBloc() {
    _loadCards();
    _initTopBar();
    _initStopWatch();
    _initAverageTimer();

    //  _timerController.sink.add(_stopwatch)
    
  }
}