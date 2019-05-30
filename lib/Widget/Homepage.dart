import "package:flutter/material.dart";
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Utils/Api.dart';
import 'package:flutter_app/Utils/ImportCards.dart';
import 'package:flutter_app/Widget/CardsAdd.dart';
import 'package:flutter_app/Widget/CatalogShow.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'Drawer.dart';

class HomePage extends StatelessWidget {
  Api api = new Api();
  ImportCards importCards = new ImportCards();
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
              child: 
              IconButton(
                icon: Icon(
                  Icons.create), 
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      // return Container(
                      //  padding: new EdgeInsets.all(20.0),
                      //   child: Card(
                      //   color: Colors.blueAccent,
                      //       child: Text("获取考研政治题库"),
                      //       shape:RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.all(Radius.circular(20.0)),),
                      //       clipBehavior: Clip.antiAlias,
                      //       semanticContainer: false,
                      //     ),
                      // );
                      return SimpleDialog(
                        children: <Widget>[
                          ListTile(
                            title: Text("获取考研政治题库"),
                            onTap: ()async{
                              String jsonString = await api.getZhengzhi();
                              await importCards.imortCardsByJson(jsonString, "政治");
                              //await catalogState.reloadAllCatalogNames();
                              //await catalogState.reloadAllCatalognamesExtra();
                              //await catalogState.reloadCatlogs();
                              //Future.delayed(Duration(seconds :1));
                              Navigator.pop(context);
                             // Navigator.pop(context);
                            
                            },
                          )
                        ],
                        
                      );
                    }
                  );
                

              }))),
    ];
    return Scaffold(
        floatingActionButton: UnicornDialer(
            parentButton: Icon(Icons.add), childButtons: buttonlist),
        appBar: AppBar(
          title: Text('大学生法律知识记忆系统'),
          actions: <Widget>[
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
              Expanded(
                child: Container(
                  child: Scrollbar(child: ShowCatalogs()),
                ),
              ),
              Text(
                "今天学习了 张卡片",
              ),
            ],
          ),
        ));
  }
}