import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_app/Log.dart';
class ScheduleDao{
  static final _databasename= 'mydatabase';
  static final _databaseVersion =1;
  String table="schedule";
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
  Future<int> insert(Schedule schedule)async{
    await _open();

  }


}