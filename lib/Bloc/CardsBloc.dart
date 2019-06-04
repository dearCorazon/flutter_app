import 'dart:async';

import 'package:flutter_app/Bean/CardComplete.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/Log.dart';

class CardsBloc{
  ScheduleDao scheduleDao = new ScheduleDao();

  StreamController<List<CardComplete>> _streamController=new StreamController();  
  StreamController<List<CardComplete>> _streamController_current=new StreamController();  
  
  Stream<List<CardComplete>> _stream;
  Stream<List<CardComplete>> _stream_current;

  List<CardComplete> _cardCompletes;
  List<CardComplete> _cardCompletes_current;


  CardsBloc(){
    Logv.Logprint("in CardsBloc constructor:");
    loadCardCompleteList();
    
     _streamController=StreamController.broadcast();
     _streamController_current=StreamController.broadcast();

     _stream = _streamController.stream;
    _stream_current=_streamController_current.stream;

  } 
  List<CardComplete> get currentList=> _cardCompletes_current;
  List<CardComplete> get cardCompletes=>_cardCompletes;
  Stream<List<CardComplete>> get stream =>_stream;
  Stream<List<CardComplete>> get currentstream =>_stream_current;

  loadCardCompleteList()async{
    //List<CatalogExtra> catalogExtras= await scheduleDao.loadCatalogExtraList();
    //TODO:这个查询按 status排序？
    List<CardComplete> cards= await scheduleDao.fetchCardCompletesAll();
    _cardCompletes=cards;
    await Logv.Logprint("in  loadCardCompleteList() 更新的卡片总数为："+cards.length.toString());
    _streamController.sink.add(cards);
  }

  loadCardByCatalogId(int catalogId)async{
    Logv.Logprint("in CardsBloc constructor:");
    List<CardComplete> cards = await scheduleDao.fetchCardComletesByCatalogId(catalogId); 
    _streamController.sink.add(cards);
  }

  loadCardByCatalogName(String catalogName)async{
    await Logv.Logprint("in CardsBloc.loadCardByCatalogName:");
    List<CardComplete> cards = await scheduleDao.fetchCardComletesByCatalogName(catalogName); 
    _streamController.sink.add(cards);
  }
  
  loadCardsWithSchedule(int catalogId,int length)async{
    await Logv.Logprint("in CardsBloc.loadCardByCatalogName:");
    List<CardComplete> cards= await scheduleDao.loadCardListwithSchedule(catalogId, length);
    _cardCompletes_current=cards;
    _streamController_current.sink.add(cards);
  }


  dispose(){
    _streamController_current.close();
    _streamController.close();
  }

}
 