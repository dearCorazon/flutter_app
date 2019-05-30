
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/DAO/Sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';

//static final _sql_createTableTest='CREATE TABLE TEST(
//   id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//   adderId INTEGER,
//   question TEXT,
//   chaos TEXT,
//   answer TEXT,
//   type INTEGER,
//   catalog INTEGER,
//   tag INTEGER)';

class TestDao{
  ScheduleDao scheduleDao = new ScheduleDao();
  static final _databasename= 'mydatabase';
  static final _databaseVersion =1;
  String table="test";
  Database database;
  String _path;
  Future<void> _open()async{
    database = await Sqlite_helper.instance.database;
    Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    _path = join(documentaryDirectory.path,_databasename);
    database=await openDatabase(_path,version: _databaseVersion);
   }
  Future<int> insert(Test test)async{
    await _open();
    int result=await database.insert(table,test.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore,);
    if (result!=null){
       await  scheduleDao.insert(Schedule.create(result, 1));
    }
    else{
      await Logv.Logprint("插入失败："+test.question+"重复");
    }
    // Logv.Logprint("test in testDao.insert...................");
    // Logv.Logprint("result:"+result.toString());
    // Logv.Logprint("test in testDao.insert...................");
    return result;
  }

  Future<List<Test>> queryListByCatalogId(int id)async{
    await _open();
    List<Test> tests=[];
  
    String sql="select test.id as id,test.question,test.answer,test.type,test.catalogId,test.tag,test.chaos from test,catalog where test.catalogid=$id and test.catalogid=catalog.id";
    List<Map> maps = await database.rawQuery(sql);
    Logv.Logprint("in queryListByCatalogId:"+maps.toString());
    if(maps.length>0){
      for(int i=0;i<maps.length;i++){
        tests.add(Test.fromMap(maps[i]));
      }
      return tests;
    }
    Logv.Logprint("error:no maps");
    return null;
  }
  Future<String> getDateTimebyId(int testId)async{
    await _open();
    String sql ='select schedule.nextTime from test,schedule where test.id=schedule.testid and test.id=$testId';
    List<Map> maps;
    maps=await database.rawQuery(sql);
    await Logv.Logprint(maps.toString());
    //return maps.first.values.toList().toString();
    //TODO: maos里面有值但是取不出来不知道为什么
    return maps.first.values.elementAt(0).toString();
    // {
    //   Logv.Logprint("$k,$v");
    //   if(k.toString()=='nextTime'){
    //     return v.toString();
    //   }
      
    //   if(k=='nextTime'){
    //     return v.toString();}
    // });
  }
  Future<List<Test>> loadCardList(int catalogId) async {
    List<Test> currentList;
    currentList = await queryListByCatalogId(catalogId);
    return currentList;
  }
  Future<List<Test>> loadCardListWithCatalogName(String catalogName)async{
    List<Test> currentList;
    CatalogDao catalogDao = new CatalogDao();
    if(catalogName=='全部'){
      currentList= await queryAll();
      return currentList;
    }
    else{
      int catalogId=await catalogDao.getIdByName(catalogName);
      currentList= await queryListByCatalogId(catalogId);
      return currentList;
    }
  }
  Future<List<Test>> loadCardListWithSchedule(int catalogId,int maxlength) async {
    List<Test> currentListWithSchedule=new List<Test>();
    List<Test> currentList;
    //每次最多load50个
    int count = 0;
    currentList = await queryListByCatalogId(catalogId);
    
    // Logv.Logprint("currentListWithSchedule in state:"+currentListWithSchedule.toString());
  }

