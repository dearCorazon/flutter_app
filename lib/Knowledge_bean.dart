import 'package:flutter_app/DAO/Sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';
final String ColumnContent ='content';
final String ColumnId ='id';
final String ColumnStatus='status';
final String ColumnSuperiorId='superiorid';
final String ColumnUserID='userid';
//final String
class Knowledge_bean{
  String content;
  int status;
  int id;
  int superiorId;
  int userId;
  Knowledge_bean( String content) {
     this.status = 0;
     this.superiorId = 0;
     this.content = content;
     this.userId =-1;
   }
   Knowledge_bean.fromMap(Map<String, dynamic> map){
    id=map[ColumnId];
    status=map[ColumnStatus];
    superiorId=map[ColumnSuperiorId];
    content=map[ColumnContent];
    userId=map[ColumnUserID];
   }
   Map<String ,dynamic> toMap(){
    var map =<String,dynamic>{
      ColumnContent:content,
      ColumnSuperiorId:superiorId,
      ColumnStatus:status,
      ColumnId:id,
      ColumnUserID:userId
    };
    return map;
   }

}
class KnowledgeSqlite{
  Database _database;
  Sqlite_helper _sqlite_helper;
  KnowledgeSqlite(){
    _sqlite_helper =new Sqlite_helper();
    //_sqlite_helper.initDatabase();
    //_database =_sqlite_helper.getDatabase();
  }
  void init()async{
    _sqlite_helper = new Sqlite_helper();
    //await _sqlite_helper.initDatabase();
//    _database= await _sqlite_helper.getDatabase();
    print(_database.isOpen.toString());
  }
  Future<Knowledge_bean> insert(Knowledge_bean knowledge)async{
   await  init();
   print("Logv  :isOpen?");
   print(_database.isOpen);
   knowledge.id= await _database.insert("knowledge", knowledge.toMap());
   print("knowledge:id ：");
   print(knowledge.content);
    return knowledge;
  }
  Future<void> update_status(int id)async{
    //TODO:如果需要改成直接修改status的函数，就修改这个，else 就删除
    //await init();
    int status =await query_status(id);
    print("修改前Status：$status");
    String sql='UPDATE knowledge SET status = ?  WHERE id = ? ';
    status++;
    print("status应为：$status");
    int count = await _database.rawUpdate(sql,[status ,id]);
    status=await query_status(id);
    print("修改后Status：$status");
}
  Future<void> status_add(int id,bool add)async{
    int status =await query_status(id);
    print("修改前Status：$status");
    String sql='UPDATE knowledge SET status = ?  WHERE id = ? ';
    if(add){status++;}
    else{
      status--;
    }
    print("status应为：$status");
    int count = await _database.rawUpdate(sql,[status ,id]);
    status=await query_status(id);
    print("修改后Status：$status");
  }
  Future<int> query_status(int id)async{
    int status;
    await init();
    List<Knowledge_bean> knowledges =[];
    String sql= 'select * from knowledge where id = ?';
    List<Map> maps = await _database.rawQuery(sql,[id]);
    if(maps == null ||maps.length == 0){
      return null;
    }
    for(int i =0 ;i< maps.length;i++){
      knowledges.add(Knowledge_bean.fromMap(maps[i]));
    }
    status= knowledges.first.status;
    print("status=$status");
    return status;


  }
  Future<List<Knowledge_bean>> query(int id) async{
    List<Knowledge_bean> knowledges =[];
    String sql= 'select * from knowledge where id = ?';
    await init();
    List<Map> maps = await _database.rawQuery(sql,[id]);
    if(maps == null ||maps.length == 0){
      return null;
    }
    for(int i =0 ;i< maps.length;i++){
      knowledges.add(Knowledge_bean.fromMap(maps[i]));
    }
    return knowledges;
  }
  Future<List<Knowledge_bean>> queryAll() async{
    await init();
    List<Map> maps = await _database.query("knowledge",columns: [
      ColumnId,ColumnStatus,ColumnSuperiorId,ColumnContent,ColumnUserID
    ]);
    if(maps == null ||maps.length == 0){
      return null;
    }
    List<Knowledge_bean> knowledges =[];
    for(int i =0 ;i< maps.length;i++){
      knowledges.add(Knowledge_bean.fromMap(maps[i]));
    }
    return knowledges;
  }



}