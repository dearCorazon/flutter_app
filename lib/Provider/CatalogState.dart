import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Catalog_extra.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/Log.dart';

class CatalogState with ChangeNotifier{
    CatalogState(){
    Logv.Logprint("in Catalog State Constructor.....");
    Logv.Logprint("before fetch data:"+_allCatalogExtraNames.toString());
    fetchData();
    Logv.Logprint("after fetch data:"+_allCatalogExtraNames.toString());
    Logv.Logprint("after fetch data:"+_allCatalogNames.toString());
    }
    //todo：可优化的地方:先取出所有的List<Catalog> 再根据数据的要求再整理成List 或者map，数据处理再这个dart文件中搞
    List<String> _allCatalogExtraNames=["全部"];
    List<Catalog> _catalogs =[];
    List<String> _allCatalogNames=[];

    List<Catalog_extra> _catalogExtras=[];
    Future<void> fetchData()async{
      notifyListeners();
      CatalogDao catalogDao = new CatalogDao();
      _catalogs = await catalogDao. queryAll();
      _allCatalogNames= await catalogDao.queryAllCatalogNames();
       _allCatalogExtraNames.addAll(_allCatalogNames);
      Logv.Logprint("inCatalog State fetchData:.............all Extra name:"+_allCatalogExtraNames.toString());
      notifyListeners();
    }

  List<String>  get getAllCatalognamesExtra{
    Logv.Logprint("in get getAllCatalognamesExtra:"+_allCatalogExtraNames.toString());
    return _allCatalogExtraNames;
  }
  List<Catalog> get getCatlalogs => _catalogs;
  List<String>  get getAllCatalognames => _allCatalogNames;

}