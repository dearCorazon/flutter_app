import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Catalog_extra.dart';
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
  Future<void> _open()async{
    Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    _path = join(documentaryDirectory.path,_databasename);
    _database=await openDatabase(_path,version: _databaseVersion);
  }
  Future<List<Map>> queryExtraCatalog()async{
    List<Map> maps =[];
    
    //List<Catalog> catalogs=[];
    // await _open();
    // List<Map> maps = await _database.query(table,
    // columns: [Columnid,Columnname,ColumnsuperiorId]);
    // if(maps.length>0){
    //   for(int i=0;i<maps.length;i++){
    //     catalogs.add(Catalog.fromMap(maps[i]));
    //   }
    //   return catalogs;
    // }
    // Logv.Logprint("error:no maps");
    // return null;
    maps = await _database.rawQuery("select * from catalog");
    maps.forEach((map)async{
        
    });
    return maps;
  }
  Future<int> insert(Catalog catalog)async{
    await _open();
    int result=await _database.insert(table,catalog.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
    Logv.Logprint("result:"+result.toString());
    return result;
   }
  Future<String> getNamebyId(int id)async{
    List<Map> maps = await _database.rawQuery("select name from catalog where id = $id");
    if(maps.length>0){
      return maps.first.values.toList().toString();
    }
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
  Future<List<String>> queryAllCatalogNames()async{
    await _open();
    List<String> catalogs= [];
    final String sql='select name from catalog';
    List<Map> maps = await _database.rawQuery(sql);
    for(Map map in maps){
    map.forEach((key,value)=>catalogs.add(value));
    }
    return catalogs;
  //    CatalogDao catalogDao = new CatalogDao();
  
  // List<Map> maps = await catalogDao.queryAllCatalogNames();
  // Logv.Logprint("all catalogs name:"+maps.toString());
 
  // Logv.Logprint("catalogs:"+catalogs.toString();
  }

  Future<List<Map>> fetchData()async{
    //TODO:不能叫FectchData， 容易跟CatalogState 中的命名混乱
  String sql='select  test.catalogId, catalog.name, count(all test.catalogId) as number '+
  'from test,catalog '+
  "where test.catalogId=catalog.id "+
  "group by test.catalogId";
  String sql_1='select count(distinct catalogId) as number from test ';
  List<Catalog> catalogs=[];
  List<Catalog_extra> catalogExtras=[];
  await _open();
  List<Map>maps = await _database.rawQuery(sql_1);
  return maps; 
}


} 
