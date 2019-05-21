import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Widget/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'DAO/Sqlite_helper.dart';
import 'Widget/Homepage.dart';
import 'memory.dart';
import 'package:flutter_app/PersonPage.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/DaoTest.dart';
import 'DAO/ScheduleDao.dart';

void main() {
  _Dbinit();
  test();
  runApp(MyApp());
}
void test(){
  String now = DateTime.now().toIso8601String();
  print(now);
  DateTime dateTime = DateTime.parse(now);
  print( dateTime.toIso8601String());
  DateTime dateTime2=dateTime.add(Duration(days: 1));
  print(dateTime2.toIso8601String());
}
// _init3()async{
//   Logv.Logprint("......................schedule time stamp test.............");
//   ScheduleDao scheduledao = new ScheduleDao();
//   scheduledao.insert(Schedule.create(1, -1));
//   scheduledao.insert(Schedule.create(2, -1));
//   List<Schedule> schedules=[];
//   schedules=await scheduledao.queryAll();
//   for (var e in schedules) {
//     Logv.Logprint(e.toString());
//   }
// }
_Dbinit() async {
  Logv.Logprint("global init......................................");
  await Sqlite_helper.instance.database;
  ScheduleDao scheduleDao = new ScheduleDao();
 List<Schedule> schedules=[];
  schedules=await scheduleDao.queryAll();
  for (var e in schedules) {
    Logv.Logprint(e.toString());
  }
  
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'demo',
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home:  ChangeNotifierProvider<CatalogState>(
        builder: (_) => CatalogState(), 
        child:HomePage(),
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/memory': (BuildContext context) => new memory(),
        '/personPage': (BuildContext context) => new PersonPage(),
        '/daotest': (BuildContext context) => new DaoTest(),
      },
    );
  }
}
