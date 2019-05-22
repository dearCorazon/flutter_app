import "package:flutter/material.dart";
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Widget/DropDownMenu.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: ()async{
              String qustion= _questionController.text;
              String answer= _answerController.text;
              
            },
          ),
        ],
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
            TextField(),
            TextField(),
          ],
        ),
      ),
    );
  }
}

