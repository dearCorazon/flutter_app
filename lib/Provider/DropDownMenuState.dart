
import 'package:flutter/material.dart';

class DropDownMenuState with ChangeNotifier{
  String _catalogselected ='';
  void get getcatalog => _catalogselected;
  void updateCatalog(String catalogselected){
    _catalogselected = catalogselected;
    notifyListeners();
  }

}