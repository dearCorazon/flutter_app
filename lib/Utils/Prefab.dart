final String Columnnumber = 'number';
final String Columnstatus1 = 'status1';
final String Columnstatus2 = 'status2';
final String Columnstatus3 = 'status3';
final String Columnstatus4 = 'status4';
final String ColumnId = 'id';
final String ColumnAdderId = 'adderId';
final String ColumnQuestion = 'question';
final String ColumnAnswer = 'answer';
final String ColumnType = 'type';
final String ColumnCatalogId = 'catalogId';
final String ColumnTagID = 'tag';
final String ColumnChaos = 'chaos';
final String Columnid = 'id';
final String Columnname = 'name';
final String ColumnsuperiorId = 'superiorId';
final String Columncards = 'cards';
final String ColumnTestId = 'testId';
final String ColumnsuperiorCatalogName = 'superiorCatalogName';
final String ColumnScheduleId = 'scheduleId';
final String ColumnUserId = 'userId';
final String ColumnStatus = 'status';
final String ColumnNextTime = 'nextTime';
final String ColumnFollowType = 'followType';
final String ColumnIsmark = 'ismark';
String getmemorytInfo(int status) {
  //TODO:整理的时候可能 处理统计信息的时候
  if (status <=0) {
    //陌生
    return "陌生";
  }
  if (status > 0 && status < 20) {
    //有点印象（30分钟 + 50分钟）
      return "有点印象";
  }
  if (status >= 20 && status <= 50) {
    //良好（+1天 + 2天）
  return "良好";
  }
  if (status > 50) {
    //熟悉（3天 5 天）
  return "熟悉";
  }
}
