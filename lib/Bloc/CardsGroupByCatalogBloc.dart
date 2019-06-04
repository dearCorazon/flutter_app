import 'dart:async';

import 'package:flutter_app/Bean/CardComplete.dart';
import 'package:flutter_app/Bean/CardsGroupbyCatalog.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/Log.dart';

class CardsGroupByCatalogBloc{
  ScheduleDao _scheduleDao= new ScheduleDao();
  StreamController<CardsGroupByCatalog> _streamController=new StreamController();
  Stream<CardsGroupByCatalog> _stream;
  CardsGroupByCatalog _cards;
  CardsGroupByCatalogBloc(){
    Logv.Logprint("in CardsGroupByCatalogBloc constructor:");
    _streamController=StreamController.broadcast();
    _stream = _streamController.stream;
  }
  CardsGroupByCatalog get  cardsGroupByCatalog  =>_cards;
  Stream<CardsGroupByCatalog> get stream =>_stream;
   loadCards(int catalogId)async{
    List<CardComplete> _cardCompletes= await _scheduleDao.fetchCardComletesByCatalogId(catalogId);
    
     
     
   }
}