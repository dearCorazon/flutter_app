import 'package:flutter/foundation.dart';

class CardsAddState with ChangeNotifier{
  String question='';
  String answer='';
  List<String> chaos=[''];
  void loadQuestion(String question){
    this.question= question;
    notifyListeners();
  }
  void loadAnswer(String answer){
    this.answer= answer;
    notifyListeners();
  }
  void loadSimpleCard(String name,String answer,List<String> chaos){
    this.question=question;
    this.answer=answer;
    notifyListeners();
  }
}