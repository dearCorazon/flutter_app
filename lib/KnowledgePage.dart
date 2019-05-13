import 'package:flutter/material.dart';
import 'package:flutter_app/Knowledge_bean.dart';
class Knowledge_Page extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return KnowledgeState();
  }
}
class KnowledgeState extends State<Knowledge_Page>{
  KnowledgeSqlite sqlite = new KnowledgeSqlite();
  String content='fan';
  int i=1;
  int length;
  List<Knowledge_bean> knowledges;
  KnowledgeState(){
    _init();
  }
  _init()async{
    knowledges=await sqlite.queryAll();
    print("获取到的共有?条数据");
    print(knowledges.length);
    length=knowledges.length;
    content=knowledges[i].content;
    print("init里面获取到的content:"+knowledges[i].content);
    setState(() {
      content=knowledges[i].content;
    });
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:  AppBar(
        title: Text("memeory"),
      ),
      body:   Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height:500.0,
              child:  Text(content,style: new TextStyle(fontSize: 32.0)),
            ),
            Divider(),
            Row(
              children: <Widget>[
                MaterialButton(
                  child: Text("认识",textAlign: TextAlign.center,),
                  color: Colors.red,
                  onPressed: ()async{
                    int status =await sqlite.query_status(i);
                    print("当前状态为$status");
                    sqlite.status_add(i,true);
                    i++;
                    if(i==length){
                      Navigator.pop(context);
                      return;
                    }
                    setState(() {
                      content=knowledges[i].content;
                    });
                  },
                ),
                MaterialButton(
                  child:  Text("不认识"),
                  color:  Colors.green,
                  onPressed: ()async{
                    int status =await sqlite.query_status(i);
                    print("当前状态为$status");
                    sqlite.status_add(i,false);
                    i++;
                    if(i==length){
                      //TODO:退出的时候记得加个对话框
                      Navigator.pop(context);
                      return;
                    }
                    setState(() {
                        content=knowledges[i].content;
                      });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}