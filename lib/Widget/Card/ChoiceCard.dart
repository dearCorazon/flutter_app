import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/Bloc/ChoiceBloc.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/ChoiceState.dart';
import 'package:provider/provider.dart';

class ChoiceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final choiceState = Provider.of<ChoiceState>(context);
    final choiceBloc = Provider.of<ChoiceBloc>(context);
    return Container(
        child: Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text("确定"),
            onPressed: () {
              if(isToEnd(context)){
                //TODO:退出时会红屏一下
                Navigator.pop(context);
              }
              if (choiceState.isTrue == true) {
                Logv.Logprint("正确");
                choiceState.ShowIcon();
                choiceBloc.addIndex();
              } else {
                Logv.Logprint("错误");
                choiceBloc.addIndex();
              }
              Logv.Logprint("现在显示正确与错误的答案：${choiceState.isShowIcon}");
            },
          )
        ],
      ),
      body: StreamBuilder<List<ChoiceCardBean>>(
          initialData: Provider.of<ChoiceBloc>(context).card,
          stream: Provider.of<ChoiceBloc>(context).stream,
          builder: (context, snapshot) {
            return Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("单选"),
                      Text("${choiceBloc.index + 1}/${choiceBloc.card.length}"),
                    ],
                  ),
                  Card(
                      child: Text(
                    snapshot.data[choiceBloc.index].question,
                    softWrap: true,
                  )),
                 
                  Expanded(
                      child: Column(
                    children: <Widget>[],
                  )),
                  ChooseBar(snapshot),
                  showIcon(context),
                  RaisedButton(
                    child: Text('显示'),
                    onPressed: () {
                      choiceState.show();
                      choiceBloc.addIndex();
                    },
                  ),
                  Container(child: Answer1()),
                  
                ],
              ),
            );
          }),
    ));
  }
}
bool isToEnd(BuildContext context){
  final choiceState = Provider.of<ChoiceState>(context);
  final choiceBloc = Provider.of<ChoiceBloc>(context);
  int length = choiceBloc.card.length;
  if(choiceBloc.index==length-1){
    return true;
  }
  else{
    return false;
  }
  
}
class ChooseBar extends StatelessWidget {
  AsyncSnapshot<List<ChoiceCardBean>> snapshot;
  ChooseBar(this.snapshot);

  @override
  Widget build(BuildContext context) {
    final choiceState = Provider.of<ChoiceState>(context);
    final choiceBloc = Provider.of<ChoiceBloc>(context);
    return Container(
      child: Container(
        child: Column(
          children: <Widget>[
            RadioListTile(
              groupValue: choiceState.grop_value,
              value: 1,
             // secondary: showIcon(context),
              title: Text(snapshot.data[choiceBloc.index].chaos1),
              onChanged: (value) {
                choiceState.updateGroupValue(value);
                if (snapshot.data[choiceBloc.index].chaos1 ==
                    snapshot.data[choiceBloc.index].answer) {
                  
                  choiceState.trueAnswer();
                } else {
                  choiceState.fault();
                }
              },
            ),
            RadioListTile(
              groupValue: choiceState.grop_value,
              value: 2,
              //secondary: showIcon(context),
              title: Text(snapshot.data[choiceBloc.index].chaos2),
              onChanged: (value) {
                choiceState.updateGroupValue(value);
                if (snapshot.data[choiceBloc.index].chaos2 ==
                    snapshot.data[choiceBloc.index].answer) {
                  choiceState.trueAnswer();
                } else {
                  choiceState.fault();
                }
              },
            ),
            RadioListTile(
              //secondary: showIcon(context),
              groupValue: choiceState.grop_value,
              value: 3,
              title: Text(snapshot.data[choiceBloc.index].chaos3),
              onChanged: (value) {
                choiceState.updateGroupValue(value);
                if (snapshot.data[choiceBloc.index].chaos3 ==
                    snapshot.data[choiceBloc.index].answer) {
                  choiceState.trueAnswer();
                } else {
                  choiceState.fault();
                }
              },
            ),
            RadioListTile(
              //secondary: showIcon(context),
              groupValue: choiceState.grop_value,
              value: 4,
              title: Text(snapshot.data[choiceBloc.index].chaos4),
              onChanged: (value) {
                choiceState.updateGroupValue(value);
                if (snapshot.data[choiceBloc.index].chaos4 ==
                    snapshot.data[choiceBloc.index].answer) {
                  choiceState.trueAnswer();
                } else {
                  choiceState.fault();
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
