// import 'package:flutter/material.dart';
// import 'package:flutter_app/Bean/CatalogExtra.dart';
// import 'package:flutter_app/Bloc/CatalogExtraBloc.dart';
// import 'package:flutter_app/Widget/DropDownMenu.dart';
// import 'package:provider/provider.dart';

// class CatalogAppbar extends StatefulWidget {
//   CatalogAppbar({Key key}) : super(key: key);

//   _CatalogAppbarState createState() => _CatalogAppbarState();
// }

// class _CatalogAppbarState extends State<CatalogAppbar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: StreamBuilder<List<CatalogExtra>>(
//          initialData: Provider.of<CatalogExtraBloc>(context).catalogExtras2,
//          stream: Provider.of<CatalogExtraBloc>(context).stream2,
//          builder: (context, snapshot) {
//            return AppBar(
//              actions: <Widget>[
//                DropDownMenu_catalog2(),
//               // Text(snapshot.data.),
//              ],
//            );
//          }
//        ),
//     );
//   }
// }