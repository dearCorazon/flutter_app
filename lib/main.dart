import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/Catalog_extra.dart';
import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/TestDao.dart';
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
  CatalogDao catalogDao = new CatalogDao();
  TestDao  testDao = new TestDao();
  int id ;
  id = await catalogDao.getIdByName("English");
  Logv.Logprint("id:0000000000000000000000000000000000000000000:$id");
  List<Test> tests1=await testDao.queryListByName('English');
  Logv.Logprint("querybyname:))))))))))))))))"+tests1.toString());
  List<Test> tests=await testDao.queryAll();
  Logv.Logprint(tests.toString());
  List<Catalog> catalogs = await catalogDao.queryAll();
  List<Map> maps = [];
  List<Map> maps2=[];
  String name;
  //TODO:当数据为空时 ，会报错，所以理论上，当手机中没有数据时 ，也不会启动
  int result= await catalogDao.getNumberbyName('English');
  Logv.Logprint("result ........"+result.toString());
  Logv.Logprint("test==============:"+maps2.toString());
  int length=await catalogDao.allCardNumber();
  //await testDao.insert(Test.createWithCatalog("aaas\n", "asdasd\n\n\n\n\n\n\n\n\n\n\n", 2));
  Logv.Logprint("all cards number "+length.toString());
  List<String> a = ["quanbu"];
  List<String> b = ["add","bdd","pdd"];
  Logv.Logprint("add before"+a.toString());
  a.addAll(b);
  Logv.Logprint("add after:"+a.toString());
  catalogs.forEach(
    (e){
      maps.add(e.toMap());
      }
  
  );

  // maps.forEach((map){
  //   String name;
  //   map["superiorName"]= name;

  // });
  //第一步：从对应的superiorId中找出对应的名字

  //Logv.Logprint("map first test: ");
  Logv.Logprint("maps:"+maps.toString());
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

  // String now = DateTime.now().toIso8601String();
  // print(now);
  // DateTime dateTime = DateTime.parse(now);
  // print( dateTime.toIso8601String());
  // DateTime dateTime2=dateTime.add(Duration(days: 1));
  // print(dateTime2.toIso8601String());
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
        theme: new ThemeData(
          primaryColor: Colors.blue,
        ),
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
