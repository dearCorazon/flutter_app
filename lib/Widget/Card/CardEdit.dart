import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/CardComplete.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsAddState.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:flutter_app/Widget/DropDownMenu.dart';
import 'package:provider/provider.dart';

class CardEdit extends StatelessWidget {
  CardComplete card;
  List<String> catalogs=[];
  CardEdit(CardComplete card){
    this.card=card;
    this.catalogs=catalogs;
  }
  @override
  Widget build(BuildContext context) {
    final dropDownMenuState= Provider.of<DropDownMenuState>(context);
    final cardsAddState= Provider.of<CardsAddState>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("添加卡片"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(flex: 1, child: Text("卡片类型")),
                Expanded(flex: 2, child: DropDownMenu_type()),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(flex: 1, child: Text("目录")),
                Expanded(
                  flex: 2,
                  child: DropDownMenu_catalog(catalogs),
                )
              ],
            ),
            SingleChildScrollView(child: getCardType(dropDownMenuState.cardType)),
          ],
        ),
      ),
    );
  }
}
Widget getCardType(int type){
  switch(type){
    case 1:{return SimpleCard();}break;
    case 4:{return SimpleCard();}break;
  }
}
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