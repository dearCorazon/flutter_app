import 'dart:io';

import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/Bean/Judgement.dart';
import 'package:flutter_app/Bean/MutiChoiceBean.dart';
import 'package:flutter_app/Log.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DaoApi{
  static final _databasename= 'mydatabase';
  static final _databaseVersion =1;
  Database _database;
  String _path;
  String table ='choice';
  Future<void> _open()async{
    Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    _path = join(documentaryDirectory.path,_databasename);
    _database=await openDatabase(_path,version: _databaseVersion);
  }
  Future<void> insertChoicCard(ChoiceCardBean card)async{
    await _open();
    String sql ='insert into choice ';
    int result = await _database.insert(table ,card.toMap());
    if(result == 0 ){
      Logv.Logprint("插入失败");
    }
  
  } 
  Future<List<Map>> queryAll()async{
    String sql =  "select *from choice";
    await _open();
    List<Map>  maps  =  await _database.rawQuery(sql);
    return  maps;

  }
  Future<List<ChoiceCardBean>> queryAllInChoiceCard()async{
    List<Map> maps =await queryAll();
    List<ChoiceCardBean> cards=[];
    for( var map in maps){
      cards.add(ChoiceCardBean.fromMap(map));
    }
    if(cards.length==0){
      Logv.Logprint("in queryAllInChoicCard  error!");
    }
    return cards;

  }


  //////////////////////////////MUtiCard//////////////
  
   Future<List<Map>> queryAllMuti()async{
    String sql =  "select *from muti";
    await _open();
    List<Map>  maps  =  await _database.rawQuery(sql);
    return  maps;

  }
   Future<List<MutiChoiceBean>> queryAllInMutiChoiceCard()async{
    List<Map> maps =await queryAllMuti();
    List<MutiChoiceBean> cards=[];
    for( var map in maps){
      cards.add(MutiChoiceBean.fromMap(map));
    }
    if(cards.length==0){
      Logv.Logprint("in queryAllInChoicCard  error!");
    }
    return cards;
  }
  
  ///////////////////////////judge
  Future<List<JudgementBean>> queryCardsInJudgeByCatalogId(int catalogId)async{
    String sql= 'select * from judge where catalogId=$catalogId';
    await _open();
    List<JudgementBean> cards=[];
    List<Map>  maps = await _database.rawQuery(sql);
    for(var map in maps){
       cards.add(JudgementBean.fromMap(map));
    }
    if(cards.length==0){
      Logv.Logprint("in queryAllInChoicCard  error!");
    }
    return cards;
  }

}