  Future<List<Test>> queryListByName(String name)async{
    //首先根据目录名 找出目录iD
    //再根据ID 找出该CatalogId==目录Id 的所有卡片
    await _open();
    List<Test> tests=[];
    String sql="select * from test,catalog where catalog.name='$name'and catalog.id=test.catalogid";
    List<Map> maps = await database.rawQuery(sql);
    if(maps.length>0){
      for(int i=0;i<maps.length;i++){
        tests.add(Test.fromMap(maps[i]));
      }
      return tests;
    }
    Logv.Logprint("error:no maps");
    return null;
  }
  Future<List<Test>> queryAll()async{
    String sql = 'select * from test';
    List<Test> tests=[];
    await _open();
    List<Map> maps = await database.rawQuery(sql);
    if(maps.length>0){
      for(int i=0;i<maps.length;i++){
        tests.add(Test.fromMap(maps[i]));
      }
      return tests;
    }
    Logv.Logprint("error:no maps");
    return null;
  }
  Future<void> delete(int id) async{
    await _open();
    int result=await database.delete(table,where: "$ColumnId=?",whereArgs: [id]);
    //database.close();
    Logv.Logprint("影响行数："+result.toString());
  }
  Future<Test>  query(int id)async{
    await _open();
    List<Map> maps = await database.query(table,
        columns: [ColumnId,ColumnQuestion,ColumnAnswer],
        where:"$ColumnId = ?",
        whereArgs: [id]
    );
    if(maps.length>0){
      database.close();
      return new Test.fromMap(maps.first);
    }
    return null;
  }
  Future<int> card_number(int catalogId)async{
    await _open();
    List<Map> maps = await database.rawQuery("select count(*)as number from Test where catalogId=$catalogId");
    print(maps);
    if(maps.length>0){
      return maps.first.values.first;
    }
    else{
      Logv.Logprint("no maps,error:");
      return null; 
    }
  }
}

//class KnowledgeSqlite{
//  Database _database;
//  Sqlite_helper _sqlite_helper;
//  KnowledgeSqlite(){
//    _sqlite_helper =new Sqlite_helper();
//    _sqlite_helper.initDatabase();
//    _database =_sqlite_helper.getDatabase();
//  }
//  void init()async{
//    _sqlite_helper = new Sqlite_helper();
//    await _sqlite_helper.initDatabase();
//    _database= await _sqlite_helper.getDatabase();
//    print(_database.isOpen.toString());
//  }
//  Future<Knowledge_bean> insert(Knowledge_bean knowledge)async{
//    await  init();
//    print("Logv  :isOpen?");
//    print(_database.isOpen);
//    knowledge.id= await _database.insert("knowledge", knowledge.toMap());
//    print("knowledge:id ：");
//    print(knowledge.content);
//    return knowledge;
//  }
//  Future<void> update_status(int id)async{
//    //TODO:如果需要改成直接修改status的函数，就修改这个，else 就删除
//    //await init();
//    int status =await query_status(id);
//    print("修改前Status：$status");
//    String sql='UPDATE knowledge SET status = ?  WHERE id = ? ';
//    status++;
//    print("status应为：$status");
//    int count = await _database.rawUpdate(sql,[status ,id]);
//    status=await query_status(id);
//    print("修改后Status：$status");
//  }
//  Future<void> status_add(int id,bool add)async{
//    int status =await query_status(id);
//    print("修改前Status：$status");
//    String sql='UPDATE knowledge SET status = ?  WHERE id = ? ';
//    if(add){status++;}
//    else{
//      status--;
//    }
//    print("status应为：$status");
//    int count = await _database.rawUpdate(sql,[status ,id]);
//    status=await query_status(id);
//    print("修改后Status：$status");
//  }
//  Future<int> query_status(int id)async{
//    int status;
//    await init();
//    List<Knowledge_bean> knowledges =[];
//    String sql= 'select * from knowledge where id = ?';
//    List<Map> maps = await _database.rawQuery(sql,[id]);
//    if(maps == null ||maps.length == 0){
//      return null;
//    }
//    for(int i =0 ;i< maps.length;i++){
//      knowledges.add(Knowledge_bean.fromMap(maps[i]));
//    }
//    status= knowledges.first.status;
//    print("status=$status");
//    return status;
//
//
//  }
//  Future<List<Knowledge_bean>> query(int id) async{
//    List<Knowledge_bean> knowledges =[];
//    String sql= 'select * from knowledge where id = ?';
//    await init();
//    List<Map> maps = await _database.rawQuery(sql,[id]);
//    if(maps == null ||maps.length == 0){
//      return null;
//    }
//    for(int i =0 ;i< maps.length;i++){
//      knowledges.add(Knowledge_bean.fromMap(maps[i]));
//    }
//    return knowledges;
//  }
//  Future<List<Knowledge_bean>> queryAll() async{
//    await init();
//    List<Map> maps = await _database.query("knowledge",columns: [
//      ColumnId,ColumnStatus,ColumnSuperiorId,ColumnContent,ColumnUserID
//    ]);
//    if(maps == null ||maps.length == 0){
//      return null;
//    }
//    List<Knowledge_bean> knowledges =[];
//    for(int i =0 ;i< maps.length;i++){
//      knowledges.add(Knowledge_bean.fromMap(maps[i]));
//    }
//    return knowledges;
//  }
//
//
//
//}