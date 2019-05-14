import 'package:flutter_app/Widget/Login.dart';
import 'package:flutter_app/Widget/HomoPage.dart';
import 'package:flutter/material.dart';
import 'memory.dart';
import 'package:flutter_app/PersonPage.dart';
import 'package:flutter_app/KnowledgePage.dart';
import 'package:flutter_app/DAO/SqliteDemo.dart';
import 'package:flutter_app/DAO/DaoTest.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  // Myapp()async{
  //   await _init();
  // }
  // _init()async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setString('name', 'name(not sign)');
  //   await sharedPreferences.setString('email', 'null(not sign)');
  // }
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'demo',
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home:  new MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/homepage':(BuildContext context)=>new MyHomePage(),
        '/login':(BuildContext context)=>new Login(),
        '/memory':(BuildContext context)=>new memory(),
        '/personPage':(BuildContext context)=>new PersonPage(),
        '/knowledge':(BuildContext context)=>new Knowledge_Page(),
        '/sqlitedemo':(BuildContext context)=>new Sqlite_demo(),
        '/daotest':(BuildContext context)=>new DaoTest(),
      },
    );
  }
}

