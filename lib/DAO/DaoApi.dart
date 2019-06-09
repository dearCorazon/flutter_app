import 'dart:async';
import 'dart:io';

import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/CatalogBean.dart';
import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/Bean/Judgement.dart';
import 'package:flutter_app/Bean/MutiChoiceBean.dart';
import 'package:flutter_app/Log.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DaoApi {
  static final _databasename = 'mydatabase';
  static final _databaseVersion = 1;
  Database _database;
  String _path;
  String table = 'choice';
  Future<void> _open() async {
    Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    _path = join(documentaryDirectory.path, _databasename);
    _database = await openDatabase(_path, version: _databaseVersion);
  }

  Future<void> insertChoicCard(ChoiceCardBean card) async {
    await _open();
    String sql = 'insert into choice ';
    int result = await _database.insert(table, card.toMap());
    if (result == 0) {
      Logv.Logprint("插入失败");
    }
  }

  Future<List<Map>> queryAll() async {
    String sql = "select *from choice";
    await _open();
    List<Map> maps = await _database.rawQuery(sql);
    return maps;
  }

  Future<List<ChoiceCardBean>> queryBycatalogIdInChoiceCard(int id) async {
    await _open();
    final String sql = 'select * from choice where catalogId =$id';
    List<Map> maps = await _database.rawQuery(sql);
    List<ChoiceCardBean> cards = [];
    for (var map in maps) {
      cards.add(ChoiceCardBean.fromMap(map));
    }
    if (cards.length == 0) {
      Logv.Logprint("in queryAllInChoicCard  error!");
    }
    return cards;
  }

  Future<List<ChoiceCardBean>> queryAllInChoiceCard() async {
    List<Map> maps = await queryAll();
    List<ChoiceCardBean> cards = [];
    for (var map in maps) {
      cards.add(ChoiceCardBean.fromMap(map));
    }
    if (cards.length == 0) {
      Logv.Logprint("in queryAllInChoicCard  error!");
    }
    return cards;
  }

