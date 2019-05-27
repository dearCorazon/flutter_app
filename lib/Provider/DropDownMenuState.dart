
import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/TestDao.dart';

class DropDownMenuState with ChangeNotifier{
  TestDao testDao= new TestDao();
  CatalogDao catalogDao = new CatalogDao();
  DropDownMenuState(){
    _init();
  }
  _init()async{
    _currentNumber = await catalogDao.allCardNumber();
    _currentCardList= await testDao.queryAll();
    await notifyListeners();
  }
  List<Test> _currentCardList= [];
  int __catalogselectedId=-1;
  //根据CatalogId来查询当前目录下的数
  String _catalogselected ='';
  int _currentNumber;
  List<Test> get getCurrentCardList =>_currentCardList;
  int  get getcurrentNumber =>_currentNumber;
  void get getcatalog => _catalogselected;
  void updateCatalog(String catalogselected){
    _catalogselected = catalogselected;
    notifyListeners();
  }
  void changeCurrentCatalogNumber(String name)async{
   CatalogDao catalogDao = new CatalogDao();
   if(name=='全部'){
     _currentNumber = await catalogDao.allCardNumber();
    _currentCardList= await testDao.queryAll();

   }else{
     _currentNumber=await catalogDao.getIdbyName(name);
     _currentCardList=await testDao.queryListByName(name);
     
   }
   await notifyListeners();
  }
//根据所选的Id来获取当前目录的卡片数
//默认为全部
//可以在初始化的时候全部取出
}