import 'package:flutter/material.dart';
import 'package:flutter_app/Provider/CardsShowState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';

class ShowSimpleCard extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final cardsShowState = Provider.of<CardsShowState>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(cardsShowState.selectedCatalogName),//catalogname
          actions: <Widget>[
            Text("catalog"),
            RaisedButton(child: Text("baiban"),),
            RaisedButton(child: Text("clear"),),
            IconButton(icon: Icon(Icons.collections),onPressed: (){
              //和Schedule有关，收藏
            },),
            Text("menu"),
          ],
        ),
        drawer: Mydrawer(),
        body: Container(
          child:
          Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Text("1"),
                    Text("2"),
                    Text("3"),
                    Text("time machine"),
                  ],
                ),
              ),
              Text("quesition"),
              Text("answer"),
              Text("隐藏的答案"),
              RaisedButton(
                child: Text("显示答案"),
                onPressed: (){
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}