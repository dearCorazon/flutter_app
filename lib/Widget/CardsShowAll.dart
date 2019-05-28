import 'package:flutter/material.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:flutter_app/Widget/CardsList.dart';
import 'package:flutter_app/Widget/Drawer.dart';
import 'package:flutter_app/Widget/DropDownMenu.dart';
import 'package:flutter_app/Widget/NoDataWidget.dart';
import 'package:provider/provider.dart';

class ShowAllCards extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final catalogState = Provider.of<CatalogState>(context);
    final userState = Provider.of<UserState>(context);
    final dropDownMenuCatlogState= Provider.of<DropDownMenuState>(context);
    Widget getWidget(){
    if(dropDownMenuCatlogState.getCurrentCardList!=null){
      return CardsList();
    }
      else{
        return Nodata();
      }
    }
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: DropDownMenu_catalog(catalogState.getAllCatalognamesExtra),
          ),
          actions: <Widget>[
            Center(child: Text("${dropDownMenuCatlogState.getcurrentNumber}张卡片")),
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
        child: Column(
          children: <Widget>[
            Table(
              children: [
                TableRow(
                  children:[
                  Text("问题"),
                  Text("答案"),]
                )
              ],
            ),
            Expanded(
              child: Container(
                //TODO:不能滚动
                child: Scrollbar(child: getWidget())),
            ),
          ],
        ),
        
        
      ),
      ),
    );
  }
} 