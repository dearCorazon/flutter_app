import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsAddState.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:provider/provider.dart';

class SimpleCard extends StatelessWidget {
  TextEditingController questionController = new TextEditingController(); 
  TextEditingController answerController = new TextEditingController();
  TestDao testDao = new TestDao();

  @override
  Widget build(BuildContext context) {
    final cardAddState = Provider.of<CardsAddState>(context);
    final dropDownMenuState = Provider.of<DropDownMenuState>(context);

    return Container(
      child:
      Column(
        children: <Widget>[
          TextField(
            controller: questionController,
            // onSubmitted: (text){
            //   cardAddState.loadQuestion(text);  
            // },
            
          ),
          TextFormField(
            // onEditingComplete: (){
            //   cardAddState.loadAnswer(answerController.text);
            // },
            controller: answerController,
          ),
          RaisedButton(
            child: Text("添加"),
            onPressed: ()async{
              Test test = new Test.createWithCatalog(questionController.text, answerController.text, dropDownMenuState.catalogId);
              testDao.insert(test);
              Logv.Logprint("question:"+questionController.text);              
              Logv.Logprint("answer:"+answerController.text);
              Logv.Logprint("catalog ID:${dropDownMenuState.catalogId}");
              
              //TODO:bug2 输入法消失时 TextField会重置  
              //TODO:here is a bug 当添加时 必须要选一次目录 才有效 否则catalogid为空，所以要设置默认的catalogId，并且要考虑到 该下拉菜单 有不同情况的复用
              //await testDao.insert(Test.createWithCatalog(questionController.text, answerController.text,dropDownMenuState.catalogId));
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }
}

class ChoiceQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
        children: <Widget>[
          TextFormField(),
            TextFormField(),
          TextFormField(),
        ],
      )
              
    );
  }
}
