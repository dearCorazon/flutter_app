import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/CatalogBean.dart';
import 'package:flutter_app/DAO/DaoApi.dart';
import 'package:flutter_app/Log.dart';

class CatalogBloc with ChangeNotifier{
  DaoApi daoApi = new DaoApi();
  StreamController<List<Catalog>> _streamController =new StreamController();
  Stream<List<Catalog>> _stream;
  List<Catalog> _catalogs;
  List<String> _catlognames;
  CatalogBloc() {
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
    loadCatalogs();
  }
  
  Stream<List<Catalog>> get stream => _stream;
  List<Catalog> get catalogs => _catalogs;
  List<String> get catalognames =>_catlognames;
  loadCatalogs()async{
    _catalogs= await daoApi.queryAllCatalog();
    await  _streamController.sink.add(_catalogs);
    loadCatlogNames();
    Logv.Logprint("in CatalogBloc"+_catalogs.toString());
  }
  loadCatlogNames(){
    //TODO:暂时不用写进Stream?
    List<String> names = [];
    for(var catalog in _catalogs){
      names.add(catalog.name);
    }
    if(names.length==0){
      Logv.Logprint("in loadCatlogNames error!");
    }
    _catlognames=names;
    notifyListeners();
  }


  void dispose() {
    _streamController.close();
  }



  

}