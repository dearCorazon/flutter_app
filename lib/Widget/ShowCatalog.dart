import "package:flutter/material.dart";
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:provider/provider.dart';

class ShowCatalog extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ShowCatalog> {

  @override
  Widget build(BuildContext context) {
    final catalogState = Provider.of<CatalogState>(context);
    //List<Catalog> catalogs;
    return ListView.builder(
    shrinkWrap: true,
    itemCount: catalogState.getCatlalogs.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: <Widget>[
          ListTile(
            onTap: (){
              
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