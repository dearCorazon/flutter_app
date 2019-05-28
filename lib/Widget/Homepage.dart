import "package:flutter/material.dart";
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Widget/CardsAdd.dart';
import 'package:flutter_app/Widget/CatalogShow.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'Drawer.dart';

class HomePage extends StatelessWidget {
  TextEditingController catalog_controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final catalogState = Provider.of<CatalogState>(context);
    final buttonlist = [
      UnicornButton(
          currentButton: FloatingActionButton(
              mini: true,
              heroTag: 'button1',
              onPressed: () {
                // addCatalogDialog(context);
              },
              child: Icon(Icons.category))),
      UnicornButton(
          currentButton: FloatingActionButton(
              mini: true,
              heroTag: 'button2',
              onPressed: null,
              child: IconButton(
                icon: Icon(Icons.add), 
                onPressed: (){
                  List<String> catalogs=catalogState.getAllCatalognames;
                  Logv.Logprint("onpressesd:"+catalogs.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) => Addcards(catalogs)
                    ),
                  );
                }
              )
          )
      ),
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
        drawer: Mydrawer(),
        body: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("添加目录"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Text("添加目录"),
                        children: <Widget>[
                          TextField(
                            controller: catalog_controller,
                          ),
                          FlatButton(
                            child: Text("添加"),
                            onPressed: () async {
                              CatalogDao catalogDao = new CatalogDao();
                              await catalogDao.insert(
                              Catalog.create(catalog_controller.text));
                              catalogState.fetchData();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              Expanded(
                child: Container(
                  child: Scrollbar(child: ShowCatalogs()),
                ),
              ),
              Text(
                "今天学习了 张卡片，用了 分钟",
              ),
            ],
          ),
        ));
  }
}