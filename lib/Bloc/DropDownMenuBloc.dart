import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app/Bean/CatalogBean.dart';
import 'package:flutter_app/DAO/DaoApi.dart';
import 'package:flutter_app/Log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DropDownMenuBloc with ChangeNotifier {
  DaoApi daoApi = new DaoApi();
  StreamController<CatalogBean> _streamController = new StreamController();
  Stream<CatalogBean> _stream;
  CatalogBean _catalogBean;

  DropDownMenuBloc() {
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
   // loadCatalogId();
    loadInformation();
  }

  Stream<CatalogBean> get stream =>_stream;
  CatalogBean get  catalogBean =>_catalogBean;
  
  setCatalogIdInShardPrefrence(int catalogId)async{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.setInt("currentCatalogId",catalogId);
     chooseCatalogId= catalogId;
    notifyListeners();
  }
  loadCatalogId()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int catalogId= sharedPreferences.getInt("currentCatalogId");
    Logv.Logprint("in loadCatalogId"+catalogId.toString());
    chooseCatalogId= catalogId;
  }
  loadInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int catalogId= await sharedPreferences.getInt("currentCatalogId");
    chooseCatalogId =catalogId;
    _catalogBean=await daoApi.queryCatalogInformationByCatalogId(chooseCatalogId);
    _streamController.sink.add(_catalogBean);
  }

  void dispose() {
    _streamController.close();
  }

  int chooseCatalogId=0;
  updateCatalogId(int id) {
    chooseCatalogId = id;
    notifyListeners();
  }
}
