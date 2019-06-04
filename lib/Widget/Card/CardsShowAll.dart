import 'package:flutter/material.dart';
import 'package:flutter_app/Bloc/CatalogExtraBloc.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:flutter_app/Widget/Drawer.dart';
import 'package:flutter_app/Widget/DropDownMenu.dart';
import 'package:flutter_app/Widget/NoDataWidget.dart';
import 'package:provider/provider.dart';

import 'CardsList.dart';

class ShowAllCards extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    //final catalogState = Provider.of<CatalogState>(context);
    final userState = Provider.of<UserState>(context);
    final dropDownMenuCatlogState= Provider.of<DropDownMenuState>(context);

    Widget getWidget(){
    if(dropDownMenuCatlogState.getCurrentCardList!=null){
      return ListAllCards();
    }
      else{
        return Nodata();
      }
    }

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: DropDownMenu_catalog2()            ,
          ),
          actions: <Widget>[
            Center(child:Text_number()),
            IconButton(
            icon:Icon(Icons.add),
            onPressed: (){
            },
            ),
            IconButton(
              icon:Icon(Icons.search),
              onPressed: (){
                //Logv.Logprint(userState.getStatus.toString());
                //Logv.Logprint(catalogState.getAllCatalognames.toString());
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
                
                child: Scrollbar(child: ListAllCards())),
            ),
          ],
        ),
      ),
      ),
    );
  }
} 
Widget getText(BuildContext context){
  return StreamBuilder<int>(
    initialData:  Provider.of<CatalogExtraBloc>(context).number,
    stream: Provider.of<CatalogExtraBloc>(context).stream_number,
    builder: (context, snapshot) {
      return Text("共${snapshot.data}张卡片");
    }
  );
}
class Text_number extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<int>(
        initialData:  Provider.of<CatalogExtraBloc>(context).number,
        stream: Provider.of<CatalogExtraBloc>(context).stream_number,
        builder: (context, snapshot) {
          return Text(snapshot.data.toString());
        }
      ),
    );
  }
  
}