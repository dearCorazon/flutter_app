import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_app/Bean/MutiChoiceBean.dart';
import 'package:flutter_app/DAO/DaoApi.dart';
import 'package:flutter_app/Log.dart';

class MutiBloc with ChangeNotifier{
  //TODO:bloc with ChangeNotify 要不要把init分开
  DaoApi daoApi =new DaoApi();
   StreamController<List<MutiChoiceBean>> _streamController=new StreamController();
   Stream<List<MutiChoiceBean>> _stream;
   List<MutiChoiceBean> _cards;
   MutiBloc(){
     _streamController=StreamController.broadcast();
     _stream = _streamController.stream;
     loadChoiceCard();
   }
  Stream<List<MutiChoiceBean>> get stream =>_stream;
  List<MutiChoiceBean>  get card=>_cards;

  loadChoiceCard()async{
    _cards=await daoApi.queryAllInMutiChoiceCard();
    await _streamController.sink.add(_cards);
    refreshIndex();
  }
  addIndex(){
    index++;
    notifyListeners();
  }
  refreshIndex(){
    index=0;
    notifyListeners();
  }
  
  dispose(){
      _streamController.close();
  }
  
  void rightAnswer()async{
    _cards[index].number = _cards[index].number+1;
    int id=_cards[index].id;
    await  daoApi.mutiright(_cards[index].number, id);
    
  }
  void faultAnswer()async{
    _cards[index].number= _cards[index].number+1;
    _cards[index].faultnumber=  _cards[index].faultnumber+1;
    int id=_cards[index].id;
    await  daoApi.mutifalse(_cards[index].number, id,_cards[index].faultnumber);
  }
  // void right()async{
  //   int catalogId = _cards[index].catalogId;
  //   int id = _cards[index].id;
  //   int number= _cards[index].number++;
  //   await daoApi.mutiright(number, id);
    
  // }
   //State:
  int index=0;
  bool isSelectedA=false;
  bool isSelectedB=false;
  bool isSelectedC=false;
  bool isSelectedD=false;
  bool ishideAnswer= true;
  bool isHideIcon= true;
  bool isButtomTrueDisabled= false;

 bool isHideCheckButton =false;

 
  bool isToEnd(){
    if(index==_cards.length-1){
      return true;
    }
    else{
      return false;
    }
  }
  void refreshWiget(){
    hideAnswer();
    hideIcon();
    refreshselected();
    showCheckButton();
  }
   void refreshAll(){
    hideAnswer();
    hideIcon();
    refreshselected();
    showCheckButton();
    refreshIndex();
  }
  void showCheckButton() {
    isHideCheckButton = false;
    notifyListeners();
  }
  void hideCheckButton() {
    isHideCheckButton = true;
    notifyListeners();
  }
  void hideAnswer(){
    ishideAnswer=true;
    notifyListeners();
  }
  void hideIcon(){
    isHideIcon=true;
    notifyListeners();
  }
  void showAnswer(){
    ishideAnswer=false;
    notifyListeners();
  }
  void showIcon(){
     isHideIcon=false;
     notifyListeners();
  }
 void disableButtonTrue(){
    isButtomTrueDisabled=true;
    notifyListeners();
  }
  
  void updateA(){
    isSelectedA=!isSelectedA;
    notifyListeners();
  }
  void updateB(){
    isSelectedB=!isSelectedB;
    notifyListeners();
  }
  void updateC(){
    isSelectedC=!isSelectedC;
    notifyListeners();
  }
  void updateD(){
    isSelectedD=!isSelectedD;
    notifyListeners();
  }
  bool checkAnswer(){
    String answer= getanswer();
    Logv.Logprint("in checkAnswer answer:$answer");
    if(answer== _cards[index].answer){
      return true;
    } 
    else{
      return false;
    }
  }
  void refreshselected(){
    isSelectedA=false;
    isSelectedB=false;
    isSelectedC=false;
    isSelectedD=false;
    notifyListeners();
  }
  String getanswer(){
    if(isSelectedA && !isSelectedB && !isSelectedC && !isSelectedD){
      return 'A';
    }
    if(!isSelectedA && isSelectedB && !isSelectedC && !isSelectedD){
      return 'B';
    }
    if(!isSelectedA && !isSelectedB && isSelectedC && !isSelectedD){
      return 'C';
    }
    if(!isSelectedA && !isSelectedB && !isSelectedC && isSelectedD){
      return 'D';
    }
    if(isSelectedA && isSelectedB && !isSelectedC && !isSelectedD){
      return 'AB';
    }
    if(isSelectedA && !isSelectedB && isSelectedC && !isSelectedD){
      return 'AC';
    }
    if(isSelectedA && !isSelectedB && !isSelectedC && isSelectedD){
      return 'AD';
    }
    if(isSelectedA && isSelectedB && isSelectedC && !isSelectedD){
      return 'ABC';
    }
    if(isSelectedA && isSelectedB && !isSelectedC && isSelectedD){
      return 'ABD';
    }
    if(!isSelectedA && isSelectedB && isSelectedC && !isSelectedD){
      return 'BC';
    }
    if(!isSelectedA && isSelectedB && !isSelectedC && isSelectedD){
      return 'BD';
    }
    if(!isSelectedA && isSelectedB && isSelectedC && isSelectedD){
      return 'BCD';
    }
    if(!isSelectedA && !isSelectedB && isSelectedC && isSelectedD){
      return 'CD';
    }
    if(isSelectedA && isSelectedB && isSelectedC && isSelectedD){
      return 'ABCD';
    }
  }
}