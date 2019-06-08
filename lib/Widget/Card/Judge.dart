import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Judgement.dart';
import 'package:flutter_app/Bloc/JudgeBloc.dart';
import 'package:flutter_app/Log.dart';
import 'package:provider/provider.dart';

class Judge extends StatelessWidget {
  const Judge({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<JudgementBean>>(
        initialData: Provider.of<JudgeBloc>(context).card,
        stream: Provider.of<JudgeBloc>(context).stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<JudgementBean>> snapshot) {
          final judegBloc = Provider.of<JudgeBloc>(context);
          return Container(
            child: Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  Offstage(
                    offstage: judegBloc.isHideCheckButton,
                                      child: FlatButton(
                                        
                      child: Text("确定"),
                      onPressed: () {
                        if(judegBloc.checkAnswer()){
                          Logv.Logprint("正确");
                        }
                        else{
                          judegBloc.showAnswer();
                           Logv.Logprint("错误 正确答案为✖");
                        }
                        judegBloc.showIcon();
                        judegBloc.hideCheckButton();
                        judegBloc.disableButtonTrue();
                      
                      },
                    ),
                  )
                ],
              ),
              body: Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text("判断题"),
                            Text('${judegBloc.index+1}/${judegBloc.card.length}'),
                          ],
                        ),
                      ),
                      Divider(),
                      Text(snapshot.data[judegBloc.index].question),
                      rightAnswer(context),
                      judgeBar(context),
                      isRightIcon(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
Widget isRightIcon(BuildContext context){
  final judgeBloc = Provider.of<JudgeBloc>(context);
  _judge(){
     judgeBloc.addIndex();
    judgeBloc.hideAnswer();
          judgeBloc.hideIcon();
          judgeBloc.refreshChoose();
          judgeBloc.showCheckButton();
          judgeBloc.disableButtonTrue();
  }
  return Container(
    child:Offstage(
      offstage: judgeBloc.isHideIcon,
      child: FloatingActionButton.extended(
        icon: judgeBloc.checkAnswer()? Icon(Icons.check): Icon(Icons.invert_colors_off),
        label:Text("下一题"),
        //TODO:找不到禁用按钮的方法
       // onPressed: judgeBloc.isButtomTrueDisabled?(){}:()=>_judge(),
        onPressed: (){
          if(judgeBloc.isToEnd()){
             judgeBloc.refreshAll();
            Navigator.pop(context);
          }
          else{
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
  final judgeBloc = Provider.of<JudgeBloc>(context);
  return Container(
    child: Column(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text("正确",style: TextStyle(color: judgeBloc.colorTrue),),
            onTap: (){
              judgeBloc.isButtomTrueDisabled? null : judgeBloc.tapTrue();
              
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text("错误",style: TextStyle(color: judgeBloc.colorFalse),),
            onTap: (){
              judgeBloc.isButtomTrueDisabled? null : judgeBloc.tapFalse();
            },
          ),
        )
      ],
    ),
  );
}
Widget rightAnswer(BuildContext context){
  final judgeBloc = Provider.of<JudgeBloc>(context);
  return Container(
    child: Offstage(
      offstage: judgeBloc.ishideAnswer,
      child: Card(
        child: ListTile(
          title: judgeBloc.checkAnswer()?Text('错误 正确答案为✔',style: TextStyle(color: Colors.red),):Text('错误 正确答案为✖',style: TextStyle(color: Colors.red),),
        ),
      ),
      
),
  );
  
}