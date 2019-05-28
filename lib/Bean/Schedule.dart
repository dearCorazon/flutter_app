 
import 'Test.dart';
final String ColumnTestId='testId';
final String ColumnUserId='userId';
final String ColumnStatus='status';
final String ColumnNextTime='nextTime';
final String ColumnFollowType='followType';
final String ColumnIsmark='ismark';
class Schedule{
  //static final _sql_createTableSchedule='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,testID INTEGER,userID INTEGER,status INTEGER,nextTime TEXT,followType INTEGER)';
  int id;
  int testId;
  int userId;
  int status;
  int followType;
  String nextTime;
  int ismark;
  void set setstatus(int newstatus){
    status=newstatus;
    //nexttime=Datetime.
  }
  Schedule.create(int tid,int uid){
    this.testId=tid;
    this.userId=uid;
    status = 0;
    followType= -1;
    ismark=0;
    nextTime=DateTime.now().toIso8601String();
  }
  Schedule.fromMap(Map<String,dynamic> map){
    id=map[ColumnId];
    testId=map[ColumnTestId];
    userId=map[ColumnUserId];
    status=map[ColumnStatus];
    ismark=map[ColumnIsmark];
    followType=map[ColumnFollowType];//TODO:代表时否为错题 收藏 后期改
    nextTime=map[ColumnNextTime];
  }
  Map<String,dynamic> toMap(){
    var map =<String,dynamic>{
      ColumnId:id,
      ColumnUserId:userId,
      ColumnTestId:testId,
      ColumnStatus:status,
      ColumnFollowType:followType,
      ColumnNextTime:nextTime
    };
    return map;
  }
  @override
  String toString(){
    return "id=$id userId=${userId.toString()} Testid=${testId.toString()} status=$status nexttime=$nextTime isMarked=$ismark";
  }
}