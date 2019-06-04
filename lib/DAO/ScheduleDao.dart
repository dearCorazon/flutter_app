import 'package:flutter_app/Bean/CardComplete.dart';
import 'package:flutter_app/Bean/CatalogExtra.dart';
import 'package:flutter_app/Bean/CatalogStatusNumbers.dart';
import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/Sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/Log.dart';

class ScheduleDao {
  static final _databasename = 'mydatabase';
  static final _databaseVersion = 1;
  String table = "schedule";
  Database _database;
  String _path;
  //static final _sql_createTableSchedule2='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(testID,userID))';
  Future<void> _open() async {
    //TODO：可以组建一个超级类 拉通存储就会方便许多
    _database = await Sqlite_helper.instance.database;
    // Directory documentaryDirectory = await getApplicationDocumentsDirectory();
    // print("logv:documentaryDiretory"+documentaryDirectory.toString());
    // _path = join(documentaryDirectory.path,_databasename);
    // print("logv:_path:"+_path);
    // database=await openDatabase(_path,version: _databaseVersion);
    // Logv.Logprint("database open? "+database.isOpen.toString());
  }

  Future<List<Map>> fetchDataByCatalog(int catalogId) async {
    //static final _sql_createTableSchedule2='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(testID,userID))';
    //String sql2="select test.id as id,test.question,test.answer,test.type,test.catalogId,test.tag,test.chaos from test,catalog where test.catalogid=$id and test.catalogid=catalog.id";
    String sql =
        'select test.id,test.question,test.answer,test.type,test.catalogId,test.tag,test.chaos,schedule.status,schedule.nextTime,schedule.ismark from test,schedule where test.catalogId=$catalogId and schedule.testid=test.id';
    await _open();
    List<Map> maps = await _database.rawQuery(sql);
    return maps;
  }

