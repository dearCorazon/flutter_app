
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsShowState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:flutter_app/Utils/MemoryAlgorithm.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';
class ShowSimpleCardFuture extends StatelessWidget {
  Memory memory = new Memory();
  //此处能获取到的数据为 cardsShowState 即当前显示的Test的信息
  @override 
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getTestswithScedule(context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    //TODO；跳转闪烁 还有这里的重绘问题
                      // return new Center(
                      //   child: new CupertinoActivityIndicator()
                      // );
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        return _getWidget(context, snapshot);
                  }
  }
  )
  );
}

Future<List<Test>> getTestswithScedule(BuildContext context)async{
  final cardsShowState = Provider.of<CardsShowState>(context);
  List<Test> tests;
  ScheduleDao scheduleDao= new ScheduleDao();
  tests= await scheduleDao.loadCardswithSchedule(cardsShowState.selectedCatalogId,50); 
  return tests;
}
Future<List<Test>> getTests(BuildContext context)async{
    final cardsShowState = Provider.of<CardsShowState>(context);
    List<Test> tests;
    TestDao testDao = new TestDao();
    tests=await testDao.queryListByCatalogId(cardsShowState.selectedCatalogId);
    return  tests;
}
_changeCardShowState(BuildContext context,List<Test> tests) {
  final cardsShowState = Provider.of<CardsShowState>(context);
  int length;
  if (tests == null) {
    length = 0;
  } else {
    length = tests.length;
  }
  // Logv.Logprint("currentTest:${cardsShowState.currentListIndex}:" +
  //     cardsShowState.currentList[cardsShowState.currentListIndex].question);
  //Logv.Logprint("in 显示答案Button：当前内容：${cardsShowState.currentList[cardsShowState.currentListIndex].toString()}");

  //Logv.Logprint("下一条显示的内容："+cardsShowState.currentList[cardsShowState.currentListIndex].question);
  //Logv.Logprint("in 显示答案 CurrentListIndex：${cardsShowState.currentListIndex}");
  if (cardsShowState.currentListIndex + 1 == length) {
    Navigator.pop(context);
  } else {
    cardsShowState.addCurrentListIndex();
  }
  cardsShowState.changeFirstButton();
}

Widget _getWidget(BuildContext context, AsyncSnapshot snapshot) {
  final cardsShowState = Provider.of<CardsShowState>(context);
  //TODO:这里能拿到catalogID 就能显示 熟悉程度
  //TODO:点击后改变status
  List<Test> tests = snapshot.data;
  return 
    Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(""), //catalogname
                  actions: <Widget>[
                    Text("catalog"),
                    RaisedButton(
                      child: Text("白板"),
                    ),
                    RaisedButton(
                      child: Text("清除"),
                    ),
                    IconButton(
                      icon: Icon(Icons.collections),
                      onPressed: () {
                        //和Schedule有关，收藏
                      },
                    ),
                    Text("menu"), //TODO:做成下拉菜单
                  ],
                ),
                drawer: Mydrawer(),
                body: Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text("1"),
                          Text("2"),
                          Text("3"),
                          Text("time machine"),
                        ],
                      ),
                    ),
                    Text(tests[cardsShowState.currentListIndex].question),
                    getHideAnswer(context,tests),
                    getButton(context,tests),
                  ],
                )),
              ),
            );
}

Widget getHideAnswer(BuildContext context,List<Test> tests) {
  final cardsShowState = Provider.of<CardsShowState>(context);
  if (cardsShowState.isHide) {
    return Text("");
  } else {
    return Text(tests[cardsShowState.currentListIndex].answer);
  }
}

