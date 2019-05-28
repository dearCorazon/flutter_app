import 'package:flutter/material.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsShowState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:provider/provider.dart';
import 'Drawer.dart';

class ShowSimpleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardsShowState = Provider.of<CardsShowState>(context);
    _changeCardShowState() {
      int length;
      if (cardsShowState.currentList == null) {
        length = 0;
      } else {
        length = cardsShowState.currentList.length;
      }
      Logv.Logprint("currentTest:${cardsShowState.currentListIndex}:" +
          cardsShowState.currentList[cardsShowState.currentListIndex].question);
      //Logv.Logprint("in 显示答案Button：当前内容：${cardsShowState.currentList[cardsShowState.currentListIndex].toString()}");

      //Logv.Logprint("下一条显示的内容："+cardsShowState.currentList[cardsShowState.currentListIndex].question);
      //Logv.Logprint("in 显示答案 CurrentListIndex：${cardsShowState.currentListIndex}");
      if (cardsShowState.currentListIndex + 1 == length) {
        Navigator.pop(context);
      } else {
        cardsShowState.addCurrentListIndex();
      }
      cardsShowState.changeFirstButton();
    }

    Widget getHideAnswer() {
      if (cardsShowState.isHide) {
        return Text("");
      } else {
        return Text(
            cardsShowState.currentList[cardsShowState.currentListIndex].answer);
      }
    }

    Widget getButton() {
      if (cardsShowState.firstButton) {
        return RaisedButton(
          child: Text("显示答案"),
          onPressed: () {
            cardsShowState.changeFirstButton();
          },
        );
      } else {
        return Container(
          child: Row(
            children: <Widget>[
              RaisedButton(
                child: Text("认识"),
                onPressed: () {
                  _changeCardShowState();
                },
              ),
              RaisedButton(
                child: Text("不认识"),
                onPressed: () {
                  _changeCardShowState();
                },
              )
            ],
          ),
        );
      }
    }
    // RaisedButton(
    //   child: Text("显示答案"),
    //   onPressed: (){

    //   },
    // ),

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(cardsShowState.selectedCatalogName), //catalogname
          actions: <Widget>[
            Text("catalog"),
            RaisedButton(
              child: Text("baiban"),
            ),
            RaisedButton(
              child: Text("clear"),
            ),
            IconButton(
              icon: Icon(Icons.collections),
              onPressed: () {
                //和Schedule有关，收藏
              },
            ),
            Text("menu"), //TODO:做成下拉菜单
          ],
        ),
        drawer: Mydrawer(),
        body: Container(
            child: Column(
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
            Text(cardsShowState
                .currentList[cardsShowState.currentListIndex].question),
            // Text(cardsShowState.currentList[cardsShowState.currentListIndex].answer),
            // Text("隐藏的答案"),
            getHideAnswer(),
            getButton(),
          ],
        )),
      ),
    );
  }
}
