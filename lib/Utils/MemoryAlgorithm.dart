import 'package:flutter_app/Bean/Schedule.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';

class Memory{
  Duration duration1day= new Duration(days: 1);
  Duration duration2days= new Duration(days: 2);
  Duration duration1minute= new Duration(minutes: 1);
  Duration duration2minutes= new Duration(minutes: 2);
  Duration duration5minutes= new Duration(minutes: 5);
  ScheduleDao scheduleDao = new ScheduleDao();

  
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
    //等级分为陌生  有点印象  良好 熟悉
    //当前算法为  如果 陌生 不认识：认识  （+3分钟  +2分钟 ）
    if(status<=0){//陌生
      newNextime=DateTime.parse(currentTimeString).add(duration1minute);
      newtimeString=newNextime.toIso8601String();
      await scheduleDao.updateNexttime(newtimeString, scheduleId);
      await scheduleDao.addStatus(scheduleId);
    }
    if(status>0&&status<20){//有点印象（30分钟 + 50分钟）
      newNextime=DateTime.parse(currentTimeString).add(duration2minutes);
      newtimeString=newNextime.toIso8601String();
      await scheduleDao.updateNexttime(newtimeString, scheduleId);
    }
    if(status>=20&&status<=50){//良好（+1天 + 2天）
      newNextime=DateTime.parse(currentTimeString).add(duration5minutes);
      newtimeString=newNextime.toIso8601String();
      await scheduleDao.updateNexttime(newtimeString, scheduleId);
    }
    if(status>50){//熟悉（3天 5 天）
      newNextime=DateTime.parse(currentTimeString).add(duration1day);
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
void pressButtonKnown(int testid,int scheduleId)async{
      //TODO：：11111111111111111111\
      await scheduleDao.addStatus(scheduleId);
      await addNextitme(testid);
      //await addStatus(testId);
      //add status 
      //scheduleDao.
    }
void pressButtonUnKnown(int testid,int scheduleId)async{
      await scheduleDao.subStatus(scheduleId);
      await addNextitme(testid);
    }
}