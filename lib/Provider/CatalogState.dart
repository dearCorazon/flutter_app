import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Catalog_extra.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';

class CatalogState with ChangeNotifier{
    CatalogState(){
      fetchData();
    }
    //todo：可优化的地方:先取出所有的List<Catalog> 再根据数据的要求再整理成List 或者map，数据处理再这个dart文件中搞
  
    List<String> _allcatalogs=[];
    List<Catalog> _catalogs =[];
    List<Catalog_extra> _catalogExtras=[];
    Future<void> fetchData()async{
      notifyListeners();
      CatalogDao catalogDao = new CatalogDao();
      _catalogs = await catalogDao. queryAll();
      _allcatalogs= await catalogDao.queryAllCatalogNames();
      notifyListeners();
    }
  List<Catalog> get getCatlalogs => _catalogs;
  List<String>  get getAllcatalognames => _allcatalogs;
  void makedata(){
    
  }
}