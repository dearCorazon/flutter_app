import 'dart:async';

import 'package:flutter_app/Bean/CatalogExtra.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/DAO/TestDao.dart';

class CatalogExtraBloc{
  CatalogDao catalogDao = new CatalogDao();
  ScheduleDao scheduleDao = new ScheduleDao();
  TestDao testDao=  new TestDao();
  
  StreamController<List<CatalogExtra>> _streamController=new StreamController();
  StreamController<List<CatalogExtra>> _streamController2=new StreamController();
  StreamController<int> _streamController_number =new StreamController();

  
  Stream<List<CatalogExtra>> _stream2;
  Stream<List<CatalogExtra>> _stream;
  Stream<int> _stream_number;

  List<CatalogExtra> _catalogExtras;
  List<CatalogExtra> _catalogExtras2;
  int  _number;


  CatalogExtraBloc(){
    //TODO:之前没有菊花一直旋转的原因在这里? load函数在前？
    _streamController=StreamController.broadcast();
    _streamController2=StreamController.broadcast();
    _streamController_number=StreamController.broadcast();

    _stream = _streamController.stream;
    _stream2 = _streamController.stream;
    _stream_number=_streamController_number.stream;

    initNumber();
    loadCatalogExtraList();
    loadCatalogExtraList2();
    
  }

  int  get  number =>_number;
  List<CatalogExtra> get catalogExtras=>_catalogExtras;
  List<CatalogExtra> get catalogExtras2=>_catalogExtras2;

  Stream<List<CatalogExtra>> get stream =>_stream;
  Stream<List<CatalogExtra>> get stream2 =>_stream2;
  Stream<int>  get stream_number =>_stream_number;

  loadCatalogExtraList()async{
    List<CatalogExtra> catalogExtras= await scheduleDao.loadCatalogExtraList();
    _catalogExtras=catalogExtras;
    _streamController.sink.add(catalogExtras);
  }

  loadCatalogExtraList2()async{//for DropdownMenu
    List<CatalogExtra> catalogExtras= await scheduleDao.loadCatalogExtraList();//获取当前所有目录
    int numbers= await catalogDao.allCardNumber();
    String name = '全部';
    CatalogExtra catalogExtra = new CatalogExtra.create(0, numbers, 0, 0, 0, 0, name);//添加一个总目录
    List<CatalogExtra> catalogExtras1= [];//待插入stream 的List
    catalogExtras1.add(catalogExtra);//先放入总目录
    catalogExtras1.addAll(catalogExtras);
    _catalogExtras2=catalogExtras1;
    _streamController2.sink.add(catalogExtras1);
  }
  loadNumber(String name)async{
    int number;
    if(name=='全部'){
      number = await catalogDao.allCardNumber();
    }
    else{
      number=await catalogDao.getNumberbyName(name);
    }
    _number=number;
    _streamController_number.sink.add(number);
  }
  initNumber()async{
    int number = await catalogDao.allCardNumber();
    _number=number;
    _streamController_number.sink.add(number);
  }

  dispose(){
    _streamController.close();
    _streamController2.close();
    _streamController_number.close();
  }
//   dispose2(){
    
//   }
//   dispose_number(){
    
//   }
// }
}