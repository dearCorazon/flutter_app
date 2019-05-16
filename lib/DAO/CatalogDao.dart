import 'package:flutter_app/Bean/Catalog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';
class CatalogDao{
  //TODO:目录的内容不能重复
  static final _databasename= 'mydatabase';
  static final _databaseVersion =1;
  String table="catalog";
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

  Future<int> insert(Catalog catalog)async{
    await _open();
    int result=await database.insert(table,catalog.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
    Logv.Logprint("result:"+result.toString());
    await database.close();
    return result;
   }

  Future<List<Catalog>> queryAll()async{
    List<Catalog> catalogs=[];
    await _open();
    List<Map> maps = await database.query(table,
    columns: [Columnid,Columnname,ColumnsuperiorId]);
    if(maps.length>0){
      for(int i=0;i<maps.length;i++){
        catalogs.add(Catalog.fromMap(maps[i]));
      }
      await database.close();
      return catalogs;
    }
    Logv.Logprint("error:no maps");
    await database.close();
    return null;
  }
  


}