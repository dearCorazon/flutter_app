import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/Bloc/ChoiceBloc.dart';
import 'package:flutter_app/Bloc/DropDownMenuBloc.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/ChoiceState.dart';
import 'package:provider/provider.dart';

class ChoiceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    final choiceBloc = Provider.of<ChoiceBloc>(context);
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/background.png'))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.star),
                color: choiceBloc.card[choiceBloc.index].star == 0
                    ? Colors.white
                    : Colors.brown,
                onPressed: () async {
                  if (choiceBloc.card[choiceBloc.index].star == 0) {
                    await choiceBloc.collect();
                  } else {
                    await choiceBloc.uncollect();
                  }
                },
              ),
              // Offstage(
              //   offstage: choiceBloc.isHideCheckButton,
              //   child: Container(
              //     margin: EdgeInsets.only(
              //         top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
              //     child: FlatButton(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8.0)),
              //       color: Colors.brown,
              //       child: Text(
              //         "确定",
              //         style: TextStyle(
              //             color: Colors.white, fontWeight: FontWeight.w600),
              //       ),
              //       onPressed: () async {
              //         if (choiceBloc.checkAnswer()) {
              //           Logv.Logprint("正确");
              //           await choiceBloc.rightAnswer();
              //         } else {
              //           choiceBloc.showAnswer();
              //           Logv.Logprint("错误 正确答案为✖");
              //           await choiceBloc.faultAnswer();
              //         }
              //         choiceBloc.showIcon();
              //         choiceBloc.hideCheckButton();
              //         choiceBloc.disableButtonTrue();
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
          body: StreamBuilder<List<ChoiceCardBean>>(
              initialData: Provider.of<ChoiceBloc>(context).card,
              stream: Provider.of<ChoiceBloc>(context).stream,
              builder: (context, snapshot) {
                return Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 40.0, bottom: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                JudgeCard(context, snapshot),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 20.0),
                                    child: ChooseBar(snapshot)),
                              ],
                            ),
                          ),
                        ),
                        // Expanded(
                        //     child: Column(
                        //   children: <Widget>[],
                        // )),
                        // ChooseBar(snapshot),
                        Container(
                          child: rightAnswer(context),
                        ),
                        Container(child: checkAnswer(context),),
                        Container(
                          child: isRightIcon(context),
                        ),
                        //showIcon(context),
                        // RaisedButton(
                        //   child: Text('显示'),
                        //   onPressed: () {
                        //     choiceState.show();
                        //     choiceBloc.addIndex();
                        //   },
                        // ),
                        Container(child: Answer1()),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}

Widget isRightIcon(BuildContext context) {
  final choiceBloc = Provider.of<ChoiceBloc>(context);
  final dropdowmenuBloc = Provider.of<DropDownMenuBloc>(context);
  return Container(
    child: Offstage(
      offstage: choiceBloc.isHideIcon,
      child: FloatingActionButton.extended(
        heroTag: 2,
        icon: choiceBloc.checkAnswer()
            ? Icon(Icons.check)
            : Icon(Icons.invert_colors_off),
        label: Text("下一题"),
        onPressed: () async {
          if (choiceBloc.isToEnd()) {
            choiceBloc.refreshAll();
            await dropdowmenuBloc.loadInformation();
            Navigator.pop(context);
          } else {
            choiceBloc.addIndex();
            choiceBloc.refreshWiget();
          }
        },
      ),
    ),
  );
}

