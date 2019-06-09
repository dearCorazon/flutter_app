import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Bean/Judgement.dart';
import 'package:flutter_app/Bloc/DropDownMenuBloc.dart';
import 'package:flutter_app/Bloc/JudgeBloc.dart';
import 'package:flutter_app/Bloc/WrongBookBloc.dart';
import 'package:flutter_app/Log.dart';
import 'package:provider/provider.dart';

class WJudge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('images/background.png'))
          //color: Colors.lightBlue[100]

          ),
      child: StreamBuilder<List<JudgementBean>>(
        initialData: Provider.of<WrongBookBloc>(context).judges,
        stream: Provider.of<WrongBookBloc>(context).judgeStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<JudgementBean>> snapshot) {
          final wrongbook = Provider.of<WrongBookBloc>(context);
          return 
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(

              backgroundColor: Colors.transparent,
              //toolbarOpacity: 0.0,
              actions: <Widget>[
              //   IconButton(
              //   icon: Icon(Icons.star),
              //   color: wrongbook.judges[wrongbook.index].star == 0
              //       ? Colors.white
              //       : Colors.brown,
              //   onPressed: () async {
              //     // if (wrongbook.judges[wrongbook.index].star == 0) {
              //     //   await wrongbook.collect();
              //     // } else {
              //     //   await wrongbook.uncollect();
              //     // }
              //   },
              // ),
                Offstage(
                  offstage: wrongbook.isHideCheckButton,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      color: Colors.brown,
                      child: Text(
                        "确定",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        if (wrongbook.checkAnswer()) {
                          Logv.Logprint("正确");
                          await wrongbook.rightAnswer();
                        } else {
                          wrongbook.showAnswer();
                          Logv.Logprint("错误 正确答案为✖");
                          await wrongbook.faultAnswer();
                        }
                        wrongbook.showIcon();
                        wrongbook.hideCheckButton();
                        wrongbook.disableButtonTrue();
                      },
                    ),
                  ),
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(color: Colors.transparent),
              margin: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 40.0, bottom: 20),
              // EdgeInsets.symmetric(horizontal: 20.0),
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
                                child: judgeBar(context)),
                          ],
                        ),
                      ),
                    ),
                    Container(child: rightAnswer(context)),
                    Container(child: isRightIcon(context)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


Widget JudgeCard(
    BuildContext context, AsyncSnapshot<List<JudgementBean>> snapshot) {
  final wrongBookBloc = Provider.of<WrongBookBloc>(context);
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
                    "判断题",
                    style: TextStyle(fontFamily: 'alifont'),
                  )),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${wrongBookBloc.index + 1}",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "/${wrongBookBloc.judges.length}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
        ListTile(title: Text(snapshot.data[wrongBookBloc.index].question)),
      ],
    ),
  );
}

Widget isRightIcon(BuildContext context) {
  final judgeBloc = Provider.of<WrongBookBloc>(context);
  final dropdowmenuBloc = Provider.of<DropDownMenuBloc>(context);

  return Container(
    child: Offstage(
      offstage: judgeBloc.isHideIcon,
      child: FloatingActionButton.extended(
        icon: judgeBloc.checkAnswer()
            ? Icon(Icons.check)
            : Icon(Icons.invert_colors_off),
        label: Text("下一题"),
        //TODO:找不到禁用按钮的方法
        // onPressed: judgeBloc.isButtomTrueDisabled?(){}:()=>_judge(),
        onPressed: () async {
          if (judgeBloc.isToEnd()) {
            judgeBloc.refreshAll();
            Logv.Logprint("in Judge${dropdowmenuBloc.chooseCatalogId}");
            await dropdowmenuBloc.loadInformation();
            Navigator.pop(context);
          } else {
            judgeBloc.refreshWiget();
            judgeBloc.addIndex();

            // judgeBloc.hideAnswer();
            // judgeBloc.hideIcon();
            // judgeBloc.refreshChoose();
            // judgeBloc.showCheckButton();
            // judgeBloc.refreshButtonDisable();
          }

          // judgeBloc.isButtomTrueDisabled? null :()=> _judge();
          // judgeBloc.addIndex();
          // judgeBloc.hideAnswer();
          // judgeBloc.hideIcon();
          // judgeBloc.refreshChoose();
          // judgeBloc.showCheckButton();
          // judgeBloc.refreshButtonDisable();
        },
      ),
    ),
  );
}

Widget judgeBar(BuildContext context) {
  final wrongBookBloc = Provider.of<WrongBookBloc>(context);
  return Container(
    child: Column(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text(
              "正确",
              style: TextStyle(color: wrongBookBloc.colorTrue),
            ),
            onTap: () {
              wrongBookBloc.isButtomTrueDisabled ? null : wrongBookBloc.tapTrue();
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              "错误",
              style: TextStyle(color: wrongBookBloc.colorFalse),
            ),
            onTap: () {
              wrongBookBloc.isButtomTrueDisabled ? null : wrongBookBloc.tapFalse();
            },
          ),
        )
      ],
    ),
  );
}

Widget rightAnswer(BuildContext context) {
  final wrongBookBloc = Provider.of<WrongBookBloc>(context);
  return Container(
    child: Offstage(
      offstage: wrongBookBloc.ishideAnswer,
      child: Card(
        child: ListTile(
          title: wrongBookBloc.checkAnswer()
              ? Text(
                  '错误 正确答案为✔',
                  style: TextStyle(color: Colors.red),
                )
              : Text(
                  '错误 正确答案为✖',
                  style: TextStyle(color: Colors.red),
                ),
        ),
      ),
    ),
  );
}
