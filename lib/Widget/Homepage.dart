import "package:flutter/material.dart";
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:unicorndial/unicorndial.dart';
import 'Drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final buttonlist = [
    UnicornButton(
        currentButton: FloatingActionButton(
            mini: true,
            heroTag: 'button1',
            onPressed: (){
              addCatalogDialog(context);
            },
            child: Icon(Icons.category)
        )
    ),
    UnicornButton(
        currentButton: FloatingActionButton(
            mini: true,
            heroTag: 'button2',
            onPressed: null,
            child: IconButton(icon: Icon(Icons.add), onPressed: null))),
    UnicornButton(
        currentButton: FloatingActionButton(
            mini: true,
            heroTag: 'button3',
            onPressed: null,
            child: IconButton(icon: Icon(Icons.create), onPressed: null))),
  ];
    return Scaffold(
        floatingActionButton: UnicornDialer(
            parentButton: Icon(Icons.add), childButtons: buttonlist),
        appBar: AppBar(
          title: Text('demo'),
          actions: <Widget>[
            MaterialButton(
                child: Text("db"),
                onPressed: () {
                  Navigator.pushNamed(context, "/daotest");
                }),
            IconButton(icon: Icon(Icons.sync), onPressed: () {}),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
        drawer: MDrawer(),
        body: Container(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: _getRow(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Text('loading...');
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        return createListView(context, snapshot);
                  }
                },
              ),
              Text(
                "今天学习了 张卡片，用了 分钟",
              ),
            ],
          ),
        )
        );
  }
}

Future<List<Catalog>> _getRow() async {
  var catalogs = new List<Catalog>();
  CatalogDao catalogDao = new CatalogDao();
  catalogs = await catalogDao.queryAll();
  return catalogs;
}

Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Catalog> catalogs = snapshot.data;
  return ListView.builder(
    shrinkWrap: true,
    itemCount: catalogs.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(
                "id " + catalogs[index].id.toString() + catalogs[index].name),
            subtitle: Text("superior:" + catalogs[index].superiorId.toString()),
          ),
          Divider(
            height: 2.0,
          ),
        ],
      );
    },
  );
}
Widget addCatalogDialog(BuildContext context){
  showDialog(
    context:  context,
    builder:(BuildContext context){
        // return Dialog(

        // )
    }
  );

  
}