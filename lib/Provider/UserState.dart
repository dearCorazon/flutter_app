
import 'package:flutter/material.dart';

class UserState with ChangeNotifier{
  String _name= '本地用户';
  int _userid=-1;
  String _email='';
  bool _status =false;
  void fetchData(){
    
    ChangeNotifier();
  }
  void login(){
    _status=true;
  }
  
  int get  getId => _userid;
  String get getEmail => _email;
  bool get getStatus=> _status; 
}