  Future<List<Map>> fetchCardsCompleteByCatalog(int catalogId) async {
    //TODO :可能为空 如果灭有数据的话
    String sql =
        'select test.id as testId,adderId,question,answer,type,test.tag,test.chaos,test.catalogId as catalogId,catalog.name,superiorId,schedule.id as scheduleId,schedule.testId,schedule.status,schedule.nextTime,schedule.ismark from test,schedule,catalog where  test.catalogId=$catalogId and test.catalogId=catalog.id and schedule.testid=test.id and catalog.id=test.catalogId order by status asc';
    //static final _sql_createTableSchedule2='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,testId INTEGER,userId INTEGER,status INTEGER,nextTime TEXT,followType INTEGER,ismark INTEGER,UNIQUE(testID,userID))';
    //String sql2="select test.id as id,test.question,test.answer,test.type,test.catalogId,test.tag,test.chaos from test,catalog where test.catalogid=$id and test.catalogid=catalog.id";
    //String sql='select test.id,test.question,test.answer,test.type,test.catalogId,test.tag,test.chaos,schedule.status,schedule.nextTime,schedule.ismark from test,schedule where test.catalogId=$catalogId and schedule.testid=test.id';
    await _open();
    List<Map> maps = await _database.rawQuery(sql);
    Logv.Logprint(
        "in  fetchCardsCompleteByCatalog++++++++++++++++++++++++++++++++++++++++++++++++/n" +
            maps.toString());
    return maps;
  }
  Future<List<CardComplete>> fetchCardComletesByCatalogId(int catalogId)async{
    await _open();
    String sql =
        'select test.id as testId,adderId,question,answer,type,test.tag,test.chaos,test.catalogId as catalogId,catalog.name,superiorId,schedule.id as scheduleId,schedule.testId,schedule.status,schedule.nextTime,schedule.ismark from test,schedule,catalog where test.catalogId=catalog.id and schedule.testid=test.id and catalog.id=test.catalogId  and catalog.id=$catalogId';
    List<Map> maps = await _database.rawQuery(sql);
    Logv.Logprint(maps.toString());
    List<CardComplete> cardComletes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cardComletes.add(CardComplete.fromMap(maps[i]));
      }
      //await database.close();
      return cardComletes;
    } else {
      Logv.Logprint("in ScheduleDaofetchCardCompletrAll() no maps");
    }
 
  }
  Future<List<CardComplete>> fetchCardComletesByCatalogName(String catalogName)async{
    
    await _open();
    CatalogDao catalogDao = new CatalogDao();
    if(catalogName=='全部'){
      return await fetchCardCompletesAll();
    }
    int catalogId = await catalogDao.getIdByName(catalogName);
    String sql ='select test.id as testId,adderId,question,answer,type,test.tag,test.chaos,test.catalogId as catalogId,catalog.name,superiorId,schedule.id as scheduleId,schedule.testId,schedule.status,schedule.nextTime,schedule.ismark from test,schedule,catalog where test.catalogId=catalog.id and schedule.testid=test.id and catalog.id=test.catalogId  and catalog.id=$catalogId';
    List<Map> maps = await _database.rawQuery(sql);
    Logv.Logprint(maps.toString());
    List<CardComplete> cardComletes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cardComletes.add(CardComplete.fromMap(maps[i]));
      }
      //await database.close();
      return cardComletes;
    } else {
      Logv.Logprint("in ScheduleDao.fetchCardComletesByCatalogName() no maps");
    }
 
  }

  Future<List<CardComplete>> fetchCardCompletesAll() async {
    //order by status
    await _open();
    String sql =
        'select test.id as testId,adderId,question,answer,type,test.tag,test.chaos,test.catalogId as catalogId,catalog.name,superiorId,schedule.id as scheduleId,schedule.testId,schedule.status,schedule.nextTime,schedule.ismark from test,schedule,catalog where test.catalogId=catalog.id and schedule.testid=test.id and catalog.id=test.catalogId ';
    List<Map> maps = await _database.rawQuery(sql);
    Logv.Logprint(maps.toString());
    List<CardComplete> cardComletes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        cardComletes.add(CardComplete.fromMap(maps[i]));
      }
      //await database.close();
      return cardComletes;
    } else {
      Logv.Logprint("in ScheduleDaofetchCardCompletrAll() no maps");
    }
  }

  // Future<void> delete(int catalogId)async{
  //   await _open();
  //   //String sql1 ='delete  from test,schedule where schedule.testId=test.id and test.id = test.catalogId and test.catalogId=$catalogId';
  //   String sql2 ='delete  from test where test.catalogId = $catalogId';
  //   String sql3= 'delete from catalog where id= $catalogId';
  //   int result2= await  _database.rawDelete(sql2);
  //   int result3 = await  _database.rawDelete(sql3);
  //    //await  _database.rawDelete(sql3);
  //   Logv.Logprint("删除test表$result2 行 删除目录表$result3 行");
  // }
  Future<int> getScheduleIdTestIdByTestId(int testId) async {
    await _open();
    final String sql =
        'select schedule.id from test,schedule where schedule.testId=test.id';
    List<Map> maps = await _database.rawQuery(sql);
    Logv.Logprint("getScheduleIdTestIdByTestId" + maps.toString());
    if (maps != null) {
      int result = int.parse(maps.first['id'].toString());
      return result;
    }
  }

  Future<List<Test>> loadCardswithSchedule(int catalogId, int length) async {
    int count = 0;
    List<Map> maps = await fetchDataByCatalog(catalogId);
    List<Map> newmaps = [];
    for (var map in maps) {
      String datatimeString = map['nextTime'];
      //Logv.Logprint("timeString :"+datatimeString);
      DateTime datetime = DateTime.parse(datatimeString);
      if (!datetime.isAfter(DateTime.now())) {
        //Logv.Logprint("pick" + test.id.toString() + test.question);
        newmaps.add(map);
        //Logv.Logprint("length:"+currentListWithSchedule.toString());
      }
    }
    List<Test> newtests = [];
    for (var map in newmaps) {
      newtests.add(Test.fromMap(map));
      count++;
      if (count == length) {
        return newtests;
      }
    }
    return newtests;
  }

  Future<List<CardComplete>> loadCardListwithSchedule(
      int catalogId, int length) async {
    //TODO :可能为空
    int count = 0;
    List<Map> maps = await fetchCardsCompleteByCatalog(catalogId);
    List<Map> newmaps = [];
    for (var map in maps) {
      String datatimeString = map['nextTime'];
      //Logv.Logprint("loadCardListwithSchedule:map=====================---------------- \n"+map.toString());
      DateTime datetime = DateTime.parse(datatimeString);
      if (!datetime.isAfter(DateTime.now())) {
        //Logv.Logprint("pick" + test.id.toString() + test.question);
        newmaps.add(map);
        //Logv.Logprint("length:"+currentListWithSchedule.toString());
      }
    }
    List<CardComplete> cardsComplete = [];
    for (var map in newmaps) {
      cardsComplete.add(CardComplete.fromMap(map));
      count++;
      if (count == length) {
        return cardsComplete;
      }
    }
    Logv.Logprint("in ScheduleDao.loadCardListwithSchedule $cardsComplete");
    return cardsComplete;
  }

  Future<List<Map>> queryAllStatus() async {
    await _open();
    final String sql =
        'select catalog.id,schedule.staus from schedule,catalog where catalog';
  }

  Future<int> updateStatusByScheduleId(int scheduleId, int newstatus) async {
    await _open();
    String sql = 'update schedule set status=$newstatus where id=$scheduleId';
    int result = await _database.rawUpdate(sql);
    Logv.Logprint("in updateStatusByScheduleId 影响行数$result");
    return result;
  }

  Future<int> addStatus(int scheduleId) async {
    await _open();
    int status = await getStatusBySchduleId(scheduleId);
    status++;
    String sql = 'update schedule set status=$status where id=$scheduleId';
    int result = await _database.rawUpdate(sql);
    Logv.Logprint("in addStatus 影响行数$result");
    return result;
  }

  Future<int> subStatus(int scheduleId) async {
    //TODO:在显示 showcards时显示当前status的值 并且显示属于那一档
    await _open();
    int status = await getStatusBySchduleId(scheduleId);
    status--;
    String sql = 'update schedule set status=$status where id=$scheduleId';
    int result = await _database.rawUpdate(sql);
    Logv.Logprint("in addStatus 影响行数$result");
    return result;
  }
  Future<List<CatalogExtra>> loadCatalogExtraList() async {
    //这里也需要一个超级大类
    await _open();
    CatalogDao catalogDao = new CatalogDao();
    String name;
    List<CatalogExtra> catalogExtras = [];
    List<int> ints = await catalogDao.fetcbAllCatalogId(); //取出所有的catalogId 在每个id下取出所有的
    for (var i in ints) {
      int status1 = 0;
      int status2 = 0;
      int status3 = 0;
      int status4 = 0;
      List<Map> maps_h = await fetchCardsCompleteByCatalog(i);
      //取出所有的List
      if (maps_h.isEmpty) {
        name = await catalogDao.getNamebyId(i);
        CatalogExtra catalogExtra =CatalogExtra.create(i, 0, 0, 0, 0, 0, name);
        catalogExtras.add(catalogExtra);
        Logv.Logprint("当前目录$name为空\n");
      } 
      else {
        //每次跑一个目录下的所有数据
        int number = 0;
        Logv.Logprint(
              "in loadCatalogExtraList() 当前maps:\n" + maps_h.toString());
        for (var map in maps_h) {
          
          int status = int.parse(map['status'].toString());
          name = map['name'];
          if (status <= 0) {
            status1++;
          }
          if (status > 0 && status < 20) {
            status2++;
          }
          if (status >= 20 && status <= 50) {
            status3++;
          }
          if (status > 50) {
            status4++;
          }
          number++;
          i = int.parse(map[ColumnCatalogId].toString());
        
          //catalogStatusNumbers.add(CatalogStatusNumbers.create(catalogId,number,status1,status2,status3,status4));
        }
        CatalogExtra catalogExtra =CatalogExtra.create(i, number, status1, status2, status3, status4, name);
        catalogExtras.add(catalogExtra);
        Logv.Logprint("这里显示每一个目录信息${catalogExtra.toString()}");
      }
      //Logv.Logprint("fetchDataByCatalog maps_h:\n" + maps_h.toString());

      //Logv.Logprint("in loadCatalogStatusNumbersList() 当前catalogStatusNumber:\n"+catalogStatusNumber.toString());
      // Logv.Logprint(
      //     "in loadCatalogStatusNumbersList() catalogStatusNumbers:\n" +
      //         catalogStatusNumber.toString());
    }
    Logv.Logprint("loadCatalogStatusNumbersList():catalogStatusNumbers" +
        catalogExtras.toString());
    return catalogExtras;
  }

