import 'package:flutter/widgets.dart';

class  CardsShowState with ChangeNotifier{
  //这部分的数据从CatalogList拿
  int selectedCatalogId;
  int selcetedTagId;
  String selectedCatalogName;
  void loadCatalogInformation(int catalogId,String name){
    //TODO:暂时没有考虑为空的情况 （可能不会有空）
    this.selectedCatalogId=catalogId;
    selectedCatalogName=name;
    notifyListeners();
  }
}