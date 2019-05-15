import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Widget/Login.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'DAO/Sqlite_helper.dart';
import 'Widget/Homepage.dart';
import 'memory.dart';
import 'package:flutter_app/PersonPage.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/DaoTest.dart';

void main(){
  _init();
  runApp(MyApp());
}
_init()async{
  List<Catalog> catalogs=[];
  List<Test> tests=[];
  Logv.Logprint("global init......................................");
  Database database=await Sqlite_helper.instance.database;
  print(database.toString());
  Logv.Logprint("insert initial catalog data.........");
  CatalogDao catalogDao =CatalogDao();
  await catalogDao.insert(Catalog.create("word"));
  catalogDao.insert(Catalog.create("法律"));
  catalogs=await catalogDao.queryAll() ;
  Logv.Logprint("initial catlog are:............");
  for(var e in catalogs){
      Logv.Logprint(e.name);
    }
 
}
class MyApp extends StatelessWidget{
 
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      
      title: 'demo',
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home:   HomePage(),
      routes: <String,WidgetBuilder>{
        '/login':(BuildContext context)=>new Login(),
        '/memory':(BuildContext context)=>new memory(),
        '/personPage':(BuildContext context)=>new PersonPage(),
        '/daotest':(BuildContext context)=>new DaoTest(),
      },
    );
  }
}

