final String ColumnId='id';
final String ColumnTestId='testId';
final String ColumnUserId='userId';
final String ColumnStatus='status';
final String ColumnNextTime='nextTime';
final String ColumnFollowType='followType';
class Schedule{
  static final _sql_createTableSchedule='CREATE TABLE SCHEDULE(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,testID INTEGER,userID INTEGER,status INTEGER,nextTime TEXT,followType INTEGER)';
  int id;
  int testId;
  int userId;
  int status;
  int followType;
  String nextTime;
  Schedule.fromMap(Map<String,dynamic> map){
    id=map[ColumnId];
    testId=map[ColumnTestId];
    userId=map[ColumnUserId];
    status=map[ColumnStatus];
    followType=map[ColumnFollowType];
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
}