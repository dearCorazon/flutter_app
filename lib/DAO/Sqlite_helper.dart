import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';
class Sqlite_helper{
    static final _databasename= 'mydatabase';
    static final _databaseVersion =1;
    static final _sql_createTableTest='CREATE TABLE TEST(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,adderId INTEGER,question TEXT,chaos TEXT,answer TEXT,type INTEGER,catalog INTEGER,tag INTEGER)';
    static final _sql_createTableCatalog='CREATE TABLE CATALOG(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,name TEXT,superiorId INTEGER)';
    static final _sql_createTableSchedule='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,testID INTEGER,userID INTEGER,status INTEGER,nextTime TEXT,followType INTEGER)';
    Database _database;
    String _path;
    Sqlite_helper(){
      _initDatabase();
    }
    _initDatabase()async{
      Logv.Logprint("数据库初始化........");
      Directory documentaryDirectory = await getApplicationDocumentsDirectory();
      print("logv:documentaryDiretory"+documentaryDirectory.toString());
      _path = join(documentaryDirectory.path,_databasename);
      print("logv:_path:"+_path);
      _database= await openDatabase(_path,version: _databaseVersion,
          onCreate: (Database db,int version)async{
            await db.execute(_sql_createTableCatalog);
            await db.execute(_sql_createTableSchedule);
            await db.execute(_sql_createTableTest);
      } );
      var version =await _database.getVersion();
      Logv.Logprint("DB version:"+version.toString());
    }
}