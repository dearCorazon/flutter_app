import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/CardComplete.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsShowState.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:flutter_app/Utils/MemoryAlgorithm.dart';
import 'package:flutter_app/Widget/CardEdit.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';
import 'package:flutter_app/Utils/Prefab.dart';

class ShowSimpleCardFuture extends StatelessWidget {
  
  Memory memory = new Memory();
  //此处能获取到的数据为 cardsShowState 即当前显示的Test的信息
   Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: getCardswithSchedule(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return _getWidget(context, snapshot);
              }
            }));
  }
  Future<List<Test>> getTestswithScedule(BuildContext context) async {
    final cardsShowState = Provider.of<CardsShowState>(context);
    List<Test> tests;
    ScheduleDao scheduleDao = new ScheduleDao();
    tests = await scheduleDao.loadCardswithSchedule(
        cardsShowState.selectedCatalogId, 50);
    return tests;
  }

  Future<List<Test>> getTests(BuildContext context) async {
    final cardsShowState = Provider.of<CardsShowState>(context);
    List<Test> tests;
    TestDao testDao = new TestDao();
    tests =
        await testDao.queryListByCatalogId(cardsShowState.selectedCatalogId);
    return tests;
  }
//现在在用这个 在此函数中写进state 
  Future<List<CardComplete>> getCardswithSchedule(BuildContext context) async {
    final cardsShowState = Provider.of<CardsShowState>(context);
    List<CardComplete> cardCompletes;
    ScheduleDao scheduleDao = new ScheduleDao();
    cardCompletes = await scheduleDao.loadCardListwithSchedule(
        cardsShowState.selectedCatalogId, 50);
    return cardCompletes;
  }

  _changeCardShowState(BuildContext context, List<CardComplete> tests) {
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
    ScheduleDao scheduleDao = new ScheduleDao();
    final catalogState =Provider.of<CatalogState>(context);
    final cardsShowState = Provider.of<CardsShowState>(context);
    final TextEditingController statusController  = new TextEditingController(text:"0");
    
    //TODO:这里能拿到catalogID 就能显示 熟悉程度
    //TODO:点击后改变status
    List<CardComplete> tests = snapshot.data;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(tests[0].name), //catalogname
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.create),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>CardEdit(tests[cardsShowState.currentListIndex])
                ));
                

              },
            ),
            IconButton(
              icon: Icon(Icons.edit_attributes),
              onPressed:(){
                  showDialog<CardComplete>(
                    context:  context,
                    builder:  (BuildContext context){
                      return SimpleDialog(
                        title: Text("重设进度"),
                        children: <Widget>[
                          Text("当前进度为"),
                          Text("熟悉"),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "status:"
                            ),
                            controller:  statusController,
                            validator: (val)=>(val==null||val.isEmpty)? "请输入重设的status":null,
                            //initialValue: '0',
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (value)async{
                              await scheduleDao.updateStatusByScheduleId(tests[cardsShowState.currentListIndex].scheduleId, int.parse(value));
                              tests[cardsShowState.currentListIndex].status=int.parse(value);
                              //catalogState(cardsShowState.currentListIndex, tests[cardsShowState.currentListIndex]);
                              //TODO:还要改变外面的 所以这里 Streambuilder 的优势
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    }

                    
                  );
              },
            )

          ],
        ),
        drawer: Mydrawer(),
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child:  Text(tests[cardsShowState.currentListIndex].status.toString()),
              ),
             Expanded(
               child: Text(getmemorytInfo(tests[cardsShowState.currentListIndex].status)),
             ),
            ],),
            Divider(),
            Card(child: Text(tests[cardsShowState.currentListIndex].question)),
            Divider(),
            
            getHideAnswer(context, tests),
            
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: getButton(context, tests)),
            
          ],
        )),
      ),
    );
  }

  Widget getHideAnswer(BuildContext context, List<CardComplete> tests) {
    final cardsShowState = Provider.of<CardsShowState>(context);
    if (cardsShowState.isHide) {
      return Text("");
    } else {
      return Text(tests[cardsShowState.currentListIndex].answer);
    }
  }

  Widget getButton(BuildContext context, List<CardComplete> tests) {
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
            Expanded(
                          child: RaisedButton(
                child: Text("认识"),
                onPressed: () async {
                  //在meomory来处理 要拿到scheduleId 或者 testid
                  memory.pressButtonKnown(
                      tests[cardsShowState.currentListIndex].testId,
                      tests[cardsShowState.currentListIndex].scheduleId);
                  _changeCardShowState(context, tests);
                },
              ),
            ),
            Expanded(
                          child: RaisedButton(
                child: Text("不认识"),
                onPressed: () async {
                  memory.pressButtonUnKnown(
                      tests[cardsShowState.currentListIndex].testId,
                      tests[cardsShowState.currentListIndex].scheduleId);
                  _changeCardShowState(context, tests);
                },
              ),
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
//             ),R
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
