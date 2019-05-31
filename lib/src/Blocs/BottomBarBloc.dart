import 'package:rxdart/rxdart.dart';
import './BlocProvider.dart';
import '../Models/StackOfCardsModel.dart';
import '../Models/StudyCardModel.dart';
import 'dart:convert';

class BottomBarBloc implements BlocBase {


  // Stream to list of all possible items
  BehaviorSubject<int> _timerController = BehaviorSubject<int>();
  Stream<int> get timer => _timerController;

  

  @override
  void dispose() {
    _timerController?.close();
  }

  // Constructor
  CardsBloc() {
 //   _loadShoppingItems();
  _firstPage();
   //print();
  }

  void _firstPage() {
    _timerController.sink.add(1);
  }

}