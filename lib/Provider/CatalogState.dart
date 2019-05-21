import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';

class CatalogState with ChangeNotifier{
    CatalogState(){
      fetchData();
    }
    List<Catalog> _catalogs =[];
    Future<void> fetchData()async{
      notifyListeners();
      CatalogDao catalogDao = new CatalogDao();
      _catalogs = await catalogDao. queryAll();
       notifyListeners();
    }
  List<Catalog> get getCatlalogs => _catalogs;
}