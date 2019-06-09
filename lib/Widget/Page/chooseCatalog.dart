import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Catalog.dart';
import 'package:flutter_app/Bean/CatalogBean.dart';
import 'package:flutter_app/Bloc/CatalogBloc.dart';
import 'package:flutter_app/Bloc/DropDownMenuBloc.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Widget/DropDownMenu.dart';
import 'package:provider/provider.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catalogBloc = Provider.of<CatalogBloc>(context);
    return Container(
      child: Scaffold(
          appBar: AppBar(),
          body: Container(
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("选择题库"),
                        //subtitle: DropDownMenu_catalog2(),
                      ),
                      ListTile(
                          title: DropDownMenu_catalog(catalogBloc.catalognames),
                          )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: StreamBuilder<CatalogBean>(
                    initialData: Provider.of<DropDownMenuBloc>(context).catalogBean,
                    stream: Provider.of<DropDownMenuBloc>(context).stream,
                    builder: (context, snapshot) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(title: Text(snapshot.data.choicenumber.toString()),),
                            ListTile(title: Text(snapshot.data.mutinumber.toString()),),
                            ListTile(title: Text(snapshot.data.judgenumber.toString()),),
                            ListTile(title: Text(snapshot.data.number.toString()),),
                          ],
                        ),
                      );
                    }
                  ),
                )
                // RaisedButton(
                //   child: Text("asd"),
                // )
              ],
            ),
          )),
    );
  }
}

Widget getList(BuildContext context) {
  return StreamBuilder(
      initialData: Provider.of<CatalogBloc>(context).catalogs,
      stream: Provider.of<CatalogBloc>(context).stream,
      builder: (BuildContext context, AsyncSnapshot<List<Catalog>> snapshot) {
            //return DropDownMenu_catalog(snapshot.data);
      }
    );
}
Widget getDropDownMenu(){
  return DropdownButton<Catalog>(
   // value:  ,
    items: <DropdownMenuItem<Catalog>>[
      

    ], 
    onChanged: (value) {
      
    },
    
  );
}

