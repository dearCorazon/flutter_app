
import 'package:flutter/material.dart';

class DropDownMenuState with ChangeNotifier{
  DropDownMenuState(){
    _init();
  }
  _init(){

  }
  int __catalogselectedId=-1;
  //根据CatalogId来查询当前目录下的数
  String _catalogselected ='';
  int _currentNumber;
  int  get getcurrentNumber =>_currentNumber;
  void get getcatalog => _catalogselected;
  void updateCatalog(String catalogselected){
    _catalogselected = catalogselected;
    notifyListeners();
  }
  void changeCurrentCatalogNumber(String name){
    
    
  }
//根据所选的Id来获取当前目录的卡片数
//默认为全部
//可以在初始化的时候全部取出
}