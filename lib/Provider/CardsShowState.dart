import 'package:flutter/widgets.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Log.dart';

class CardsShowState with ChangeNotifier {
  int lenthmax=50;
  CatalogDao catalogDao = new CatalogDao();
  TestDao testDao = new TestDao();
  //这部分的数据从CatalogList拿
  bool isHide = true; //
  bool firstButton = true; //true时 为显示答案按钮 false时 该改变状态按钮 并且点击后显示下一个
  int selectedCatalogId;
  int selcetedTagId;
  String selectedCatalogName;
  
  List<Test> currentList=  new List<Test>();
  List<Test> currentListWithSchedule = new List<Test>();
  int currentListIndex = 0;
  void refreshListIndex(){
     currentListIndex = 0;
     notifyListeners();
  }
  void setSelectedtId(int catalogId){
    selectedCatalogId = catalogId;
    notifyListeners();
    
  }
  void changeFirstButton() {
    isHide = !isHide;
    firstButton = !firstButton;
    notifyListeners();
  }
  void changeCardlegthMax(int newmax){
    lenthmax= newmax;
    notifyListeners();
  }

  void reloadCurrentListIndex() {
    currentListIndex = 0;
    notifyListeners();
  }

  void showAnswer() {
    isHide = false;
    notifyListeners();
  }

  void hideAnswer() {
    isHide = true;
    notifyListeners(); 
  }

  // void changeScheduleNextTime() async {
    
  // }
  // Future<void> loadCardListWithSchedule() async {
    
  //   //每次最多load50个
  //   int count = 0;
  //   if(currentList==null){
  //     return ;
  //   }
  //   currentListWithSchedule.clear();
  //   await currentList.forEach((test) async {
  //     String dateTime = await testDao.getDateTimebyId(test.id);
  //     //Logv.Logprint(dateTime);
  //     //Logv.Logprint("in loadCaloadCardListWithSchedule:");
  //     DateTime datetime = DateTime.parse(dateTime);
  //     if ( count <= lenthmax) {
  //       if ( !datetime.isAfter(DateTime.now())) {
  //         //await Logv.Logprint("pick" + test.id.toString() + test.question);
  //         currentListWithSchedule.add(test);
  //         count++;
  //         //Logv.Logprint(currentListWithSchedule.length.toString());
  //       }
  //     }
  //   });
  //   // Logv.Logprint("currentListWithSchedule in state:"+currentListWithSchedule.toString());
  // }

  // Future<void> loadCardList(int catalogId) async {
  //   //TODO:加入Schedule 时改进此算法
  //   currentList = await testDao.queryListByCatalogId(catalogId);
  //   notifyListeners();
  // }

  void addCurrentListIndex() {
    currentListIndex++;
    // if(currentListIndex == currentList.length-1){
    //    currentListIndex=0;
    // }
    // else {
    //   currentListIndex++;
    //   //TODO:当index为0 时退出 后面判断是否到底
    // }
    notifyListeners();
  }
  //   void changeCurrentCatalogNumber(String name)async{
  //
  //  if(name=='全部'){
  //    _currentNumber = await catalogDao.allCardNumber();
  //   _currentCardList= await testDao.queryAll();

  //  }else{
  //    _currentNumber=await catalogDao.getNumberbyName(name);
  //    _currentCardList=await testDao.queryListByName(name);
  //    catalogId= await catalogDao.getIdByName(name);
  //    Logv.Logprint("test State:ppppppppppppppppppppppppppp: "+ catalogId.toString());
  //  }
  //  await notifyListeners();
  // }
  void loadCatalogInformation(int catalogId, String name) {
    //TODO:暂时没有考虑为空的情况 （可能不会有空）
    this.selectedCatalogId = catalogId;
    selectedCatalogName = name;
    notifyListeners();
  }
}
