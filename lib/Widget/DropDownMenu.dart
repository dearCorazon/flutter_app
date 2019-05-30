import 'package:flutter/material.dart';
import 'package:flutter_app/Log.dart';
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
  List<String> get getcatalogs => catalogs;
  DropDownMenu_catalog(this.catalogs,{Key key}):super(key:key);
  @override
  _StateCatalog createState() => _StateCatalog(catalogs);
}

class _StateCatalog extends State<DropDownMenu_catalog> {
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
    final catalogDropdownMunuState = Provider.of<DropDownMenuState>(context);
    return DropdownButton<String>(
        value: _currentCatalog,
        onChanged: (String newValue) {
          catalogDropdownMunuState.loadCurrentCatologName(newValue);
          catalogDropdownMunuState.changeCurrentCatalogNumber(newValue);
           setState(() {
            _currentCatalog = newValue;
          });
        },
        items: _dropDownMenuItems);
  }
}

