import './StudyCardModel.dart';
import 'dart:collection';

class StackOfCards {
  final String cardStackName;
  List<StudyCard> cards = [];

  StackOfCards(
    this.cardStackName,
    this.cards,
  );

  StackOfCards.fromJSON(Map<String, dynamic> json)
    : cards = List<StudyCard>.from((json['cardInfo']).map((item) => StudyCard.fromJSON(item))),
    cardStackName = json["cardStackName"];
    
}