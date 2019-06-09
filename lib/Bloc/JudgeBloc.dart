import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Bean/Judgement.dart';
import 'package:flutter_app/DAO/DaoApi.dart';
import 'package:flutter_app/Log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JudgeBloc with ChangeNotifier {
  DaoApi daoApi = new DaoApi();
  StreamController<List<JudgementBean>> _streamController =
      new StreamController();
  Stream<List<JudgementBean>> _stream;
  List<JudgementBean> _cards;
  JudgeBloc() {
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
  }
  Stream<List<JudgementBean>> get stream => _stream;
  List<JudgementBean> get card => _cards;

  loadCards() async {
     await loadCatalogId();
    _cards = await daoApi.queryCardsInJudgeByCatalogId(catalogId);
    await _streamController.sink.add(_cards);
  }
  loadCatalogId()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    catalogId= sharedPreferences.getInt("currentCatalogId");
    Logv.Logprint("in loadCatalogId"+catalogId.toString());
    notifyListeners();
    
  }
  loadTop5()async{
    _cards=await daoApi.topJudge();
    await _streamController.sink.add(_cards);
  }
  loadCardsBycatalog() async {
    await loadCatalogId();
    _cards = await daoApi.queryCardsInJudgeByCatalogId(catalogId);
    await _streamController.sink.add(_cards);
  }
  collect()async{
     int id = _cards[index].id;
     _cards[index].star=1;
     notifyListeners();
   await daoApi.collecjudge(id, 1);
  }
  uncollect()async{
    int id = _cards[index].id;
     _cards[index].star=0;
     notifyListeners();
   await daoApi.collecjudge(id, 0);
  }
  /////////////////////state
  int catalogId ;
  int index = 0;
 
  bool judgeChoose;
  bool isHideIcon = true;
  bool ishideAnswer = true;
  bool isHideCheckButton = false;
  bool isButtomTrueDisabled= false;
  bool isButtomFalseDisabled=false;
  Color colorTrue = Colors.black;
  Color colorFalse = Colors.black;
  void disableButtonTrue(){
    isButtomTrueDisabled=true;
    notifyListeners();
  }
  void disableButtom(){
    isButtomTrueDisabled= true;
    }
  bool isToEnd(){
    if(index==_cards.length-1){
      return true;
      
    }else{
      return false;
    }
  }
  void rightAnswer()async{
    _cards[index].number = _cards[index].number+1;
    int id=_cards[index].id;
    await  daoApi.judgeright(_cards[index].number, id);
    
  }
  void faultAnswer()async{
    _cards[index].number= _cards[index].number+1;
    _cards[index].faultnumber=  _cards[index].faultnumber+1;
    int id=_cards[index].id;
    await  daoApi.judgefalse(_cards[index].number, id,_cards[index].faultnumber);
  }
  void refreshWiget(){
    hideAnswer();
    hideIcon();
    refreshChoose();
    showCheckButton();
    refreshButtonDisable();
  }
  void refreshAll(){
    hideAnswer();
    hideIcon();
    refreshChoose();
    showCheckButton();
    refreshIndex();
    refreshButtonDisable();
  }
  void hideAnswer() {
    ishideAnswer = true;
    notifyListeners();
  }
  void refreshButtonDisable(){
    isButtomTrueDisabled= false;
    notifyListeners();
  }

  void showCheckButton() {
    isHideCheckButton = false;
    notifyListeners();
  }

  void hideCheckButton() {
    isHideCheckButton = true;
    notifyListeners();
  }

  void hideIcon() {
    isHideIcon = true;
    notifyListeners();
  }

  void showAnswer() {
    ishideAnswer = false;
    notifyListeners();
  }

  void showIcon() {
    isHideIcon = false;
    notifyListeners();
  }

  void refreshChoose() {
    judgeChoose = null;
    colorTrue = Colors.black;
    colorFalse = Colors.black;
    notifyListeners();
  }

  bool checkAnswer() {
    bool answer; //答案String 转为 bool
    if (_cards[index].answer == 'true') {
      answer = true;
    }
    if (_cards[index].answer == 'false') {
      answer = false;
    }
    //Logv.Logprint("该题正确答案为${answer}");
    //Logv.Logprint("你选择的答案是${judgeChoose}");
    if (answer == null) {
      Logv.Logprint("in JudgeBloc.checkAnswer() error!");
    }
    if (judgeChoose == answer) {
      return true;
    } else {
      return false;
    }
  }

  void tapTrue() {
    colorTrue = Colors.green;
    colorFalse = Colors.black;
    judgeChoose = true;
    notifyListeners();
  }

  void tapFalse() {
    colorTrue = Colors.black;
    colorFalse = Colors.green;
    judgeChoose = false;
    notifyListeners();
  }

  loadCatalog(int id) {
    catalogId = id;
    notifyListeners();
  }

  addIndex() {
    index++;
    notifyListeners();
  }

  refreshIndex() {
    index = 0;
    notifyListeners();
  }

  dispose() {
    _streamController.close();
  }
}
