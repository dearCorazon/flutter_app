import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/CardComplete.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/Bloc/CardsBloc.dart';
import 'package:flutter_app/DAO/TestDao.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:flutter_app/Widget/NoDataWidget.dart';
import 'package:provider/provider.dart';

class CardsList extends StatelessWidget {
  //TODO：CardsShowAll 最好不要分开
  @override
  Widget build(BuildContext context) {
    //TODO:需要优化一下表格
    //TODO：准备弃用
    //TODO：需要改成FutureBuilder
    final dropDownMenuCatlogState= Provider.of<DropDownMenuState>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dropDownMenuCatlogState.getCurrentCardList.length,
      itemBuilder: (BuildContext context,int index){
        return Table(
          children: [
            TableRow(
              children: [
                Text(dropDownMenuCatlogState.getCurrentCardList[index].question),
                Text(dropDownMenuCatlogState.getCurrentCardList[index].answer),
                ],
          ),],
        );
      },

    );
  }
}
class CardsListWithFuture  extends StatelessWidget {
  TestDao testDao =new TestDao();

  Future<List<Test>> getCardsListByCatalogName(String catalogName)async{
    List<Test> tests  = await testDao.loadCardListWithCatalogName(catalogName);
    return tests;
  }
  Widget getWidget(BuildContext context,AsyncSnapshot snapshot){
    List<Test> tests = snapshot.data;
    final dropDownMenuCatlogState= Provider.of<DropDownMenuState>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tests.length,
      itemBuilder: (BuildContext context,int index){
        
        return Table(
          children: [
            TableRow(
              children: [
                Text(tests[index].question),
                Text(tests[index].answer),
                ],
          ),],
        );
      },
    );
  }
  //展示所有的卡片

  @override
  Widget build(BuildContext context) {
     final dropDownMenuCatlogState= Provider.of<DropDownMenuState>(context);
       return Container(
        child: FutureBuilder(
            future: getCardsListByCatalogName(dropDownMenuCatlogState.currentSelectedCatalogName),//需要获取当前选中的列表 但如果是全部就要获取所有
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else{
                    if(snapshot.data==null){
                      return Nodata();
                    }else{
                      return getWidget(context,snapshot);
                    }
                  }      
              }
            })
            );
  }
}
class ListAllCards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CardComplete>>(
      stream: Provider.of<CardsBloc>(context).stream,
      initialData: Provider.of<CardsBloc>(context).cardCompletes,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return 
        //Text(snapshot.data.toString());
      getList2(context,snapshot);//TODO：换成这个会一直等待不知道为什么
        //createList(context, snapshot);
      },
    );
  }
} 
Widget getList(BuildContext context,AsyncSnapshot<List<CardComplete>> snapshot){
  if(snapshot.connectionState==ConnectionState.waiting){
    return CupertinoActivityIndicator();
  }
  else{
    if(snapshot==null){
    return Nodata();
  }
    else{
    return  createList(context, snapshot);
  }
  }
  }
Widget getList2(BuildContext context,AsyncSnapshot<List<CardComplete>> snapshot){
 
 
    if(snapshot.data==null){
    return Nodata();}
    else{
    return  createList(context, snapshot);
  }
  }

Widget createList(BuildContext context,AsyncSnapshot<List<CardComplete>> snapshot){
  return ListView.builder(
    shrinkWrap: true,
    itemCount: snapshot.data.length,
    itemBuilder: ( context, int index) {
       return Table(
          children: [
            TableRow(
              children: [
                Text(snapshot.data[index].question),
                Text(snapshot.data[index].answer),
                ],
          ),],
        );
    },
    
  );
}