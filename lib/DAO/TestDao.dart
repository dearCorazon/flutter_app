import 'package:flutter_app/Bean/Test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';
class TestDao{
  static final _databasename= 'mydatabase';
  static final _databaseVersion =1;
  String table="test";
  Database database;
  String _path;

  Future<void> _open()async{
    Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    print("logv:documentaryDiretory"+documentaryDirectory.toString());
    _path = join(documentaryDirectory.path,_databasename);
    print("logv:_path:"+_path);
    database=await openDatabase(_path,version: _databaseVersion);
    Logv.Logprint("database open?："+database.isOpen.toString());
   }
  Future<int> insert(Test test)async{
    await _open();
    int result=await database.insert(table,test.toMap());
    Logv.Logprint("result:"+result.toString());
    await database.close();
    return result;
  }
  Future<List<Test>> queryAll()async{
    List<Test> tests=[];
    await _open();
    List<Map> maps = await database.query(table,
    columns: [ColumnId,ColumnQuestion,ColumnAnswer]);
    if(maps.length>0){
      for(int i=0;i<maps.length;i++){
        tests.add(Test.fromMap(maps[i]));
      }
      await database.close();
      return tests;
    }
    Logv.Logprint("error:no maps");
    await database.close();
    return null;
  }
  Future<void> delete(int id) async{
    await _open();
    int result=await database.delete(table,where: "$ColumnId=?",whereArgs: [id]);
    database.close();
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
    await database.close();
    return null;
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