import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/DAO/DaoApi.dart';
import 'package:flutter_app/Log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoiceBloc with ChangeNotifier{
  DaoApi daoApi =new DaoApi();
 
   StreamController<List<ChoiceCardBean>> _streamController=new StreamController();
   Stream<List<ChoiceCardBean>> _stream;
   List<ChoiceCardBean> _cards;
   ChoiceBloc(){
     _streamController=StreamController.broadcast();
     _stream = _streamController.stream;
     loadCatalogId();
     loadChoiceCard();
   }
  
  int index=0;
  int  grop_value= 0;
  bool ishideAnswer=true;
  bool isHideIcon=true;
  bool isHideCheckButton =false;
  bool isButtomTrueDisabled=false;
  bool isTrue =false;
  int catalogId;
  Stream<List<ChoiceCardBean>> get stream =>_stream;
  List<ChoiceCardBean>  get card=>_cards;

  loadCatalogId()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     catalogId= sharedPreferences.getInt("currentCatalogId");
    notifyListeners();
  }
   loadTop5()async{
    _cards=await daoApi.topchoice();
    await _streamController.sink.add(_cards);
  }
  loadChoiceCard()async{
    await loadCatalogId();
    _cards=await daoApi.queryBycatalogIdInChoiceCard(catalogId);
    await _streamController.sink.add(_cards);
    refreshIndex();
  }
  loadWrongBook()async{
    _cards= await daoApi.queryStarChoice();
    await _streamController.sink.add(_cards);
  }
  void showIcon(){
     isHideIcon=false;
     notifyListeners();
  }
  void trueAnswer(){
    isTrue= true;
    notifyListeners();
  }
   void hideIcon(){
    isHideIcon=true;
    notifyListeners();
  }
   void fault(){
    isTrue=false;
    notifyListeners();
  }
  addIndex(){
    index++;
    notifyListeners();
  }
  collect()async{
     int id = _cards[index].id;
     _cards[index].star=1;
     notifyListeners();
   await daoApi.collectChoice(id, 1);
  }
  uncollect()async{
    int id = _cards[index].id;
    _cards[index].star=0;
   await daoApi.collectChoice(id, 0);
   
   notifyListeners();
  }
  void updateGroupValue(int value){
    grop_value=value;
  notifyListeners();
  }
  void showAnswer(){
    ishideAnswer=false;
    notifyListeners();
  }
  void refreshselected(){
      grop_value=0;
      notifyListeners();
  }
 void refreshWiget(){
    hideAnswer();
    hideIcon();
    refreshselected();
    showCheckButton();
  }
   bool isToEnd(){
    if(index==_cards.length-1){
      return true;
    }
    else{
      return false;
    }
  }  
   void showCheckButton() {
    isHideCheckButton = false;
    notifyListeners();
  }
   void hideAnswer(){
    ishideAnswer=true;
    notifyListeners();
  }
  void refreshAll(){
    hideAnswer();
    hideIcon();
   refreshselected();
    showCheckButton();
    refreshIndex();
  }
  refreshIndex(){
    index=0;
    notifyListeners();
  }
  void faultAnswer()async{
    _cards[index].number= _cards[index].number+1;
    _cards[index].faultnumber=  _cards[index].faultnumber+1;
    int id=_cards[index].id;
    await  daoApi.choicefalse(_cards[index].number, id,_cards[index].faultnumber);
  }
  void rightAnswer()async{
    _cards[index].number = _cards[index].number+1;
    int id=_cards[index].id;
    await  daoApi.choiceright(_cards[index].number, id);
    
  }
  bool checkAnswer(){
   return isTrue;
  }
  void disableButtonTrue(){
    isButtomTrueDisabled=true;
    notifyListeners();
  }
   void hideCheckButton() {
    isHideCheckButton = true;
    notifyListeners();
  }
  //  void showAnswer(){
  //   ishideAnswer=false;
  //   notifyListeners();
  // }
  dispose(){
      _streamController.close();
   }
}