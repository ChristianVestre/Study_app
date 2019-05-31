
import 'dart:math';

class StudyCard {
  final String question;
  final String answer;
  bool used;
  int colorIndex;



  StudyCard(
    this.question,
    this.answer,
    this.used,
    this.colorIndex

    );

  StudyCard.fromJSON(Map<String, String> json)
    : question = json['Question'],
      answer = json['Answer'],
      used = false,
      colorIndex = Random().nextInt(7);
}