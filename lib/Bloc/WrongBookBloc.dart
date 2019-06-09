import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/CatalogBean.dart';
import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/Bean/Judgement.dart';
import 'package:flutter_app/Bean/MutiChoiceBean.dart';
import 'package:flutter_app/DAO/DaoApi.dart';
import 'package:flutter_app/Log.dart';

class WrongBookBloc with ChangeNotifier {
  DaoApi daoApi = new DaoApi();
  StreamController<CatalogBean> _catalogStreamController =
      new StreamController();
  StreamController<List<ChoiceCardBean>> _choiceStreamController =
      new StreamController();
  StreamController<List<MutiChoiceBean>> _mutiStreamController =
      new StreamController();
  StreamController<List<JudgementBean>> _judgeStreamController =
      new StreamController();
  Stream<CatalogBean> catalogStream;
  Stream<List<ChoiceCardBean>> choiceStream;
  Stream<List<MutiChoiceBean>> mutiStream;
  Stream<List<JudgementBean>> judgeStream;
  WrongBookBloc() {
    _catalogStreamController=StreamController.broadcast();
    _choiceStreamController = StreamController.broadcast();
    _mutiStreamController = StreamController.broadcast();
    _judgeStreamController = StreamController.broadcast();

    catalogStream =_catalogStreamController.stream;
    choiceStream = _choiceStreamController.stream;
    mutiStream = _mutiStreamController.stream;
    judgeStream = _judgeStreamController.stream;
    loadTest();
  }
  List<ChoiceCardBean> choices;
  List<MutiChoiceBean> mutis;
  List<JudgementBean> judges;
  CatalogBean catalogBean;
  loadTest() async {
    choices = await daoApi.queryStarChoice();
    mutis = await daoApi.queryStarMuti();
    judges = await daoApi.queryStarJudge();
    await _choiceStreamController.sink.add(choices);
    await _mutiStreamController.sink.add(mutis);
    await _judgeStreamController.sink.add(judges);
  }

  loadChoice() async {
    choices = await daoApi.queryStarChoice();
    await _choiceStreamController.sink.add(choices);
  }

  loadmuti() async {
    mutis = await daoApi.queryStarMuti();
    await _mutiStreamController.sink.add(mutis);
  }

  loadJudge() async {
    judges = await daoApi.queryStarJudge();
    Logv.Logprint("in loadJudge :"+judges.toString());
    notifyListeners();
    await _judgeStreamController.sink.add(judges);
  }
  loadCatalog()async{
    catalogBean = await daoApi.wrongbookInformation();
    Logv.Logprint('test ji'+catalogBean.toMap().toString());
    await _catalogStreamController.sink.add(catalogBean);
    notifyListeners();
  }



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
    if(index==judges.length-1){
      return true;
      
    }else{
      return false;
    }
  }
  void rightAnswer()async{
    judges[index].number = judges[index].number+1;
    int id=judges[index].id;
    await  daoApi.judgeright(judges[index].number, id);
    
  }
  void faultAnswer()async{
    judges[index].number= judges[index].number+1;
    judges[index].faultnumber=  judges[index].faultnumber+1;
    int id=judges[index].id;
    await  daoApi.judgefalse(judges[index].number, id,judges[index].faultnumber);
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
    if (judges[index].answer == 'true') {
      answer = true;
    }
    if (judges[index].answer == 'false') {
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


  addIndex() {
    index++;
    notifyListeners();
  }

  refreshIndex() {
    index = 0;
    notifyListeners();
  }

}

