import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/CatalogExtra.dart';
import 'package:flutter_app/Bloc/CardsBloc.dart';
import 'package:flutter_app/Bloc/CatalogExtraBloc.dart';
import 'package:flutter_app/Bloc/DropDownMenuBloc.dart';
import 'package:flutter_app/DAO/CatalogDao.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Provider/CardsAddState.dart';
import 'package:flutter_app/Provider/DropDownMenuState.dart';
import 'package:provider/provider.dart';

class DropDownMenu_type extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<DropDownMenu_type> {
  String dropdownValue='普通卡片';
  @override
  Widget build(BuildContext context) {
    final dropdownMenuState = Provider.of<DropDownMenuState>(context);
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String newValue) {
        dropdownMenuState.changeCardType(newValue);
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>["普通卡片", "单选题", "多选题","大题"]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropDownMenu_catalog extends StatefulWidget {
  List<String> catalogs;
  //List<String> get getcatalogs => catalogs;
  DropDownMenu_catalog(this.catalogs,{Key key}):super(key:key);
  @override
  _StateCatalog createState() => _StateCatalog(catalogs);
}

class _StateCatalog extends State<DropDownMenu_catalog> {
  CatalogDao catalogDao  = new CatalogDao();
  List<String> catalogs;
  _StateCatalog(this.catalogs); 
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCatalog;
  List<DropdownMenuItem<String>> getDropMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String catalog in catalogs) {
      items.add(DropdownMenuItem( 
        value: catalog,
        child: Text(catalog),
      ));
    }
    Logv.Logprint("length:" + items.length.toString());
    return items;
  }

  @override
  void initState() {
    Logv.Logprint("initState:");
    _dropDownMenuItems = getDropMenuItems();
    Logv.Logprint(
        "_dropDownMenuItems length:" + _dropDownMenuItems.length.toString());
    _currentCatalog = _dropDownMenuItems[0].value;
    Logv.Logprint("_currentCatalog Value:" + _currentCatalog);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final  dropDownMenuBloc= Provider.of<DropDownMenuBloc>(context);
    return DropdownButton<String>(
        value: _currentCatalog,
        onChanged: (String newValue) async{
          int chooseId= await catalogDao.getIdByName(newValue);
          await dropDownMenuBloc.setCatalogIdInShardPrefrence(chooseId);
          //dropDownMenuBloc.updateCatalogId(chooseId);
          Logv.Logprint('现在选择的catalogId为$chooseId');
          dropDownMenuBloc.loadInformation();
           setState(() {
            _currentCatalog = newValue;
          });
        },
        items: _dropDownMenuItems);
  }
}

class DropDownMenu_catalog2 extends StatefulWidget {
  //TODO:后续要改个名字
  //List<String> catalogs;
  //List<String> get getcatalogs => catalogs;
  //DropDownMenu_catalog2(this.catalogs,{Key key}):super(key:key);
  @override
  _StateCatalog2 createState() => _StateCatalog2();
}

class _StateCatalog2 extends State<DropDownMenu_catalog2> {
  List<String> catalogs;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCatalog='全部';
 