//  Future<void> status_add(int id,bool add)async{
//    int status =await query_status(id);
//    print("修改前Status：$status");
//    String sql='UPDATE knowledge SET status = ?  WHERE id = ? ';
//    if(add){status++;}
//    else{
//      status--;
//    }
//    print("status应为：$status");
//    int count = await _database.rawUpdate(sql,[status ,id]);
//    status=await query_status(id);
//    print("修改后Status：$status");
//  }

  Future<List<CatalogStatusNumbers>> loadCatalogStatusNumbersList() async {
    //这里也需要一个超级大类
    await _open();
    CatalogDao catalogDao = new CatalogDao();
    String name;
    List<CatalogStatusNumbers> catalogStatusNumbers = [];
    List<int> ints = await catalogDao.fetcbAllCatalogId(); //取出所有的catalogId 在每个id下取出所有的
    for (var i in ints) {
      int status1 = 0;
      int status2 = 0;
      int status3 = 0;
      int status4 = 0;
      List<Map> maps_h = await fetchCardsCompleteByCatalog(i);
      //取出所有的List
      if (maps_h.isEmpty) {
        name = await catalogDao.getNamebyId(i);
        CatalogStatusNumbers catalogStatusNumber =CatalogStatusNumbers.create(i, 0, 0, 0, 0, 0, name);
        catalogStatusNumbers.add(catalogStatusNumber);
        Logv.Logprint("in maps_h ==NULL90909090909090909000000000000000000000000000000000000000000\n" + maps_h.toString());
      } 
      else {
        //每次跑一个目录下的所有数据
        int number = 0;
        Logv.Logprint(
              "in loadCatalogStatusNumbersList() 当前maps:\n" + maps_h.toString());
        for (var map in maps_h) {
          
          int status = int.parse(map['status'].toString());
          name = map['name'];
          if (status <= 0) {
            status1++;
          }
          if (status > 0 && status < 20) {
            status2++;
          }
          if (status >= 20 && status <= 50) {
            status3++;
          }
          if (status > 50) {
            status4++;
          }
          number++;
          i = int.parse(map[ColumnCatalogId].toString());
        
          //catalogStatusNumbers.add(CatalogStatusNumbers.create(catalogId,number,status1,status2,status3,status4));
        }
        CatalogStatusNumbers catalogStatusNumber =CatalogStatusNumbers.create(i, number, status1, status2, status3, status4, name);
        catalogStatusNumbers.add(catalogStatusNumber);
      }
     // Logv.Logprint("fetchDataByCatalogmaps_h:\n" + maps_h.toString());

      //Logv.Logprint("in loadCatalogStatusNumbersList() 当前catalogStatusNumber:\n"+catalogStatusNumber.toString());
      // Logv.Logprint(
      //     "in loadCatalogStatusNumbersList() catalogStatusNumbers:\n" +
      //         catalogStatusNumber.toString());
    }
    Logv.Logprint("loadCatalogStatusNumbersList():catalogStatusNumbers" +
        catalogStatusNumbers.toString());
    return catalogStatusNumbers;
  }

  Future<List<Map>> queryAll() async {
    await _open();
    String sql = 'select * from schedule';
    List<Map> maps = await _database.rawQuery(sql);
    return maps;
  }

  Future<int> insert(Schedule schedule) async {
    await _open();
    int result = await _database.insert(table, schedule.toMap());
    Logv.Logprint("result:" + result.toString());
    //await database.close();
    return result;
  }

  Future<int> getSceduleIdbyeTestId(int testId) async {
    await _open();
    final String sql =
        'select schedule.id from schedule,test where test.id=$testId and schedule.testid=test.id';
    List<Map> maps = await _database.rawQuery(sql);
    if (maps.length > 0) {
      Logv.Logprint("in scheduleDao.getSceduleIdbyeTestId:" + maps.toString());
      int result = int.parse(maps.first.values.elementAt(0).toString());
      Logv.Logprint(
          "in scheduleDao.getSceduleIdbyeTestId:" + result.toString());
      return result;
    } else {
      Logv.Logprint("in scheduleDao.getSceduleIdbyeTestId:no maps");
    }
  }

  Future<int> getStatusBySchduleId(int testId) async {
    final String sql =
        'select schedule.status from schedule,test where test.id=$testId and schedule.testid=test.id';
    await _open();
    List<Map> maps = await _database.rawQuery(sql);
    if (maps.length > 0) {
      Logv.Logprint("in scheduleDao.getStatusBySchduleId:" + maps.toString());
      int result = int.parse(maps.first.values.elementAt(0).toString());
      Logv.Logprint("in scheduleDao.getStatusBySchduleId:" + result.toString());
      return result;
    } else {
      Logv.Logprint("in scheduleDao.getStatusBySchduleId:no maps");
    }
  }

  Future<List<Map>> queryAllByCatalogId(int catalogId) async {
    List<Map> maps = await fetchDataByCatalog(catalogId);
    return maps;
  }

  Future<List<Map>> getStatusNumber() async {
    await _open(); //<0 0-20  without20-50 >50
    String sql =
        'select catalog.id,count(*) as number,count(case when status<0 then 1 else 0 end ) as status1,count(case when status between 0 and 20 then 1 else 0 end) as status2,count(case when status not between 20 and 50 then 1 else 0 end) as status3,count(case when status >50 then 1 else 0 end)as status4 from catalog,schedule,test where schedule.testId=test.id and test.catalogId=catalog.id group by catalog.id ';
    List<Map> maps = await _database.rawQuery(sql);
    return maps;
  }

  Future<List<Schedule>> queryAll2() async {
    List<Schedule> schedules = [];
    await _open();
    List<Map> maps = await _database.query(table, columns: [
      ColumnId,
      ColumnTestId,
      ColumnUserId,
      ColumnStatus,
      ColumnNextTime,
      ColumnFollowType
    ]);
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        schedules.add(Schedule.fromMap(maps[i]));
      }
      //await database.close();
      return schedules;
    }
    Logv.Logprint("error:no maps");
    //await database.close();
    return null;
  }

  Future<void> updateNexttime(String newtimeString, int id) async {
    await _open();
    String sql2 = 'UPDATE knowledge SET status = ?  WHERE id = ? ';
    final String sql =
        'UPDATE schedule SET nexttime = "$newtimeString"  WHERE id = $id ';
    int result = await _database.rawUpdate(sql);
    Logv.Logprint(
        "in Schedule updateNexttime , the number of changes made $result");
  }

  Future<Schedule> queryBytestId(int testId) async {
    await _open();
    final String sql =
        'select schedule.id,status,nexttime,ismark from test,schedule where test.id=$testId and schedule.testid=test.id ';
    //TODO: ismark 不知为何为空 应该已经解决了
    List<Map> maps = await _database.rawQuery(sql);
    Logv.Logprint("in Schedule queryBytestId ,maps=" + maps.toString());
    if (maps.length > 0) {
      Schedule schedule = Schedule.fromMap(maps.first);
      Logv.Logprint("in Schedule queryBytestId ,map=" + schedule.toString());
      //await database.close();
      return schedule;
    }
  }
}
