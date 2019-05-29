import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';

class Memory{
  Duration duration1day= new Duration(days: 1);
  Duration duration2days= new Duration(days: 2);
  Duration duration1minute= new Duration(minutes: 1);
  Duration duration2minutes= new Duration(minutes: 2);
  Duration duration5minutes= new Duration(minutes: 5);
  ScheduleDao scheduleDao = new ScheduleDao();
  void addStatus(int testId)async{
    Schedule schedule = await scheduleDao.queryBytestId(testId);

  }
  void subStatus(){}
  void addNextitme(int testId)async{
    //in showSimple 
    int scheduleId;
    String newtimeString;
    
    int status;
    Schedule schedule = await scheduleDao.queryBytestId(testId);
    scheduleId=schedule.id;
    status= schedule.status;
    String currentTimeString =schedule.nextTime;
    DateTime currenNexttime= DateTime.parse(currentTimeString);
    DateTime newNextime;
    if(status<0){
      newNextime=DateTime.parse(currentTimeString).add(duration1minute);
      newtimeString=newNextime.toIso8601String();
      await scheduleDao.updateNexttime(newtimeString, scheduleId);
    }
    if(status>0&&status<20){
      newNextime=DateTime.parse(currentTimeString).add(duration2minutes);
      newtimeString=newNextime.toIso8601String();
      await scheduleDao.updateNexttime(newtimeString, scheduleId);
    }
    if(status>20&&status<50){
      newNextime=DateTime.parse(currentTimeString).add(duration5minutes);
      newtimeString=newNextime.toIso8601String();
      await scheduleDao.updateNexttime(newtimeString, scheduleId);
    }
    if(status>50&&status<100){
      newNextime=DateTime.parse(currentTimeString).add(duration1day);
      newtimeString=newNextime.toIso8601String();
      await scheduleDao.updateNexttime(newtimeString, scheduleId);
    } 
    if(status>100){
      newNextime=DateTime.parse(currentTimeString).add(duration2days);
      newtimeString=newNextime.toIso8601String();
      await scheduleDao.updateNexttime(newtimeString, scheduleId);
    }
    // switch (status) {
    //   case <0:{break;}
    //   case 2:{break;}  
    //     break;
    //   default:
    // }
    
    //TODO:111111111111111111 
    //根据当前的状态
    // int status =await scheduleDao.getStatusBySchduleId(testId);
    // switch (status) {
    //   case <0:{ }
        
    //     break;
    //   default:
    // }
    // await scheduleDao.updateNexttime(newtimeString, scheduleId);

  }

}