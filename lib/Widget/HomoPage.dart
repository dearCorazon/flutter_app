
import 'package:flutter_app/Widget/ExpansionPanelList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Widget/Drawer.dart' as s;
import 'package:unicorndial/unicorndial.dart';
//TODO:参考（准备弃用）
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonlist=[
      new UnicornButton(
          currentButton: FloatingActionButton(
              heroTag: 'button1',
              onPressed: null,
              child: IconButton(icon: Icon(Icons.map), onPressed: (){
                Navigator.pushNamed(context, '/knowledge');
              })
          )
      ),
      new UnicornButton(
          currentButton: FloatingActionButton(
              heroTag: 'button2',
              onPressed: null,
              child: IconButton(icon: Icon(Icons.add), onPressed: null)
          )
      ),
      new UnicornButton(
          currentButton: FloatingActionButton(
              heroTag: 'button3',
              onPressed: null,
              child: IconButton(icon: Icon(Icons.create), onPressed: null)
          )
      ),
    ];

    return  DefaultTabController(
        length: choices.length,
        child:
        new Scaffold(
          floatingActionButton: UnicornDialer(
            parentButton: Icon(Icons.add),
            childButtons: buttonlist
          ),
          appBar: new AppBar(
            title: Text('demo'),
            actions: <Widget>[
              MaterialButton(
                child:  Text("db"),
                onPressed: (){
                  Navigator.pushNamed(context, "/daotest");
                }
              ),
              IconButton(
                  icon: Icon(Icons.sync),
                  onPressed: () {}
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){},
              ),
            ],
            bottom:
            new TabBar(
              isScrollable: true,
              tabs: choices.map((Choice c) {
                return new Tab(
                  text: c.title,
                  icon: new Icon(c.icon),
                );
              }).toList(),
            ),
          ),
          drawer: new s.MDrawer(),
          body: new TabBarView(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    //Text("TEXT")
                  Divider(),
                  Container(
                    child:new PanelList_memory())
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("MEMORY")
                  ],
                )
              ]),
        )

    );
  }
}
class Choice{
  const Choice({this.icon,this.title});
  final IconData  icon;
  final String title;
}
List<Choice> choices= <Choice>[
  const Choice(title: "TEST",icon:Icons.exit_to_app),
  const Choice(title: "MEMORY",icon: Icons.brush),
];