import "package:flutter/material.dart";
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';

class ShowCatalog extends StatefulWidget {
  //TODO:参考准备弃用
  @override
  _State createState() => _State();
}
class _State extends State<ShowCatalog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      FutureBuilder(
                future: _getRow(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Text('loading...');
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else
                        return createListView(context, snapshot);
                  }
                },
              ),
      
    );
  }
}

Future<List<Catalog>> _getRow() async {
  var catalogs = new List<Catalog>();
  CatalogDao catalogDao = new CatalogDao();
  catalogs = await catalogDao.queryAll();
  return catalogs;
}
Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Catalog> catalogs = snapshot.data;
  return ListView.builder(
    shrinkWrap: true,
    itemCount: catalogs.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(
                "id " + catalogs[index].id.toString() + catalogs[index].name),
            subtitle: Text("superior:" + catalogs[index].superiorId.toString()),
          ),
          Divider(
            height: 2.0,
          ),
        ],
      );
    },
  );
}