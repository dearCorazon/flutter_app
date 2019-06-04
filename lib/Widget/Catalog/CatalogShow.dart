import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_app/Bean/CatalogExtra.dart';
import 'package:flutter_app/Bloc/CardsBloc.dart';
import 'package:flutter_app/Bloc/CatalogExtraBloc.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/Provider/CardsShowState.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Widget/Card/CardsShow.dart';
import 'package:flutter_app/Widget/NoDataWidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/Widget/homepage.dart';

class ShowCatalogsExtras extends StatelessWidget {
  const ShowCatalogsExtras({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<CatalogExtra>>(
        stream: Provider.of<CatalogExtraBloc>(context).stream,
        initialData: Provider.of<CatalogExtraBloc>(context).catalogExtras,
        builder: (context,snapshot){
          return getList(context, snapshot);
        },

      ),
    );
  }
}

Widget getList(BuildContext context,AsyncSnapshot<List<CatalogExtra>> snapshot){
  if(snapshot.connectionState==ConnectionState.waiting){
    return CupertinoActivityIndicator();
  }else{
    if(snapshot==null){
    return Nodata();
    
  }
    else{
    return  createList(context, snapshot);
  }
  }
  }

Widget  createList(BuildContext context,AsyncSnapshot<List<CatalogExtra>> snapshot){
  return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        final cardBloc=  Provider.of<CardsBloc>(context);
        final cardState =Provider.of<CardsShowState>(context);
        return Column(
          children: <Widget>[
            ListTile(
              onTap: ()async{
                //TODO：判断是否为空
                //TODO:    在此处showSimpleCard
                int catalogId=snapshot.data[index].catalogId;
                cardState.refreshListIndex();
                await cardBloc.loadCardsWithSchedule(catalogId, 50);

                if(cardBloc.currentList.length==0){
                  HomePage homePage = new HomePage();
                  //TODO:獲取不了上層的Scaffold 調用 showScafflod
                  homePage.getScaffold.currentState.showSnackBar(SnackBar(content: Text("該目錄是空的"),
                  ));
                   //_scaffoldkey.currentState
                }
                else{ 
                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context)=>showSimpleCard()
                  
                ));

                }                                     
               
              },
              onLongPress: (){
                _showDialog(context,snapshot,index);
              },
              title: Text(snapshot.data[index].name),
              subtitle: Row(
                children: <Widget>[
                  Text(snapshot.data[index].number.toString(),style: TextStyle(color:  Colors.black)),
                  Text(" "+snapshot.data[index].status1.toString(),style: TextStyle(color:  Colors.blueGrey)),
                  Text(" "+snapshot.data[index].status2.toString(),style: TextStyle(color:  Colors.redAccent)),
                  Text(" "+snapshot.data[index].status3.toString(),style: TextStyle(color:  Colors.yellowAccent)),
                  Text(" "+snapshot.data[index].status4.toString(),style: TextStyle(color:  Colors.greenAccent)),
                ],
              ),
            ),
            
          ],
        );
      }
      
  );

}
void _showDialog(BuildContext context,AsyncSnapshot<List<CatalogExtra>> snapshot,int index){
  ScheduleDao scheduleDao = new ScheduleDao();
  CatalogDao catalogDao = new CatalogDao();
  showDialog(
    context: context,
    builder: (BuildContext context){
      final catalogBloc = Provider.of<CatalogExtraBloc>(context);
      final cardsBloc= Provider.of<CardsBloc>(context);
       return Container(
        child: SimpleDialog(
          children: <Widget>[
            Column(
              children: <Widget>[
                ListTile(
                  title: Text('重命名'),
                ),
                ListTile(
                  title: Text('删除'),
                  onTap: ()async{
                    await catalogDao.deleteAllcardsByCatalogId(snapshot.data[index].catalogId);
                    await catalogBloc.loadCatalogExtraList();
                    await cardsBloc.loadCardCompleteList();
                    await catalogBloc.loadCatalogExtraList2();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('导出'),
                ),
              ],
            )
          ],
        ),
      );
    }
    
  );

}
// class ShowCatalogs extends StatelessWidget {
//   @override
//   //TODO：当目录名含有'时 会报错  
//   //TODO:准备弃用
//   Widget build(BuildContext context) {
//     final TextEditingController newnamecontroller = new TextEditingController();
//     ScheduleDao scheduleDao = new ScheduleDao();
//     CatalogDao catalogDao = new CatalogDao();
//     final cardsShowState = Provider.of<CardsShowState>(context);
//     final catalogState = Provider.of<CatalogState>(context);
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: catalogState.getCatlalogs.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Column(
//           children: <Widget>[
//             ListTile(
//               onLongPress: () {
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Container(
//                         child: SimpleDialog(children: <Widget>[
//                           (Column(
//                             children: <Widget>[
//                               ListTile(
//                                 title: Text('重命名'),
//                                 onTap: () {
//                                   showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return Container(
//                                           child: SimpleDialog(
//                                             children: <Widget>[
//                                               TextFormField(
//                                                 controller: newnamecontroller,
//                                                 validator: (val) =>
//                                                     (val == null || val.isEmpty)
//                                                         ? "不能为空"
//                                                         : null,
//                                                 onFieldSubmitted: (value) async {
//                                                   await catalogDao
//                                                       .updateNameCatalogId(
//                                                           value,
//                                                           catalogState
//                                                               .getCatlalogs[index]
//                                                               .id);
//                                                   await catalogState
//                                                       .reloadCatlogs();
//                                                   await catalogState
//                                                       .reloadAllCatalogNames();
//                                                   await catalogState
//                                                       .reloadAllCatalognamesExtra();
//                                                   Navigator.pop(context);
//                                                   Navigator.pop(context);
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       });
//                                 },
//                               ),
//                               ListTile(
//                                 title: Text('删除'),
//                                 onTap: () async {
//                                   await catalogDao.deleteAllcardsByCatalogId(
//                                       catalogState.getCatlalogs[index].id);
//                                   await catalogState.reloadCatlogs();
//                                   await catalogState.reloadAllCatalogNames();
//                                   await catalogState.reloadAllCatalognamesExtra();
                                
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                               ListTile(
//                                 title: Text('导出'),
//                               ),
//                             ],
//                           )),
//                         ]),
//                       );
//                     });
//               },
//               onTap: () {
//                 cardsShowState.refreshListIndex();
//                 cardsShowState
//                     .setSelectedtId(catalogState.getCatlalogs[index].id);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ShowSimpleCardFuture()));
//               },
//               title: Text(catalogState.getCatlalogs[index].name),
//               subtitle: Row(
//                 children: <Widget>[
//                   Text("${catalogState.getSingleById(catalogState.getCatlalogs[index].id).number}",style: TextStyle(color: Colors.blue)),
//                   Text(" ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status1}",style: TextStyle(color: Colors.red),),
//                   Text(" ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status2}",style: TextStyle(color:  Colors.yellow)),
//                   Text(" ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status4}",style: TextStyle(color:  Colors.green),),
//                 ],
//               )
//               // Text(
//               //     "${catalogState.getSingleById(catalogState.getCatlalogs[index].id).number} ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status1} ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status2} ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status3} ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status4}"),
//             ),
//             Divider(
//               height: 2.0,
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class ShowCatalogswithFuture extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     final cardsShowState = Provider.of<CardsShowState>(context);
//     final catalogState = Provider.of<CatalogState>(context);
//     Widget getWidget(){
//       if(cardsShowState.currentListWithSchedule.length==0){
//         //TODO：太丑需要优化
//         return Nodata();
//       }
//       else{
//         return ShowSimpleCard();
//       }
//     }
//      return ListView.builder(
//       shrinkWrap: true,
//       itemCount: catalogState.getCatlalogs.length,
//       itemBuilder: (BuildContext context, int index) {
//       return Column(
//         children: <Widget>[
//           ListTile(
//             onTap: ()async{
//               int selectedCatalogId;
//               selectedCatalogId= catalogState.getCatlalogs[index].id;
//               await cardsShowState.loadCatalogInformation(selectedCatalogId,catalogState.getCatlalogs[index].name);
//               await cardsShowState.loadCardList(selectedCatalogId);
//               await cardsShowState.reloadCurrentListIndex();
//               await cardsShowState.loadCardListWithSchedule();
//               Future.delayed(Duration(milliseconds:900 ));
//               //TODO：如果数据多时 还是只能delayde执行
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context)=> getWidget()
//               ));
//             },
//             title: Text(
//                 "id " + catalogState.getCatlalogs[index].id.toString() + catalogState.getCatlalogs[index].name),
//             subtitle: Text("superior:" + catalogState.getCatlalogs[index].superiorId.toString()),
//           ),
//           Divider(
//             height: 2.0,
//           ),
//         ],
//       );
//     },
//   );
//   }
// }
// class ShowCatalog extends StatefulWidget {
//   //TODO:参考准备弃用
//   @override
//   _State createState() => _State();
// }

// class _State extends State<ShowCatalog> {

//   @override
//   Widget build(BuildContext context) {
//     final catalogState = Provider.of<CatalogState>(context);
//     final cardsShowState = Provider.of<CardsShowState>(context);

//     //List<Catalog> catalogs;
//     return ListView.builder(
//     shrinkWrap: true,
//     itemCount: catalogState.getCatlalogs.length,
//     itemBuilder: (BuildContext context, int index) {
//       return Column(
//         children: <Widget>[
//           ListTile(
//             onTap: (){
//               int selectedCatalogId;
//               cardsShowState.reloadCurrentListIndex();
//               selectedCatalogId= catalogState.getCatlalogs[index].id;
//              // cardsShowState.loadCatalogId(selectedCatalogId);
//               //1.获取Catalog数据.(暂时先)
//             },
//             title: Text(
//                 "id " + catalogState.getCatlalogs[index].id.toString() + catalogState.getCatlalogs[index].name),
//             subtitle: Text("superior:" + catalogState.getCatlalogs[index].superiorId.toString()),
//           ),
//           Divider(
//             height: 2.0,
//           ),
//         ],
//       );
//     },
//   );
// }

// }
