import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/MutiChoiceBean.dart';
import 'package:flutter_app/Bloc/ChoiceBloc.dart';
import 'package:flutter_app/Bloc/MutiBloc.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/ChoiceState.dart';
import 'package:provider/provider.dart';

class MutiChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO:都不选的时候没有处理
    final choiceState = Provider.of<ChoiceState>(context);
    final choiceBloc = Provider.of<ChoiceBloc>(context);
    final mutiBloc = Provider.of<MutiBloc>(context);
    return Container(
        child: Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text("确定"),
            onPressed: () {
              String answer = mutiBloc.getanswer();
              Logv.Logprint("answer:"+answer);
              bool isRight= mutiBloc.checkAnswer();
              if(isRight){
                print('正确');
                mutiBloc.addIndex();
                mutiBloc.refreshIndex();
              }
              else{
                mutiBloc.showAnswer();
                print('错误！ 正确答案为${mutiBloc.card[mutiBloc.index].answer}');
              }
              mutiBloc.showIcon();
            },
          )
        ],
      ),
      body: StreamBuilder<List<MutiChoiceBean>>(
          initialData: Provider.of<MutiBloc>(context).card,
          stream: Provider.of<MutiBloc>(context).stream,
          builder: (context, snapshot) {
            return Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("单选"),
                      Text("${mutiBloc.index + 1}/${mutiBloc.card.length}"),
                    ],
                  ),
                  Card(
                    child: Text(
                    snapshot.data[choiceBloc.index].question,
                    softWrap: true,
                  )),
                  rightAnswer(context),
                  Choosebar(snapshot),
                  isRightIcon(context),
                ],
              ),
            );
          }),
    ));
  }
}
Widget isRightIcon(BuildContext context){
  final mutiBloc = Provider.of<MutiBloc>(context);
  return Container(
    child:Offstage(
      offstage: mutiBloc.isHideIcon,
      child: FloatingActionButton.extended(
        icon: mutiBloc.checkAnswer()? Icon(Icons.check): Icon(Icons.invert_colors_off),
        label:Text("下一题"),
        onPressed: (){
          mutiBloc.addIndex();
          mutiBloc.hideAnswer();
          mutiBloc.hideIcon();
          mutiBloc.refreshselected();
        },
      ),
    ),
  );
}
Widget rightAnswer(BuildContext context){
  final mutiBloc = Provider.of<MutiBloc>(context);
  return Container(
    child: Offstage(
      offstage: mutiBloc.ishideAnswer,
      child: Card(
        child: ListTile(
          title: Text('错误！ 正确答案为${mutiBloc.card[mutiBloc.index].answer}',style: TextStyle(color: Colors.red),),
        ),
      ),
      
),
  );
  
}
bool isToEnd(BuildContext context) {
  final choiceState = Provider.of<ChoiceState>(context);
  final choiceBloc = Provider.of<ChoiceBloc>(context);
  int length = choiceBloc.card.length;
  if (choiceBloc.index == length - 1) {
    return true;
  } else {
    return false;
  }
}


class Choosebar extends StatelessWidget {
  AsyncSnapshot<List<MutiChoiceBean>> snapshot;
  Choosebar(this.snapshot);

  @override
  Widget build(BuildContext context) {
    final choiceState = Provider.of<ChoiceState>(context);
    final choiceBloc = Provider.of<ChoiceBloc>(context);
    final mutiBloc = Provider.of<MutiBloc>(context);
    return Container(
      child: Container(
        child: Card(
                  child: Column(
            children: <Widget>[
              CheckboxListTile(
                value: mutiBloc.isSelectedA,
                // secovndary: showIcon(context),
                title: Text(snapshot.data[choiceBloc.index].chaos1),
                onChanged: (value) {
                  mutiBloc.updateA();
                },
              ),
              CheckboxListTile(
                value: mutiBloc.isSelectedB,
                //secondary: showIcon(context),
                title: Text(snapshot.data[choiceBloc.index].chaos2),
                onChanged: (value) {
                  mutiBloc.updateB();
                },
              ),
              CheckboxListTile(
                value: mutiBloc.isSelectedC,
                title: Text(snapshot.data[choiceBloc.index].chaos3),
                onChanged: (value) {
                  mutiBloc.updateC();
                },
              ),
              CheckboxListTile(
                value: mutiBloc.isSelectedD,
                title: Text(snapshot.data[choiceBloc.index].chaos4),
                onChanged: (value) {
                  mutiBloc.updateD();
                },
              )
            ],
          ),
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


Color changeColor(Color color) {
  if (color == Colors.black) {
    return Colors.green;
  } else {
    return Colors.black;
  }
}
