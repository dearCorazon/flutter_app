import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/DAO/Sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';
class CatalogDao{
  static final _databasename= 'mydatabase';
  static final _databaseVersion =1;
  String table="catalog";
  Database _database;
  String _path;
  String sql_fetchdata='select id,countfrom catalog where  ';
  Future<void> _open()async{
    Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    _path = join(documentaryDirectory.path,_databasename);
    _database=await openDatabase(_path,version: _databaseVersion);
  }

  Future<int> insert(Catalog catalog)async{
    await _open();
    int result=await _database.insert(table,catalog.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
    Logv.Logprint("result:"+result.toString());
    return result;
   }

  Future<List<Catalog>> queryAll()async{
    List<Catalog> catalogs=[];
    await _open();
    List<Map> maps = await _database.query(table,
    columns: [Columnid,Columnname,ColumnsuperiorId]);
    if(maps.length>0){
      for(int i=0;i<maps.length;i++){
        catalogs.add(Catalog.fromMap(maps[i]));
      }
      return catalogs;
    }
    Logv.Logprint("error:no maps");
    
    return null;
  }
  // Future<List<Catalog>> fetchData()async{
  //   List<Catalog> catalogs=[];
  //   await _open();

  //   List<Map>maps = await _database.rawQuery(sql,)
  //   return catalogs; 
  // }

} 
