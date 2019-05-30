
import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Log.dart';

class DropDownMenuState with ChangeNotifier{
  //代表下来菜单的状态
  TestDao testDao= new TestDao();
  CatalogDao catalogDao = new CatalogDao();
  int catalogId;
  int cardType=1;//为1代表普通卡片，2 代表单选题，3 代表多选题，4 代表 大题 
  //大题和普通卡片 可以合并为一个类型？
  String currentSelectedCatalogName='全部';
  DropDownMenuState(){
    _init();
  }
  void changeCardType(String name){
    switch (name){
      case "普通卡片": {cardType=1;notifyListeners();}
      break;
      case "单选题" :{cardType=2;notifyListeners();}
      break;
      case "多选题":{cardType=3;notifyListeners();}
      break;
      case "大题":{cardType=4;notifyListeners();}
      break;
    }
   

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

  void loadCurrentCatologName(String name){
    currentSelectedCatalogName= name;
    notifyListeners();
  }
  void changeCurrentCatalogNumber(String name)async{
   CatalogDao catalogDao = new CatalogDao();
   if(name=='全部'){
     _currentNumber = await catalogDao.allCardNumber();
    _currentCardList= await testDao.queryAll();

   }else{
     _currentNumber=await catalogDao.getNumberbyName(name);
     _currentCardList=await testDao.queryListByName(name);
     catalogId= await catalogDao.getIdByName(name);
     Logv.Logprint("test State:ppppppppppppppppppppppppppp: "+ catalogId.toString());
   }
   await notifyListeners();
  }
//根据所选的Id来获取当前目录的卡片数
//默认为全部
//可以在初始化的时候全部取出
}