//////////////////////////////ChiceCard//////////////
  Future<void> collectChoice(int id, int star) async {
    await _open();
    final String sql = 'update choice set star=$star where id=$id';
    int result = await _database.rawUpdate(sql);
    if (result == 0) {
      Logv.Logprint("in collectMuti error");
    } else {
      Logv.Logprint('star change');
    }
  }

  Future<void> choiceright(int number, int id) async {
    await _open();
    final String sql = 'update choice  set number=$number where id=$id';
    int result = await _database.rawUpdate(sql);
    if (result == 0) {
      Logv.Logprint("in DaoAPI choiceright error!");
    }
  }

  Future<void> choicefalse(int number, int id, int faultnumber) async {
    await _open();
    final String sql1 = 'update choice  set number=$number where id=$id';
    final String sql2 =
        'update choice  set faultnumber=$faultnumber where id=$id';
    int result1 = await _database.rawUpdate(sql1);
    int result2 = await _database.rawUpdate(sql2);
    if (result1 == 0 || result2 == 0) {
      Logv.Logprint("in DaoAPI choiceright error!");
    }
  }

  //////////////////////////////MUtiCard//////////////
  Future<void> collectMuti(int id, int star) async {
    await _open();
    final String sql = 'update muti set star=$star where id=$id';
    int result = await _database.rawUpdate(sql);
    if (result == 0) {
      Logv.Logprint("in collectMuti error");
    }
  }

  Future<void> mutiright(int number, int id) async {
    await _open();
    final String sql = 'update muti  set number=$number where id=$id';
    int result = await _database.rawUpdate(sql);
    if (result == 0) {
      Logv.Logprint("in DaoAPI mutiright error!");
    }
  }

  Future<void> mutifalse(int number, int id, int faultnumber) async {
    await _open();
    final String sql1 = 'update muti  set number=$number where id=$id';
    final String sql2 =
        'update muti  set faultnumber=$faultnumber where id=$id';
    int result1 = await _database.rawUpdate(sql1);
    int result2 = await _database.rawUpdate(sql2);
    if (result1 == 0 || result2 == 0) {
      Logv.Logprint("in DaoAPI mutiright error!");
    }
  }

  Future<List<Map>> queryAllMuti() async {
    String sql = "select *from muti";
    await _open();
    List<Map> maps = await _database.rawQuery(sql);
    return maps;
  }

  Future<List<MutiChoiceBean>> queryAllInMutiChoiceCard() async {
    List<Map> maps = await queryAllMuti();
    List<MutiChoiceBean> cards = [];
    for (var map in maps) {
      cards.add(MutiChoiceBean.fromMap(map));
    }
    if (cards.length == 0) {
      Logv.Logprint("in queryAllInChoicCard  error!");
    }
    return cards;
  }

  ///////////////////////////judge
  ///
  Future<void> collecjudge(int id, int star) async {
    await _open();
    final String sql = 'update judge set star=$star where id=$id';
    int result = await _database.rawUpdate(sql);
    if(result==1){Logv.Logprint("collect success!");}
    if (result == 0) {
      Logv.Logprint("in collectMuti error");
    }
  }

  Future<void> judgeright(int number, int id) async {
    await _open();
    final String sql = 'update judge  set number=$number where id=$id';
    Logv.Logprint("in  judgefalse  即将更新的错题数为$number");
    int result = await _database.rawUpdate(sql);
    if (result == 0) {
      Logv.Logprint("in DaoAPI judgeright error!");
    }
  }

  Future<void> judgefalse(int number, int id, int faultnumber) async {
    await _open();
    final String sql1 = 'update judge  set number=$number where id=$id';
    final String sql2 =
        'update judge  set faultnumber=$faultnumber where id=$id';
    Logv.Logprint("in  judgefalse  即将更新的错题数为$faultnumber");
    int result1 = await _database.rawUpdate(sql1);
    int result2 = await _database.rawUpdate(sql2);
    if (result1 == 0 || result2 == 0) {
      Logv.Logprint("in DaoAPI judgeright error!");
    }
  }

  Future<List<JudgementBean>> queryCardsInJudgeByCatalogId(
      int catalogId) async {
    String sql = 'select * from judge where catalogId=$catalogId';
    await _open();
    List<JudgementBean> cards = [];
    List<Map> maps = await _database.rawQuery(sql);
    for (var map in maps) {
      cards.add(JudgementBean.fromMap(map));
    }
    Logv.Logprint("test  queryCardsInJudgeByCatalogId:" + maps.toString());
    if (cards.length == 0) {
      Logv.Logprint("in queryAllInChoicCard  error!");
    }
    return cards;
  }

  ///////////////////////catalogId
  Future<List<Catalog>> queryAllCatalog() async {
    List<Catalog> catalogs = [];
    await _open();
    String sql1 = 'select * from catalog';
    List<Map> maps = await _database.rawQuery(sql1);
    for (var map in maps) {
      catalogs.add(Catalog.fromMap(map));
    }
    if (catalogs.length == 0) {
      Logv.Logprint("in queryAllCatalog error!");
    }
    return catalogs;
  }

  Future<CatalogBean> queryCatalogInformationByCatalogId(int catalogid) async {
    String sql1 = 'select * from muti  where  catalogId= $catalogid';
    String sql2 = 'select * from  choice where catalogId= $catalogid';
    String sql3 = 'select * from judge where catalogId=$catalogid';
    //String sql4 = 'select * from catalog where catalo'
    await _open();
    String catalogname;

    int number = 0; //答题次数
    int choicenumber = 0;
    int mutinumber = 0;
    int judgenumber = 0;
    int quiznumber = 0;
    int faultnumber = 0;
    List<Map> maps1 = [];
    List<Map> maps2 = [];
    List<Map> maps3 = [];
    maps1 = await _database.rawQuery(sql1);
    maps2 = await _database.rawQuery(sql2);
    maps3 = await _database.rawQuery(sql3);
    catalogname = await getNamebyId(catalogid);
    for (var map in maps1) {
      number = number + int.parse(map['number'].toString());
      faultnumber = faultnumber + int.parse(map['faultnumber'].toString());
    }
    for (var map in maps2) {
      number = number + int.parse(map['number'].toString());
      faultnumber = faultnumber + int.parse(map['faultnumber'].toString());
    }
    for (var map in maps3) {
      number = number + int.parse(map['number'].toString());
      faultnumber = faultnumber + int.parse(map['faultnumber'].toString());
    }
    Logv.Logprint('in DaoApi queryCatalogInformationByCatalogId judge信息' +
        maps3.toString());
    quiznumber = maps1.length + maps2.length + maps3.length;
    choicenumber = maps2.length;
    mutinumber = maps1.length;
    judgenumber = maps3.length;
    CatalogBean catalog = CatalogBean.create(catalogid, choicenumber,
        mutinumber, number, faultnumber, judgenumber, catalogname, quiznumber);
    Logv.Logprint("in DaoApi queryCatalogInformationByCatalogId$catalogid" +
        catalog.toString());
    return catalog;
  }

  Future<String> getNamebyId(int id) async {
    String name;
    List<Map> maps =
        await _database.rawQuery("select name from catalog where id = $id");
    if (maps == null) {
      Logv.Logprint('in DaoAai  getNamebyId error！');
    }
    //Logv.Logprint('in DaoPa ');
    maps.first.forEach((k, v) {
      if (k == 'name') {
        name = v;
      }
    });
    return name;
  }

  ///////wrong book
  Future<List<ChoiceCardBean>> queryStarChoice() async {
    List<ChoiceCardBean> cards = [];
    await _open();
    final String sql = ' select * from choice where star=1';
    List<Map> maps = await _database.rawQuery(sql);
    for (var map in maps) {
      cards.add(ChoiceCardBean.fromMap(map));
    }
    if (cards.length == 0) {
      Logv.Logprint("in queryStarChoice  error!");
    }
    return cards;
  }

  Future<List<MutiChoiceBean>> queryStarMuti() async {
    List<MutiChoiceBean> cards = [];
    await _open();
    final String sql = ' select * from muti where star=1';
    List<Map> maps = await _database.rawQuery(sql);
    for (var map in maps) {
      cards.add(MutiChoiceBean.fromMap(map));
    }
    if (cards.length == 0) {
      Logv.Logprint("in queryStarMuti  error!");
    }
    return cards;
  }

  Future<List<JudgementBean>> queryStarJudge() async {
    List<JudgementBean> cards = [];
    
    await _open();
    final String sql = ' select * from judge where star=1';
    List<Map> maps = await _database.rawQuery(sql);
    for (var map in maps) {
      cards.add(JudgementBean.fromMap(map));
    }
    if (cards.length == 0) {
      Logv.Logprint("in queryStarMuti  error!");
    }
    return cards;
  }
  Future<CatalogBean> wrongbookInformation()async{
    int catalogId=-1;
    int choicenumber=0;//
    int mutinumber=0;//
    int faultnumber=0;
    int quiznumber=0;//
    int number=0;
    int judgenumber=0;//
    String catalogname='错题本';

   
    final String sql1 = ' select * from choice where star=1';
    final String sql2 = ' select * from muti where star=1';
    final String sql3 = ' select * from judge where star=1';
    await _open();
    List<Map>maps1=await _database.rawQuery(sql1);
    List<Map>maps2=await _database.rawQuery(sql2);
    List<Map>maps3=await _database.rawQuery(sql3);
    //if(maps3==null)
    int choicelength=0;
    int mutilength=0;
    int judgelength=0;
    if(maps1==null){
      choicelength=0;
    }else{
      choicelength=maps1.length;
    }
    if(maps2==null){
      mutilength=0;
    }else{
      mutilength=maps2.length;
    }
    if(maps3==null){
      judgelength=0;
    }else{
      judgelength=maps3.length;
    }
    choicenumber= choicenumber+choicelength;
    mutinumber= mutinumber+mutilength;
    judgenumber=judgenumber+judgelength;
    quiznumber= choicenumber+mutinumber+judgenumber;
    CatalogBean catalog= CatalogBean.create(catalogId, choicenumber, mutinumber, number, faultnumber, judgenumber, catalogname, quiznumber);
  return catalog;
  }

  ///staics
  ///
  Future<List<MutiChoiceBean>> topmuti()async{
    final String sql = 'select * from  muti  order by  faultnumber DESC';
    await _open();
    int i=0;
    List<MutiChoiceBean> cards=[];
    List<Map> maps  =await _database.rawQuery(sql);
    Logv.Logprint("1test"+maps.toString());
    for(var map in maps){
      i++;
      cards.add(MutiChoiceBean.fromMap(map));
      if(i==5){
        break;
      }
    }
    return cards;
  }
  Future<List<ChoiceCardBean>> topchoice()async{
    final String sql = 'select * from  choice  order by  faultnumber DESC';
    await _open();
    int i=0;
    List<ChoiceCardBean> cards=[];
    List<Map> maps  =await _database.rawQuery(sql);
    Logv.Logprint("1test"+maps.toString());
    for(var map in maps){
      i++;
      cards.add(ChoiceCardBean.fromMap(map));
      if(i==5){
        break;
      }
    }
    return cards;
  }
    Future<List<JudgementBean>> topJudge()async{
    final String sql = 'select * from  judge  order by  faultnumber DESC';
    await _open();
    int i=0;
    List<JudgementBean> cards=[];
    List<Map> maps  =await _database.rawQuery(sql);
    Logv.Logprint("1test"+maps.toString());
    for(var map in maps){
      i++;
      cards.add(JudgementBean.fromMap(map));
      if(i==5){
        break;
      }
    }
    return cards;
  }
  

}