  @override
  void initState() {
    //TODO：后续没有操作的话 这里可以去掉
    Logv.Logprint("initState:");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catalogDropdownMunuState = Provider.of<DropDownMenuBloc>(context);
    return StreamBuilder<List<CatalogExtra>>(
      stream: Provider.of<CatalogExtraBloc>(context).stream2,
      initialData: Provider.of<CatalogExtraBloc>(context).catalogExtras2,
      builder: (context, snapshot) {
        return DropdownButton<String>(
            value: _currentCatalog,
            onChanged: (String newValue) async{
              await Provider.of<CatalogExtraBloc>(context).loadNumber(newValue);
              await Provider.of<CardsBloc>(context).loadCardByCatalogName(newValue); 
               setState(() {
               _currentCatalog = newValue;
              });
            },
            items: getDropDownMenuItem(snapshot),
        );
      }
    );
  }
}
List<DropdownMenuItem<String>>getDropDownMenuItem(AsyncSnapshot<List<CatalogExtra>> snapshot){
  List<String> names =[];
  List<DropdownMenuItem<String>> items = new List();
  for (var catalogExtra in snapshot.data){
    items.add(DropdownMenuItem(
      value:  catalogExtra.name,
      child: Text(catalogExtra.name),
    )
    );
  }
  return items;
}
// class DropDownMenu_catalog3 extends StatefulWidget {
//   List<String> catalogs;
//   List<String> get getcatalogs => catalogs;
//   //DropDownMenu_catalog2(this.catalogs,{Key key}):super(key:key);
//   @override
//   _StateCatalog2 createState() => _StateCatalog2();
// }

// class _StateCatalog3 extends State<DropDownMenu_catalog2> {
//   List<String> catalogs;
//   List<DropdownMenuItem<String>> _dropDownMenuItems;
//   String _currentCatalog='全部';
 
//   @override
//   void initState() {
//     //TODO：后续没有操作的话 这里可以去掉
//     Logv.Logprint("initState:");
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final catalogDropdownMunuState = Provider.of<DropDownMenuState>(context);
//     return StreamBuilder<List<CatalogExtra>>(
//       stream: Provider.of<CatalogExtraBloc>(context).stream2,
//       initialData: Provider.of<CatalogExtraBloc>(context).catalogExtras2,
//       builder: (context, snapshot) {
//         return DropdownButton<String>(
//             value: _currentCatalog,
//             onChanged: (String newValue) {
//               //catalogDropdownMunuState.loadCurrentCatologName(newValue);
//               //catalogDropdownMunuState.changeCurrentCatalogNumber(newValue);
//                setState(() {
//                _currentCatalog = newValue;
//               });
//             },
//             items: getDropDownMenuItem2(snapshot),
//         );
//       }
//     );
//   }
// }
// List<DropdownMenuItem<String>>getDropDownMenuItem2(AsyncSnapshot<List<CatalogExtra>> snapshot){
//   List<String> names =[];
//   List<DropdownMenuItem<String>> items = new List();
//   for (var catalogExtra in snapshot.data){
//     items.add(DropdownMenuItem(
//       value:  catalogExtra.name,
//       child: Text(catalogExtra.name),
//     )
//     );
//   }
//   return items;
// }


class DropDownMenu_catalog3 extends StatefulWidget {
  //TODO:后续要改个名字
  @override
  _StateCatalog3 createState() => _StateCatalog3();
}

class _StateCatalog3 extends State<DropDownMenu_catalog3> {
  CatalogDao catalogDao = new CatalogDao();
  List<String> catalogs;
  CatalogExtraBloc catalogExtraBloc= new CatalogExtraBloc();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentCatalog=null;
  @override
  Widget build(BuildContext context) {
    final catalogDropdownMunuState = Provider.of<DropDownMenuState>(context);
    final cardsAddState = Provider.of<CardsAddState>(context);
    //String _currentCatalog=Provider.of<CatalogExtraBloc>(context).catalogExtras[0].name;
    return StreamBuilder<List<CatalogExtra>>(
      stream: Provider.of<CatalogExtraBloc>(context).stream,
      initialData: Provider.of<CatalogExtraBloc>(context).catalogExtras,
      builder: (context, snapshot) {
        return DropdownButton<String>(
            value:_currentCatalog,
            //TODO:这里如何获取到第一个信息？
            onChanged: (String newValue) async{
               int catalogId= await catalogDao.getIdByName(newValue);
               cardsAddState.loadCatalogId(catalogId);
               //catalogDropdownMunuState.
               setState(() {
               _currentCatalog=newValue;
              });
            },
            items: getDropDownMenuItem(snapshot),
        );
      }
    );
  }
}