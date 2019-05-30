import 'package:flutter_app/Utils/Prefab.dart';
class CardComplete{
  int testId;
  int adderId;
  String question;
  String answer;
  int type;
  int catalogId;
  String tag;//TODO:后期改为json
  String chaos;
  String name;//catalogname
  int superiorId;
  int scheduleId;
  int userId;
  int status;
  String nextTime;
  int ismark;
  String superiorCatalogName;
  CardComplete.create(
    this.testId,this.adderId,this.question,this.answer,this.type,this.catalogId,
    this.tag,this.chaos,this.name,this.superiorId,this.superiorCatalogName,
    this.scheduleId,this.userId,this.status,this.nextTime,this.ismark);
  CardComplete.fromMap(Map<String ,dynamic> map){
    testId=map[ColumnTestId];
    adderId=map[ColumnAdderId];
    question=map[ColumnQuestion];
    answer=map[ColumnAnswer];
    type=map[ColumnType];
    tag=map[ColumnTagID];
    chaos=map[ColumnChaos];
    catalogId=map[ColumnCatalogId];
    name=map[Columnname];
    superiorId=map[ColumnsuperiorId];
    //superiorCatalogName=[ColumnsuperiorCatalogName];
    scheduleId=map[ColumnScheduleId];
    testId=map[ColumnTestId];
    userId=map[ColumnUserId];
    status=map[ColumnStatus];
    ismark=map[ColumnIsmark];
    nextTime=map[ColumnNextTime];
  }
  Map<String ,dynamic> toMap(){
    var map =<String,dynamic>{
      ColumnTestId:testId,
      ColumnAdderId:adderId,
      ColumnQuestion:question,
      ColumnAnswer:answer,
      ColumnType:type,
      ColumnTagID:tag,
      ColumnChaos:chaos,
      ColumnCatalogId:catalogId,
      Columnname:name,
      ColumnsuperiorId:superiorId,
      ColumnScheduleId:scheduleId,
      ColumnUserId:userId,
      ColumnTestId:testId,
      ColumnStatus:status,
      ColumnNextTime:nextTime,
      ColumnIsmark:ismark
    };
    return map;
  }

  @override
  String toString(){
    return "testId:$testId,adderId:$adderId,question$question,answer:$answer,type:$type,tag:$tag,chaos:$chaos\n catalogId:$catalogId,name:$name,superiorId:$superiorId\n scheduleId:$scheduleId,testId:$testId,userId：$userId,status:$status,ismark:$ismark,nextTime:$nextTime";
  }
}