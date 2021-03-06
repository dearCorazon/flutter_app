import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';
class Sqlite_helper{
    static final _databasename= 'mydatabase';
    static final _databaseVersion =1;
    static final _sql_createTableTest='CREATE TABLE TEST(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,adderId INTEGER,question TEXT,chaos TEXT,answer TEXT,type INTEGER,catalogId INTEGER,tag INTEGER)';
    static final _sql_createTableCatalog='CREATE TABLE CATALOG(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,name TEXT,superiorId INTEGER)';
    static final _sql_createTableSchedule='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,testID INTEGER,userID INTEGER,status INTEGER,nextTime TEXT,followType INTEGER)';
    static final _sql_createTableCatalog2='CREATE TABLE CATALOG(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,name TEXT UNIQUE,superiorId INTEGER)';
    static final _sql_createTableSchedule2='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(testID,userID))';
    //static final _sql_createTableSchedule3='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testID INTEGER,userID INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(id,testID,userID))';
    static final _sql_createTableSchedule3='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER)';

    Sqlite_helper._privateConstructor();
    static final Sqlite_helper instance = Sqlite_helper._privateConstructor();
    String tableTest ='test';
    String tableCatalog='catalog';
    String tableSchedule='schedule';
    Database _database;
  
    Future<Database> get database async{
      if(_database != null) return _database;
      _database = await _initDatabase();
      return _database;
    }
    _initDatabase()async{
      String _path;
      Directory documentaryDirectory = await getApplicationDocumentsDirectory();
      Logv.Logprint("数据库初始化........");
      print("logv:documentaryDiretory"+documentaryDirectory.toString());
      _path = join(documentaryDirectory.path,_databasename);
      print("logv:_path:"+_path);
      _database= await openDatabase(_path,version: _databaseVersion,
          onCreate: (Database db,int version)async{
            Logv.Logprint("database onCreate:...........................");
            await db.execute(_sql_createTableCatalog2);
            await db.execute(_sql_createTableSchedule2);
            await db.execute(_sql_createTableTest);
            await db.insert(tableTest,Test.create("1+1=?", "2").toMap());
            await db.insert(tableTest,Test.create("English", "英语").toMap());//TODO：一开始没有加await ，该语句执行，但后面的部分都没有执行，why？
            await db.insert(tableCatalog, Catalog.create("default").toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
            await db.insert(tableCatalog, Catalog.create("English").toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
            await db.insert(tableCatalog, Catalog.create("法律").toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
            var schedule= Schedule.create(3, 1);
            Logv.Logprint(schedule.toMap().toString());
            print("schedule1:${schedule.toString()}");
            //await db.insert(tableSchedule,Schedule.create(-1,1).toMap());
            await db.insert(tableSchedule,Schedule.create(4,1).toMap());
            await db.insert(tableSchedule,schedule.toMap());
      } );
      var version =await _database.getVersion();
      Logv.Logprint("DB version:"+version.toString());
      return _database;
    }
    Future<void> close()async{
      _database.close();
    }
}