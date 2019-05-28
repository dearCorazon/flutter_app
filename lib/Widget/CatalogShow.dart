import "package:flutter/material.dart";
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/Provider/CardsShowState.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Widget/CardsShow.dart';
import 'package:provider/provider.dart';

class ShowCatalogs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final cardsShowState = Provider.of<CardsShowState>(context);
    final catalogState = Provider.of<CatalogState>(context);
     return ListView.builder(
      shrinkWrap: true,
      itemCount: catalogState.getCatlalogs.length,
      itemBuilder: (BuildContext context, int index) {
      return Column(
        children: <Widget>[
          ListTile(
            onTap: (){
              int selectedCatalogId;
              selectedCatalogId= catalogState.getCatlalogs[index].id;
              cardsShowState.loadCatalogInformation(selectedCatalogId,catalogState.getCatlalogs[index].name);
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context)=> ShowSimpleCard()
              ));
            },
            title: Text(
                "id " + catalogState.getCatlalogs[index].id.toString() + catalogState.getCatlalogs[index].name),
            subtitle: Text("superior:" + catalogState.getCatlalogs[index].superiorId.toString()),
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
class ShowCatalog extends StatefulWidget {
  //TODO:参考准备弃用
  @override
  _State createState() => _State();
}

class _State extends State<ShowCatalog> {

  @override
  Widget build(BuildContext context) {
    final catalogState = Provider.of<CatalogState>(context);
    final cardsShowState = Provider.of<CardsShowState>(context);

    //List<Catalog> catalogs;
    return ListView.builder(
    shrinkWrap: true,
    itemCount: catalogState.getCatlalogs.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: <Widget>[
          ListTile(
            onTap: (){
              int selectedCatalogId;
              selectedCatalogId= catalogState.getCatlalogs[index].id;
             // cardsShowState.loadCatalogId(selectedCatalogId);
              //1.获取Catalog数据.(暂时先)
            },
            title: Text(
                "id " + catalogState.getCatlalogs[index].id.toString() + catalogState.getCatlalogs[index].name),
            subtitle: Text("superior:" + catalogState.getCatlalogs[index].superiorId.toString()),
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