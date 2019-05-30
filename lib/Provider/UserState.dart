
import 'package:flutter/material.dart';

class UserState with ChangeNotifier{
  
  int userid=1;
  String email='未登录';
  bool status =false;
  void update(int id , String email){
    this.userid = id;
    this.email=email;
    notifyListeners();
  }
  void login(int id , String email){
    update(id,email);
    status=true;
    notifyListeners();
  }
  
}