import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/Bean/CardComplete.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/CatalogStatusNumbers.dart';
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
import 'package:flutter_app/Utils/Api.dart';
import 'package:flutter_app/Widget/Login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DAO/Sqlite_helper.dart';
import 'Widget/Homepage.dart';
import 'memory.dart';
import 'package:flutter_app/PersonPage.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/DaoTest.dart';

void main() async{
  //TODO:登录注册
  //TODO:从网络获取题库
  //TODO：Drawer 返回主页
  //TODO：准备选择题的模板
  //TODO：同步
  //TODO:美化

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
  List<Map> maps =await scheduleDao.fetchCardsCompleteByCatalog(1);
  Api api = new Api();
  //await api.register("8989@qq.com" , "123456");
  int id =await api.login("8989@qq.com" , "123456");
  //await scheduleDao.delete(1);
  // Logv.Logprint(maps.toString());
  // List<CardComplete> cards = await scheduleDao.loadCardListwithSchedule(1,50);
  // Logv.Logprint("8989898998989989898989898989\n"+cards.toString());
  //测试ScheduleDao...........................................
  // 
  // List<Map> maps= await scheduleDao.fetchDataByCatalog(3);
  // List<Map> maps2= await scheduleDao.queryAll();
  // Logv.Logprint("scheduleDao.fetchDataByCatalog test-> maps"+maps.toString());
  // Logv.Logprint("scheduleDao.queryAll() test-> maps"+maps2.toString());
  // Schedule  schedule=await scheduleDao.queryBytestId(2);
  // await catalogDao.fetcbAllCatalogId();
  // //fetcbAllCatalogId()
  // List<CatalogStatusNumbers>  lists= await  loadCatalogStatusNumbersList();
  // Logv.Logprint("CatalogStatusNumbers()()()()()()()()()())\n"+lists.toString());
  
  ///Logv.Logprint("fetcbAllCatalogId()................................................\n"+ints.toString());
  //测试ScheduleDao....................................................
  //测试是否能取出DateTime/////////////////////////////////////// 
  // String timeString  = await testDao.getDateTimebyId(3);
  // await Logv.Logprint("测试是否能取出DateTime$timeString");
  // DateTime dateTime3 = DateTime.parse(timeString);
  // Logv.Logprint(dateTime3.isAfter(DateTime.now()).toString());
  // List<Map> maps_90 = await scheduleDao.getStatusNumber();
  // Logv.Logprint("scheduleDao.getStatusNumber():00000000000000000000000000000000000000000000000\n"+maps_90.toString());
  // List<CardComplete> cards;
  // cards=await scheduleDao.fetchCardCompletrAll();
  // Logv.Logprint("1902999933212432423947934812938118312893901283\n"+cards.toString());

  //测试是否能取出DateTime///////////////////////////////////////
  // int result2_1= await scheduleDao.addStatus(1);

  //测试是否能取出DateTime///////////////////////////////////////
  //测试是否能取出DateTime///////////////////////////////////////
  //List<Test> tests = await testDao.loadCardListWithSchedule(4, 20);
 // Logv.Logprint(" testDao.loadCardListWithSchedule:"+tests.toString());
  //测试Schedule updateNexttime///////
  // Logv.Logprint("测试Schedule updateNexttime");
  // await  scheduleDao.updateNexttime(DateTime.now().toIso8601String(), 1);
  // Logv.Logprint("测试Schedule updateNexttime");

  // List<Map> maps3= await  scheduleDao.fetchDataByCatalog(4);
  // Logv.Logprint("all maps:\n"+maps3.toString());
  // List<Map> newmaps=[];
  // for (var map in maps3){
  //   String datatimeString = map['nextTime'];
  //   //Logv.Logprint("timeString :"+datatimeString);
  //   DateTime datetime = DateTime.parse(datatimeString);
  //   if ( !datetime.isAfter(DateTime.now())) {
  //         //Logv.Logprint("pick" + test.id.toString() + test.question);
  //         newmaps.add(map);
  //         //Logv.Logprint("length:"+currentListWithSchedule.toString());
  //       }
  // }
  // Logv.Logprint("new  maps:\n"+maps3.toString());
  // List<Test> newtests =[];
  // for(var map in newmaps){
  //   newtests.add(Test.fromMap(map));
  // }
  // Logv.Logprint("new  List<Test>:\n"+newtests.toString());
  //List<Test> maps3= await  scheduleDao.loadCardswithSchedule(4);
  //Logv.Logprint("test scheduleDao.loadCardswithSchedule(4)\n"+maps3.toString());
  //getScheduleIdTestIdByTestId
  // int id= await scheduleDao.getSceduleIdbyeTestId(100);
  // Logv.Logprint("ID is ++++++++++++++++++++++++++++++++++++++++++;/n $id");

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
   //List<Test> tests2= await testDao.queryListByCatalogId(1);
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
  //尝试取出每个目录下的所有 schedule 每个记忆状态下的个数
  
  
  
  //尝试取出每个目录下的所有 schedule 每个记忆状态下的个数
  // String now = DateTime.now().toIso8601String();
  // print(now);
  // DateTime dateTime = DateTime.parse(now);
  // print( dateTime.toIso8601String());
  // DateTime dateTime2=dateTime.add(Duration(minutes: 1));
  // Logv.Logprint("time 1 is after time2:"+dateTime.isAfter(dateTime2).toString());
  // print(dateTime2.toIso8601String());
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
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   
  //  ImportCards importCards = new ImportCards();
  //  importCards.importZhengzhi();
  
//   ScheduleDao scheduleDao = new ScheduleDao();
//  List<Schedule> schedules=[];
//   schedules=await scheduleDao.queryAll();
//   for (var e in schedules) {
//     Logv.Logprint(e.toString());
//   }
}
Future<List<CatalogStatusNumbers>> loadCatalogStatusNumbersList()async{
  CatalogDao catalogDao = new CatalogDao();
  List<CatalogStatusNumbers> catalogStatusNumbers=[];
  List<int> ints =await catalogDao.fetcbAllCatalogId();
    for (var i  in ints ){
    ScheduleDao scheduleDao= new ScheduleDao();
    int status1=0;
    int status2=0;
    int status3=0;
    int status4=0;
    Logv.Logprint("尝试取出每个目录下的所有 schedule 每个记忆状态下的个数\n");
    List<Map> maps_h=await scheduleDao.fetchDataByCatalog(i);
  //取出所有的List
    Logv.Logprint("fetchDataByCatalogmaps_h:\n"+maps_h.toString());
    int number=0;
    for(var map in maps_h){
      int status =int.parse(map['status'].toString());
      if(status<0){
       status1++;
      }
      if(status>=0&&status<20){
       status2++;
      }
      if(status>=20&&status<50){
       status3++;
      }
      if(status>=50){
       status4++;
      }
      number++;
      i= int.parse(map[ColumnCatalogId].toString());
      //catalogStatusNumbers.add(CatalogStatusNumbers.create(catalogId,number,status1,status2,status3,status4));
  }
    CatalogStatusNumbers catalogStatusNumber=CatalogStatusNumbers.create(i, number, status1, status2, status3, status4);
    catalogStatusNumbers.add(catalogStatusNumber);
    Logv.Logprint("catalogStatusNumbers:\n"+catalogStatusNumber.toString());
    }
    return catalogStatusNumbers;
}
_setList(int catalogId)async{
    ScheduleDao scheduleDao= new ScheduleDao();
    int status1=0;
    int status2=0;
    int status3=0;
    int status4=0;
    Logv.Logprint("尝试取出每个目录下的所有 schedule 每个记忆状态下的个数\n");
    List<Map> maps_h=await scheduleDao.fetchDataByCatalog(catalogId);
  //取出所有的List
    Logv.Logprint("fetchDataByCatalogmaps_h:\n"+maps_h.toString());
    int number=0;
    for(var map in maps_h){
      int status =int.parse(map['status'].toString());
      if(status<0){
       status1++;
      }
      if(status>=0&&status<20){
       status2++;
      }
      if(status>=20&&status<50){
       status3++;
      }
      if(status>=50){
       status4++;
      }
      number++;
      catalogId= int.parse(map[ColumnCatalogId].toString());
      //catalogStatusNumbers.add(CatalogStatusNumbers.create(catalogId,number,status1,status2,status3,status4));
  }
    CatalogStatusNumbers catalogStatusNumber=CatalogStatusNumbers.create(catalogId, number, status1, status2, status3, status4);
    Logv.Logprint("catalogStatusNumbers:\n"+catalogStatusNumber.toString());
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
