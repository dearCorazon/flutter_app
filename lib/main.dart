import 'dart:convert';

import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Catalog_extra.dart';
import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/ImportCards.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsAddState.dart';
import 'package:flutter_app/Provider/CardsShowState.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:flutter_app/Widget/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DAO/Sqlite_helper.dart';
import 'Widget/Homepage.dart';
import 'memory.dart';
import 'package:flutter_app/PersonPage.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/DaoTest.dart';

void main() async{
  await _Dbinit();
  await test();
  await runApp(MyApp());
} 

void test()async{
  String mapString= '[{id: 4, question: English, answer: 英语, type: 1, catalogId: 3, tag: null, chaos: null, status: 0, nextTime: 2019-05-28T14:10:28.327963, ismark: null}]';
  //默认目录 ：1 默认 2  网络安全法 3 英语
  CatalogDao catalogDao = new CatalogDao();
  TestDao  testDao = new TestDao();
  ScheduleDao scheduleDao= new ScheduleDao();
  //测试ScheduleDao...........................................
  // 
  List<Map> maps= await scheduleDao.fetchDataByCatalog(3);
  List<Map> maps2= await scheduleDao.queryAll();
  Logv.Logprint("scheduleDao.fetchDataByCatalog test-> maps"+maps.toString());
  Logv.Logprint("scheduleDao.queryAll() test-> maps"+maps2.toString());
  Schedule  schedule=await scheduleDao.queryBytestId(2);
 
  //测试ScheduleDao....................................................
  //测试是否能取出DateTime/////////////////////////////////////// 
  String timeString  = await testDao.getDateTimebyId(3);
  await Logv.Logprint("测试是否能取出DateTime$timeString");
  DateTime dateTime3 = DateTime.parse(timeString);
  Logv.Logprint(dateTime3.isAfter(DateTime.now()).toString());
  //测试是否能取出DateTime///////////////////////////////////////

  //测试Schedule updateNexttime///////
  // Logv.Logprint("测试Schedule updateNexttime");
  // await  scheduleDao.updateNexttime(DateTime.now().toIso8601String(), 1);
  // Logv.Logprint("测试Schedule updateNexttime");


  //测试Schedule updateNexttime///////
  ////////////////////////////////////政治json测试
  // var data = jsonDecode(json);
  // int number = int.parse(data['number']);
  // catalogDao.insert(Catalog.create("政治"));
  // for(int i = 0; i < number; i++){
  //   print("question: ${data['timu'][i]['question']}, answer: ${data['timu'][i]['answer']}");
  //   testDao.insert(Test.createWithCatalog(data['timu'][i]['question'], data['timu'][i]['answer'], 4));
  // }
   ////////////////////////////////////政治json测试
  //测试insert返回的参数是否是id...........................................
  // await testDao.insert(Test.create("出来", "挨打"));
  // await testDao.insert(Test.create("好", "惹"));

  //结果为是
  //测试insert返回的参数是否是id...........................................

  // int id ;
  // List<Test> tests2= await testDao.queryListByCatalogId(1);
  // Logv.Logprint("tests2:........................."+tests2[0].toString());
  // id = await catalogDao.getIdByName("English");
  // Logv.Logprint("id:0000000000000000000000000000000000000000000:$id");
  // List<Test> tests1=await testDao.queryListByName('English');
  // Logv.Logprint("querybyname:))))))))))))))))"+tests1.toString());
  // List<Test> tests=await testDao.queryAll();
  // Logv.Logprint("all test:....................."+tests.toString());
  // List<Catalog> catalogs = await catalogDao.queryAll();
  // List<Map> maps = [];
  // List<Map> maps2=[];
  // String name;
  //TODO:当数据为空时 ，会报错，所以理论上，当手机中没有数据时 ，也不会启动
  // int result= await catalogDao.getNumberbyName('English');
  // Logv.Logprint("result ........"+result.toString());
  // Logv.Logprint("test==============:"+maps2.toString());
  // int length=await catalogDao.allCardNumber();
  // //await testDao.insert(Test.createWithCatalog("aaas\n", "asdasd\n\n\n\n\n\n\n\n\n\n\n", 2));
  // Logv.Logprint("all cards number "+length.toString());
  // List<String> a = ["quanbu"];
  // List<String> b = ["add","bdd","pdd"];
  // Logv.Logprint("add before"+a.toString());
  // a.addAll(b);
  // Logv.Logprint("add after:"+a.toString());
  // catalogs.forEach(
  //   (e){
  //     maps.add(e.toMap());
  //     }
  
  // );

  // maps.forEach((map){
  //   String name;
  //   map["superiorName"]= name;

  // });
  //第一步：从对应的superiorId中找出对应的名字

  //Logv.Logprint("map first test: ");
  //Logv.Logprint("maps:"+maps.toString());
  // Logv.Logprint("maps:"+getNameByID(maps,1));

  // maps.forEach((map)async{
  //     String superiorName;
  //     superiorName = await catalogDao.queryAllCatalogNames();
  //     map['superiorName']=superiorName;
  // });
  // Catalog catalog= Catalog.create("test");
  // CatalogDao catalogDao = new CatalogDao();
  // Logv.Logprint("catalog :${catalog.toString()}");
  // Catalog_extra catalog_extra =Catalog_extra.create("test2", 2);
  // Logv.Logprint("catalog extra: ${catalog_extra.toString()}");
  // Logv.Logprint("catalog extra: ${catalog_extra.toMap()}");
  // TestDao testDao = new TestDao();
  // List<Map> maps= await catalogDao.fetchData();
  // Logv.Logprint("maps:"+maps.toString());
  // TestDao testDao = new TestDao();
  // int result= await testDao.card_number(-1);
  // Logv.Logprint("card number init: "+result.toString());
  // await testDao.insert(Test.create("card", "卡片"));
  // result= await testDao.card_number(-1);
  // Logv.Logprint("card number after add: "+result.toString());

  //测试DateTime...........................................
  
  String now = DateTime.now().toIso8601String();
  print(now);
  DateTime dateTime = DateTime.parse(now);
  print( dateTime.toIso8601String());
  DateTime dateTime2=dateTime.add(Duration(minutes: 1));
  Logv.Logprint("time 1 is after time2:"+dateTime.isAfter(dateTime2).toString());
  print(dateTime2.toIso8601String());
  //测试DateTime.........................................
}
String getNameByID(List<Map> maps,int i){
  String name;
 // name= maps.singleWhere((map)=>map["id"]==i).values.toList();
  return name;
}
_Dbinit() async {
  //目录iD  1 为默认 2 为网络安全法 3 为英语 
   Logv.Logprint("Database init......................................");
   await Sqlite_helper.instance.database;
   CatalogDao catalogDao = new CatalogDao();
   TestDao testDao = new TestDao();
  //  ImportCards importCards = new ImportCards();
  //  importCards.importZhengzhi();
  
//   ScheduleDao scheduleDao = new ScheduleDao();
//  List<Schedule> schedules=[];
//   schedules=await scheduleDao.queryAll();
//   for (var e in schedules) {
//     Logv.Logprint(e.toString());
//   }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CardsShowState>(
            builder: (context)=>CardsShowState(),
          ),
          ChangeNotifierProvider<CardsAddState>(
            builder: (context)=>CardsAddState(),
          ),
          ChangeNotifierProvider<DropDownMenuState>(
            builder: (_) => DropDownMenuState(), 
          ),
          ChangeNotifierProvider<CatalogState>(
            builder: (_) => CatalogState(), 
          ),
          ChangeNotifierProvider<UserState>(
             builder: (context)=>UserState(),
           ),
        ],
        child: MaterialApp(
        title: 'demo',
        theme: ThemeData.light(),
        home:  HomePage(),
        // ChangeNotifierProvider<CatalogState>(
        //   builder: (_) => CatalogState(), 
        //   child:HomePage()
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new Login(),
          '/memory': (BuildContext context) => new memory(),
          '/personPage': (BuildContext context) => new PersonPage(),
          '/daotest': (BuildContext context) => new DaoTest(),
        },
      ),
    );
  }
}
