import 'package:flutter/material.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';

class ShowSimpleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("demo"),
          actions: <Widget>[
            Text("catalog"),
            RaisedButton(child: Text("banban"),),
            RaisedButton(child: Text("clear"),),
            IconButton(icon: Icon(Icons.collections),onPressed: (){},),
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