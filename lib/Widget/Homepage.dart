import "package:flutter/material.dart";
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bloc/CardsBloc.dart';
import 'package:flutter_app/Bloc/CatalogExtraBloc.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Utils/Api.dart';
import 'package:flutter_app/Utils/ImportCards.dart';
import 'package:flutter_app/Widget/Catalog/CatalogShow.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'Card/CardsAdd.dart';
import 'Drawer.dart';

class HomePage extends StatelessWidget {
  final _scaffoldkey_homepage =new  GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get getScaffold=>_scaffoldkey_homepage;
  Api api = new Api();
  ImportCards importCards = new ImportCards();
  TextEditingController catalog_controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cardsBloc = Provider.of<CardsBloc>(context);
    final catalogState = Provider.of<CatalogState>(context); 
    final catalogBloc = Provider.of<CatalogExtraBloc>(context);
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
                              //TODO:添加目录会多一个[]
                              CatalogDao catalogDao = new CatalogDao();
                              await catalogDao.insert(
                              Catalog.create(catalog_controller.text));
                              await catalogBloc.loadCatalogExtraList();
                              await catalogBloc.loadCatalogExtraList2();
                              await cardsBloc.loadCardCompleteList();
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
                      return SimpleDialog(
                        children: <Widget>[
                          ListTile(
                            title: Text("获取考研政治题库"),
                            onTap: ()async{
                              String jsonString = await api.getZhengzhi();
                              await importCards.imortCardsByJson(jsonString, "政治");//加入题库后 1.更新cards 2.更新两个目录3. 更新目录下的个数 
                              await catalogBloc.loadCatalogExtraList();
                              await catalogBloc.loadCatalogExtraList2();
                              await cardsBloc.loadCardCompleteList();
                              await catalogBloc.initNumber();
                              //await catalogState.reloadAllCatalogNames();
                              //await catalogState.reloadAllCatalognamesExtra();
                              //await catalogState.reloadCatlogs();
                              //Future.delayed(Duration(seconds :1));
                              Navigator.pop(context);
                             // Navigator.pop(context);
                            //TODO：没有处理删除的问题 更新总数有bug
                            },
                          )
                        ],
                        
                      );
                    }
                  );               
              }))),
    ];
    return Scaffold(
      key: _scaffoldkey_homepage,
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
                flex: 15,
                child: Container(
                  child: Scrollbar(child: ShowCatalogsExtras()),
                ),
              ),
              Expanded(
                child:
                Text(
                "今天学习了 张卡片",
              ),
              )
              
            ],
          ),
        ));
  }
}