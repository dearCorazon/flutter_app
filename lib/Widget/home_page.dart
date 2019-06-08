import 'package:flutter/material.dart';

class HomePage3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeState();
  }
}

class _HomeState extends State<HomePage3>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text("主页", style: new TextStyle(color: Colors.white),),
        ),
      ),
      body: new SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: new EdgeInsets.all(3)),
            new ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: new Container(
                  child: new Image.network(
                    'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1402367109,4157195964&fm=26&gp=0.jpg',
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                  width: MediaQuery.of(context).size.width-20,
                )
            ),
            new Padding(padding: new EdgeInsets.all(10)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new InkWell(
                        child: new Container(
                          height: 70,
                          width: 70,
                          child: new Card(
                            elevation: 2,
                            color: Colors.lightBlueAccent,
                            child: new Icon(
                              Icons.cake,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        // onTap: (){
                        //   // 这里应该进入单选题题库列表，下同
                        //   Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                        //     return new BlocProvider(child: new SingleChoicePage(name: "单选题"), bloc: new SingleChoiceBloc(id: 1));
                        //   }));
                        // },
                      ),
                      new Text(
                        '单选题',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new InkWell(
                        child: new Container(
                          height: 70,
                          width: 70,
                          child: new Card(
                            elevation: 2,
                            color: Colors.lightBlueAccent,
                            child: new Icon(
                              Icons.cake,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        // onTap: (){
                        //   Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                        //     return new BlocProvider(child: new MultipleChoicePage(name: "多选题"), bloc: new MultipleChoiceBloc(id: 1));
                        //   }));
                        // },
                      ),
                      new Text(
                        '多选题',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new InkWell(
                        child: new Container(
                          height: 70,
                          width: 70,
                          child: new Card(
                            elevation: 2,
                            color: Colors.lightBlueAccent,
                            child: new Icon(
                              Icons.cake,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        onTap: (){
                          // Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                          //   return new BlocProvider(child: new JudgePage(name: "判断题"), bloc: new JudgeBloc(id: 1));
                          // }));
                        },
                      ),
                      new Text(
                        '判断题',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            new Padding(padding: new EdgeInsets.all(10)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new InkWell(
                        child: new Container(
                          height: 70,
                          width: 70,
                          child: new Card(
                            elevation: 2,
                            color: Colors.lightBlueAccent,
                            child: new Icon(
                              Icons.cake,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        onTap: (){

                        },
                      ),
                      new Text(
                        '填空题',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new InkWell(
                        child: new Container(
                          height: 70,
                          width: 70,
                          child: new Card(
                            elevation: 2,
                            color: Colors.lightBlueAccent,
                            child: new Icon(
                              Icons.cake,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        onTap: (){

                        },
                      ),
                      new Text(
                        '简答题',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
                new Expanded(
                    flex: 2,
                    child: new Container()
                ),
              ],
            ),
            new Padding(padding: new EdgeInsets.all(10)),
            new Divider(),
            new Padding(padding: new EdgeInsets.all(10)),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new InkWell(
                        child: new Container(
                          height: 70,
                          width: 70,
                          child: new Card(
                            elevation: 2,
                            color: Colors.lightBlueAccent,
                            child: new Icon(
                              Icons.cake,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        onTap: (){

                        },
                      ),
                      new Text(
                        '个人中心',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
                new Expanded(
                  flex: 1,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new InkWell(
                        child: new Container(
                          height: 70,
                          width: 70,
                          child: new Card(
                            elevation: 2,
                            color: Colors.lightBlueAccent,
                            child: new Icon(
                              Icons.cake,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        onTap: (){

                        },
                      ),
                      new Text(
                        '设置',
                        style: new TextStyle(
                            color: Colors.black,
                            fontSize: 16
                        ),
                      )
                    ],
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Container(),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}