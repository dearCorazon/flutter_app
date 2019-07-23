import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/Bloc/CardsBloc.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsAddState.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:flutter_app/Utils/Reload.dart';
import 'package:provider/provider.dart';

class SimpleCard extends StatelessWidget {
  TextEditingController questionController = new TextEditingController(); 
  TextEditingController answerController = new TextEditingController();
  TestDao testDao = new TestDao();

  @override
  Widget build(BuildContext context) {
    final cardAddState = Provider.of<CardsAddState>(context);
    final dropDownMenuState = Provider.of<DropDownMenuState>(context);
    final cardsBloc= Provider.of<CardsBloc>(context);
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
               int catalogId= cardAddState.catalogId;
               Logv.Logprint("Test error $catalogId");
              Test test = new Test.createWithCatalog(questionController.text, answerController.text,3);
              int result = await testDao.insert(test);
              Logv.Logprint("插入成功了吗$result");
              Logv.Logprint("question:"+questionController.text);              
              Logv.Logprint("answer:"+answerController.text);
              //Logv.Logprint("catalog ID:${dropDownMenuState.catalogId}");
              await cardsBloc.loadCardCompleteList();
              Reload reload = new Reload();
              await reload.reload(context);
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
