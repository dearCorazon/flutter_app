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
  //static final _sql_createTableSchedule2='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(testID,userID))';
  Future<void> _open()async{
    _database = await Sqlite_helper.instance.database;
    // Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    // print("logv:documentaryDiretory"+documentaryDirectory.toString());
    // _path = join(documentaryDirectory.path,_databasename);
    // print("logv:_path:"+_path);
    // database=await openDatabase(_path,version: _databaseVersion);
    // Logv.Logprint("database open? "+database.isOpen.toString());
  }

  Future<List<Map>> fetchDataByCatalog(int catalogId)async{
    //static final _sql_createTableSchedule2='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(testID,userID))';
    //String sql2="select test.id as id,test.question,test.answer,test.type,test.catalogId,test.tag,test.chaos from test,catalog where test.catalogid=$id and test.catalogid=catalog.id";
    String sql='select test.id,test.question,test.answer,test.type,test.catalogId,test.tag,test.chaos,schedule.status,schedule.nextTime,schedule.ismark from test,schedule where test.catalogId=$catalogId and schedule.testid=test.id';
    await _open();
    List<Map> maps= await _database.rawQuery(sql);
    return maps;

  }
  Future<List<Map>> queryAll()async{
    await _open();
    String sql='select * from schedule';
    List<Map> maps= await _database.rawQuery(sql);
    return maps;
  }
  Future<int> insert(Schedule schedule)async{
    await _open();
    int result=await _database.insert(table,schedule.toMap());
    Logv.Logprint("result:"+result.toString());
    //await database.close();
    return result;
  }
  Future<int> getSceduleIdbyeTestId(int testId)async{
    await _open();
    final String sql ='select schedule.id from schedule,test where test.id=$testId and schedule.testid=test.id';
    List<Map> maps = await _database.rawQuery(sql);
    if(maps.length>0){
      Logv.Logprint("in scheduleDao.getSceduleIdbyeTestId:"+maps.toString());
      int  result = int.parse(maps.first.values.elementAt(0).toString());
      Logv.Logprint("in scheduleDao.getSceduleIdbyeTestId:"+result.toString());
      return result;
    }else{
        Logv.Logprint("in scheduleDao.getSceduleIdbyeTestId:no maps");
    }
    
  }
  Future<int> getStatusBySchduleId(int testId)async{
    final String  sql='select schedule.status from schedule,test where test.id=$testId and schedule.testid=test.id';
    await _open();
    List<Map> maps = await _database.rawQuery(sql);
    if(maps.length>0){
      Logv.Logprint("in scheduleDao.getStatusBySchduleId:"+maps.toString());
      int  result = int.parse(maps.first.values.elementAt(0).toString());
      Logv.Logprint("in scheduleDao.getStatusBySchduleId:"+result.toString());
      return result;
    }else{
        Logv.Logprint("in scheduleDao.getStatusBySchduleId:no maps");
    }

  }
  Future<List<Schedule>> queryAll2()async{
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
  Future<void> updateNexttime(String newtimeString,int id)async{
    await _open();
    String sql2='UPDATE knowledge SET status = ?  WHERE id = ? ';
    final String sql ='UPDATE schedule SET nexttime = "$newtimeString"  WHERE id = $id ';
    int result  = await _database.rawUpdate(sql);
    Logv.Logprint("in Schedule updateNexttime , the number of changes made $result");
  }
  Future<Schedule> queryBytestId(int testId)async{
    await _open();
    final String sql = 'select schedule.id,status,nexttime,ismark from test,schedule where test.id=$testId and schedule.testid=test.id ';
    //TODO: ismark 不知为何为空 应该已经解决了
    List<Map> maps = await _database.rawQuery(sql);
    Logv.Logprint("in Schedule queryBytestId ,maps="+maps.toString());
     if(maps.length>0){
      Schedule schedule=  Schedule.fromMap(maps.first);
      Logv.Logprint("in Schedule queryBytestId ,map="+schedule.toString());
      //await database.close();
      return schedule;
    }
    
  }
  // Future<Schedule> update_status(int status)async{
  //   Schedule schedule;
  //   await _open();
  //   _database.update(table, )
  //   return schedule;
  // }
  


}