Widget checkAnswer(BuildContext context) {
  final choiceBloc = Provider.of<ChoiceBloc>(context);
  return Offstage(
    offstage: choiceBloc.isHideCheckButton,
    child: Container(
      //margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: FloatingActionButton.extended(
        heroTag: 1,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
       // color: Colors.brown,
        label: Text('确定'),
        // child: Text(
        //   "确定",
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        // ),
        onPressed: () async {
          if (choiceBloc.checkAnswer()) {
            Logv.Logprint("正确");
            await choiceBloc.rightAnswer();
          } else {
            choiceBloc.showAnswer();
            Logv.Logprint("错误 正确答案为✖");
            await choiceBloc.faultAnswer();
          }
          choiceBloc.showIcon();
          choiceBloc.hideCheckButton();
          choiceBloc.disableButtonTrue();
        }, 
      ),
    ),
  );
}
// Offstage(
//               offstage: choiceBloc.isHideCheckButton,
//               child: Container(
//                 margin: EdgeInsets.only(
//                     top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
//                 child: FlatButton(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0)),
//                   color: Colors.brown,
//                   child: Text(
//                     "确定",
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                   onPressed: () async {
//                     if (choiceBloc.checkAnswer()) {
//                       Logv.Logprint("正确");
//                       await choiceBloc.rightAnswer();
//                     } else {
//                       choiceBloc.showAnswer();
//                       Logv.Logprint("错误 正确答案为✖");
//                       await choiceBloc.faultAnswer();
//                     }
//                     choiceBloc.showIcon();
//                     choiceBloc.hideCheckButton();
//                     choiceBloc.disableButtonTrue();
//                   },
//                 ),
//               ),
//             )

Widget rightAnswer(BuildContext context) {
  final choiceBloc = Provider.of<ChoiceBloc>(context);
  return Container(
    child: Offstage(
      offstage: choiceBloc.ishideAnswer,
      child: Card(
        child: ListTile(
          title: Text(
            '错误！ 正确答案为${choiceBloc.card[choiceBloc.index].answer}',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    ),
  );
}

Widget JudgeCard(
    BuildContext context, AsyncSnapshot<List<ChoiceCardBean>> snapshot) {
  final choiceBloc = Provider.of<ChoiceBloc>(context);
  return Container(
    child: Column(
      children: <Widget>[
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Text(
                    "单选题",
                    style: TextStyle(fontFamily: 'alifont'),
                  )),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${choiceBloc.index + 1}",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "/${choiceBloc.card.length}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
        ListTile(title: Text(snapshot.data[choiceBloc.index].question)),
      ],
    ),
  );
}

class ChooseBar extends StatelessWidget {
  AsyncSnapshot<List<ChoiceCardBean>> snapshot;
  ChooseBar(this.snapshot);

  @override
  Widget build(BuildContext context) {
    //final choiceState = Provider.of<ChoiceState>(context);
    final choiceBloc = Provider.of<ChoiceBloc>(context);
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            RadioListTile(
              groupValue: choiceBloc.grop_value,
              value: 1,
              // secondary: showIcon(context),
              title: Text(snapshot.data[choiceBloc.index].chaos1),
              onChanged: (value) {
                choiceBloc.updateGroupValue(value);
                if (snapshot.data[choiceBloc.index].chaos1 ==
                    snapshot.data[choiceBloc.index].answer) {
                  choiceBloc.trueAnswer();
                } else {
                  choiceBloc.fault();
                }
              },
            ),
            RadioListTile(
              groupValue: choiceBloc.grop_value,
              value: 2,
              //secondary: showIcon(context),
              title: Text(snapshot.data[choiceBloc.index].chaos2),
              onChanged: (value) {
                choiceBloc.updateGroupValue(value);
                if (snapshot.data[choiceBloc.index].chaos2 ==
                    snapshot.data[choiceBloc.index].answer) {
                  choiceBloc.trueAnswer();
                } else {
                  choiceBloc.fault();
                }
              },
            ),
            RadioListTile(
              //secondary: showIcon(context),
              groupValue: choiceBloc.grop_value,
              value: 3,
              title: Text(snapshot.data[choiceBloc.index].chaos3),
              onChanged: (value) {
                choiceBloc.updateGroupValue(value);
                if (snapshot.data[choiceBloc.index].chaos3 ==
                    snapshot.data[choiceBloc.index].answer) {
                  choiceBloc.trueAnswer();
                } else {
                  choiceBloc.fault();
                }
              },
            ),
            RadioListTile(
              //secondary: showIcon(context),
              groupValue: choiceBloc.grop_value,
              value: 4,
              title: Text(snapshot.data[choiceBloc.index].chaos4),
              onChanged: (value) {
                choiceBloc.updateGroupValue(value);
                if (snapshot.data[choiceBloc.index].chaos4 ==
                    snapshot.data[choiceBloc.index].answer) {
                  choiceBloc.trueAnswer();
                } else {
                  choiceBloc.fault();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget showIcon(BuildContext context) {
  final choiceState = Provider.of<ChoiceState>(context);
  return Offstage(
    offstage: choiceState.isShowIcon,
    child: choiceState.icon,
  );
}

class Answer1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final choiceState = Provider.of<ChoiceState>(context);
    return Offstage(
        offstage: choiceState.isShow,
        child: Card(
          child: Container(width: 300, height: 100, child: Text("答案")),
        ));
  }
}

class Answer extends StatefulWidget {
  Answer({Key key}) : super(key: key);
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  bool show = false;
  void showAnswer() {
    setState(() {
      show = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: show,
      child: Container(
        // key:  answerKey,
        child: Text("答案"),
      ),
    );
  }
}

class ChoiceBar extends StatelessWidget {
  const ChoiceBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choiceState = Provider.of<ChoiceState>(context);
    return Container(
      child: Column(
        children: <Widget>[
          ChoiceItem("A"),
          ChoiceItem("B"),
          ChoiceItem("C"),
          ChoiceItem("D"),
        ],
      ),
    );
  }
}

class ChoiceItem extends StatelessWidget {
  String name;
  ChoiceItem(this.name);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: ListTile(
          title: Text(
            name,
            style: TextStyle(),
          ),
        ),
      ),
    );
  }
}

class Choice extends StatefulWidget {
  String name;
  Choice(this.name);
  _ChoiceState createState() => _ChoiceState(name);
}

class _ChoiceState extends State<Choice> {
  String name;
  Color color = Colors.black;
  _ChoiceState(this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            color = changeColor(color);
          });
        },
        child: Card(
          child: ListTile(
            title: Text(
              name,
              style: TextStyle(color: color),
            ),
          ),
        ),
      ),
    );
  }
}

Color changeColor(Color color) {
  if (color == Colors.black) {
    return Colors.green;
  } else {
    return Colors.black;
  }
}
