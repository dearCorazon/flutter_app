import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/CatalogStatusNumbers.dart';
import 'package:flutter_app/Bean/Catalog_extra.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/Log.dart';

class CatalogState with ChangeNotifier{
    CatalogDao catalogDao = new CatalogDao();
    ScheduleDao scheduleDao = new ScheduleDao();
    
    CatalogState(){
      Logv.Logprint("asdasdasdasdasdas1223123123123");
    fetchData();
    }
    //todo：可优化的地方:先取出所有的List<Catalog> 再根据数据的要求再整理成List 或者map，数据处理再这个dart文件中搞
    List<String> _allCatalogExtraNames=["全部"];
    
    List<Catalog> _catalogs =[];
    List<String> _allCatalogNames=[];
    List<CatalogStatusNumbers> catalogStatusNumbersList =[];
    List<Catalog_extra> _catalogExtras=[];
    Future<void> fetchData()async{
      notifyListeners();
      _allCatalogExtraNames=["全部"];
      catalogStatusNumbersList= await scheduleDao.loadCatalogStatusNumbersList();
      _catalogs = await catalogDao. queryAll();
      _allCatalogNames= await catalogDao.queryAllCatalogNames();
      //每调用一次fetchData _allCatalogExtraNames 就要加一次；
      _allCatalogExtraNames.addAll(_allCatalogNames);
      Logv.Logprint("inCatalog State fetchData:.............all Extra name:"+_allCatalogExtraNames.toString());
      Logv.Logprint("inCatalog State fetchData:.............catalogStatusNumbersList:"+catalogStatusNumbersList.toString());
      notifyListeners();
    }

  void loadcatalogStatusNumbersList(){
    
  }
  void reloadAllCatalogNames()async{
    _allCatalogNames= await catalogDao.queryAllCatalogNames();
     notifyListeners();
  }
  void reloadAllCatalognamesExtra()async{
    _allCatalogExtraNames=["全部"];
    _allCatalogNames= await catalogDao.queryAllCatalogNames();
    _allCatalogExtraNames.addAll(_allCatalogNames);
    notifyListeners();
  }
  void reloadCatlogs()async{
    _catalogs = await catalogDao. queryAll();
    notifyListeners();
  }
  CatalogStatusNumbers getSingleById(int catalogId){
    for(var e in catalogStatusNumbersList){
      if(e.catalogId == catalogId){
        return e;
      }
    }
  }
  void updatecatalogStatusNumbersList(int index,CatalogStatusNumbers newsupercard){
    catalogStatusNumbersList[index]=newsupercard;
    notifyListeners();
  }
  List<String>  get getAllCatalognamesExtra{
    Logv.Logprint("in get getAllCatalognamesExtra:"+_allCatalogExtraNames.toString());
    return _allCatalogExtraNames;
  }
  List<Catalog> get getCatlalogs => _catalogs;
  List<String>  get getAllCatalognames => _allCatalogNames;

}