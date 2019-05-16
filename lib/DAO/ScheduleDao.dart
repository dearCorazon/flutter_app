import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/Sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';
class ScheduleDao{
  static final _databasename= 'mydatabase';
  static final _databaseVersion =1;
  String table="schedule";
  Database _database;
  String _path;

  Future<void> _open()async{
    _database = await Sqlite_helper.instance.database;
    // Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    // print("logv:documentaryDiretory"+documentaryDirectory.toString());
    // _path = join(documentaryDirectory.path,_databasename);
    // print("logv:_path:"+_path);
    // database=await openDatabase(_path,version: _databaseVersion);
    // Logv.Logprint("database open? "+database.isOpen.toString());
  }
  
  Future<int> insert(Schedule schedule)async{
    await _open();
    int result=await _database.insert(table,schedule.toMap());
    Logv.Logprint("result:"+result.toString());
    //await database.close();
    return result;
  }

  Future<List<Schedule>> queryAll()async{
    List<Schedule> schedules=[];
    await _open();
    List<Map> maps = await _database.query(table,
    columns: [ColumnId,ColumnTestId,ColumnUserId,ColumnStatus,ColumnNextTime,ColumnFollowType]);
    if(maps.length>0){
      for(int i=0;i<maps.length;i++){
        schedules.add(Schedule.fromMap(maps[i]));
      }
      //await database.close();
      return schedules;
    }
    Logv.Logprint("error:no maps");
    //await database.close();
    return null;
  }
  
  // Future<Schedule> update_status(int status)async{
  //   Schedule schedule;
  //   await _open();
  //   _database.update(table, )
  //   return schedule;
  // }
  


}