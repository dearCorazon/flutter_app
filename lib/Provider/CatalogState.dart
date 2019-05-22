import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Catalog_extra.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';

class CatalogState with ChangeNotifier{
    CatalogState(){
      fetchData();
    }
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
}