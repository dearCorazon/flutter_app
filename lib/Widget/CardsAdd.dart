import "package:flutter/material.dart";
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsAddState.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:flutter_app/Widget/CardType.dart';
import 'package:flutter_app/Widget/DropDownMenu.dart';
import 'package:provider/provider.dart';

class Addcards extends StatelessWidget {
  TextEditingController _questionController = new TextEditingController();
  TextEditingController _answerController = new TextEditingController();
  List<String> catalogs=[];
  Addcards(List<String> catalogs){
    Logv.Logprint("AddCard:constructor:"+catalogs.toString());
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
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.check),
        //     onPressed: (){
        //       Logv.Logprint();
        //       Logv.Logprint("quesiton:"+cardsAddState.question);
        //       Logv.Logprint("answer:"+cardsAddState.answer);
        //     },
        //   ),
        // ],
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
    case 2:{return ChoiceQuestion();}break;
    case 3:{return ChoiceQuestion();}break;
    case 4:{return SimpleCard();}break;
  }
}


