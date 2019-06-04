import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Bean/CatalogExtra.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';

class CatalogExtraState with ChangeNotifier{
  //TODO：准备弃用
  ScheduleDao scheduleDao = new ScheduleDao();
  List<CatalogExtra> catalogExtra= [];
  CatalogExtraState(){
    _fetchData();
  }
  _fetchData()async{
    catalogExtra= await scheduleDao.loadCatalogExtraList();
    await notifyListeners();
  }
}