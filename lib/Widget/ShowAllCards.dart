import 'package:flutter/material.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:flutter_app/Widget/Drawer.dart';
import 'package:flutter_app/Widget/DropDownMenu.dart';
import 'package:provider/provider.dart';

class ShowAllCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catalogState = Provider.of<CatalogState>(context);
    final userState = Provider.of<UserState>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: DropDownMenu_catalog(catalogState.getAllCatalognamesExtra),
          ),
          actions: <Widget>[
            Center(child: Text("90张卡片")),
            //Container(child: DropDownMenu_catalog(catalogState.getAlllcatalognamesExtra)),
            IconButton(
            icon:Icon(Icons.add),
            onPressed: (){
            },
            ),
            IconButton(
              icon:Icon(Icons.search),
              onPressed: (){
                Logv.Logprint(userState.getStatus.toString());
                Logv.Logprint(catalogState.getAllCatalognames.toString());
              },)
          ],
        ),
    
      drawer:  Mydrawer(), 
      body: Container(
        
      ),
      ),
    );
  }
} 