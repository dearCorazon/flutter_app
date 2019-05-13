import 'package:flutter/material.dart';
import 'Knowledge_bean.dart';
class memory extends StatefulWidget{
  //TODO:弃用
  @override
  State<StatefulWidget> createState() {
    return new memory_state();
  }
}
class memory_state extends State<memory>{
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title:  new Text("memory"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height:500.0,
              child:  new Text( "i am tofu",style: new TextStyle(fontSize: 32.0)),
            ),
            new Divider(),
              new Row(
              children: <Widget>[
                new Expanded(
                    child: GestureDetector(
                      child: new Card(
                        child: Text("重来",textAlign: TextAlign.center,),
                        color: Colors.red,
                      ),
                    ),
                ),
                new Expanded(
                    child: GestureDetector(
                      onTap: null,
                      child: new Card(
                        child: Text("一般"),
                        color: Colors.green,
                ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }



}