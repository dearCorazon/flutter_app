import "package:flutter/material.dart";
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/DAO/ScheduleDao.dart';
import 'package:flutter_app/Provider/CardsShowState.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Widget/CardsShow.dart';
import 'package:provider/provider.dart';

class ShowCatalogs extends StatelessWidget {
  @override
  //TODO：当目录名含有'时 会报错
  Widget build(BuildContext context) {
    final TextEditingController newnamecontroller = new TextEditingController();
    ScheduleDao scheduleDao = new ScheduleDao();
    CatalogDao catalogDao= new CatalogDao();
    final cardsShowState = Provider.of<CardsShowState>(context);
    final catalogState = Provider.of<CatalogState>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: catalogState.getCatlalogs.length,
      
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            ListTile(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(children: <Widget>[
                        Scrollbar(
                            child: (ListView(
                              shrinkWrap: true,
                            children: <Widget>[
                              ListTile(
                                title: Text('重命名'),
                                onTap: (){
                                  showDialog(
                                    context:  context,
                                    builder: (BuildContext context){
                                      return SimpleDialog(
                                        children: <Widget>[
                                          TextFormField(
                                            controller: newnamecontroller,
                                            validator:  (val)=>(val==null||val.isEmpty)? "不能为空":null,
                                            onFieldSubmitted: (value)async{
                                              await catalogDao.updateNameCatalogId(value, catalogState.getCatlalogs[index].id);
                                              await catalogState.reloadCatlogs();
                                              await catalogState.reloadAllCatalogNames();
                                              await catalogState.reloadAllCatalognamesExtra();
                                              Navigator.pop(context);Navigator.pop(context);
                                            },

                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                              ),
                              ListTile(
                                title: Text('删除'),
                                onTap: ()async{
                                  await catalogDao.deleteAllcardsByCatalogId(catalogState.getCatlalogs[index].id);
                                  await catalogState.reloadCatlogs();
                                  await catalogState.reloadAllCatalogNames();
                                  await catalogState.reloadAllCatalognamesExtra();
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text('导出'),
                              ),
                            ],
                          )),
                        ),
                      ]);
                    });
              },
              onTap: () {
                cardsShowState.refreshListIndex();
                cardsShowState
                    .setSelectedtId(catalogState.getCatlalogs[index].id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowSimpleCardFuture()));
              },
              title: Text("id " +
                  catalogState.getCatlalogs[index].id.toString() +
                  catalogState.getCatlalogs[index].name),
              subtitle: Text(
                  "${catalogState.getSingleById(catalogState.getCatlalogs[index].id).number} ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status1} ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status2} ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status3} ${catalogState.getSingleById(catalogState.getCatlalogs[index].id).status4}"),
            ),
            Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}

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