Widget getButton(BuildContext context,List<Test> tests) {
  final cardsShowState = Provider.of<CardsShowState>(context);
  if (cardsShowState.firstButton) {
    return RaisedButton(
      child: Text("显示答案"),
      onPressed: () async {
        cardsShowState.changeFirstButton();
      },
    );
  } else {
    return Container(
      child: Row(
        children: <Widget>[
          RaisedButton(
            child: Text("认识"),
            onPressed: () async {
              //在meomory来处理 要拿到scheduleId 或者 testid
               memory.pressButtonKnown(tests[cardsShowState.currentListIndex].id);
              _changeCardShowState(context,tests);
              

            },
          ),
          RaisedButton(
            child: Text("不认识"),
            onPressed: () async {
               memory.pressButtonUnKnown(tests[cardsShowState.currentListIndex].id);
              _changeCardShowState(context,tests);
            },
          )
        ],
      ),
    );
  }
}
}
// class ShowSimpleCard extends StatelessWidget {
//   //此处能获取到的数据为 cardsShowState 即当前显示的Test的信息
//   @override
//   Widget build(BuildContext context) {
//     final cardsShowState = Provider.of<CardsShowState>(context);
//     _changeCardShowState() {
//       int length;
//       if (cardsShowState.currentList== null) {
//         length = 0;
//       } else {
//         length = cardsShowState.currentList.length;
//       }
//       Logv.Logprint("currentTest:${cardsShowState.currentListIndex}:" +
//           cardsShowState
//               .currentListWithSchedule[cardsShowState.currentListIndex]
//               .question);
//       //Logv.Logprint("in 显示答案Button：当前内容：${cardsShowState.currentList[cardsShowState.currentListIndex].toString()}");

//       //Logv.Logprint("下一条显示的内容："+cardsShowState.currentList[cardsShowState.currentListIndex].question);
//       //Logv.Logprint("in 显示答案 CurrentListIndex：${cardsShowState.currentListIndex}");
//       if (cardsShowState.currentListIndex + 1 == length) {
//         Navigator.pop(context);
//       } else {
//         cardsShowState.addCurrentListIndex();
//       }
//       cardsShowState.changeFirstButton();
//     }

//     Widget getHideAnswer() {
//       if (cardsShowState.isHide) {
//         return Text("");
//       } else {
//         return Text(cardsShowState
//             .currentListWithSchedule[cardsShowState.currentListIndex].answer);
//       }
//     }

//     Widget getButton() {
//       if (cardsShowState.firstButton) {
//         return RaisedButton(
//           child: Text("显示答案"),
//           onPressed: () async {
//             cardsShowState.changeFirstButton();
//           },
//         );
//       } else {
//         return Container(
//           child: Row(
//             children: <Widget>[
//               RaisedButton(
//                 child: Text("认识"),
//                 onPressed: () {
//                   _changeCardShowState();
//                 },
//               ),
//               RaisedButton(
//                 child: Text("不认识"),
//                 onPressed: () {
//                   _changeCardShowState();
//                 },
//               )
//             ],
//           ),
//         );
//       }
//     }
//     // RaisedButton(
//     //   child: Text("显示答案"),
//     //   onPressed: (){

//     //   },
//     // ),

//     return Container(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(cardsShowState.selectedCatalogName), //catalogname
//           actions: <Widget>[
//             Text("catalog"),
//             RaisedButton(
//               child: Text("baiban"),
//             ),
//             RaisedButton(
//               child: Text("clear"),
//             ),
//             IconButton(
//               icon: Icon(Icons.collections),
//               onPressed: () {
//                 //和Schedule有关，收藏
//               },
//             ),
//             Text("menu"), //TODO:做成下拉菜单
//           ],
//         ),
//         drawer: Mydrawer(),
//         body: Container(
//             child: Column(
//           children: <Widget>[
//             Container(
//               child: Row(
//                 children: <Widget>[
//                   Text("1"),
//                   Text("2"),
//                   Text("3"),
//                   Text("time machine"),
//                 ],
//               ),
//             ),
//             Text(cardsShowState
//                 .currentListWithSchedule[cardsShowState.currentListIndex]
//                 .question),
//             // Text(cardsShowState.currentList[cardsShowState.currentListIndex].answer),
//             // Text("隐藏的答案"),
//             getHideAnswer(),
//             getButton(),
//           ],
//         )),
//       ),
//     );
//   }
// }