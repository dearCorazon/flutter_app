import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/DAO/DaoApi.dart';

class ChoiceBloc with ChangeNotifier{
  DaoApi daoApi =new DaoApi();
   StreamController<List<ChoiceCardBean>> _streamController=new StreamController();
   Stream<List<ChoiceCardBean>> _stream;
   List<ChoiceCardBean> _cards;
   ChoiceBloc(){
     _streamController=StreamController.broadcast();
     _stream = _streamController.stream;
     loadChoiceCard();
   }
  
  int index=0;
  
  Stream<List<ChoiceCardBean>> get stream =>_stream;
  List<ChoiceCardBean>  get card=>_cards;

  loadChoiceCard()async{
    _cards=await daoApi.queryAllInChoiceCard();
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
}