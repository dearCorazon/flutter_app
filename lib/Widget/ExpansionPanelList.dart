import 'package:flutter/material.dart';

class PanelList_memory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return new _PanelList_memory();
  }
}
class _PanelList_memory extends State<PanelList_memory>{
  //TODO:命名是不是有问题，跟上面那个一mu一样
  var currentPanelIndex=-1;
  List<int>mList;
  _PanelList_memory(){
    mList = new List();
    for(int i=0;i<5;i++){
      mList.add(i);
    }
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          //new Text("demo1"),
          new ExpansionPanelList(
            expansionCallback:  (panelIndex,isExpanded){
              setState(() {
                currentPanelIndex = (currentPanelIndex!=panelIndex?panelIndex:-1);
              });
            },
            children: mList.map((i){
              return new ExpansionPanel(
                  headerBuilder: (context,isExpanded){
                    return new ListTile(
                      //title: new Text("1"),
                    );
                  },
                  body: new Padding(
                      padding: EdgeInsets.all(30.0),
                      child: new ListBody(
                        children: <Widget>[
                          new Text("标题1的内容"),
                        ],
                      ),
                  ),
                isExpanded: currentPanelIndex==i,
              );
          }).toList(),
      ),
     // new Text("2"),
    ],
      ),
    );
  }
}