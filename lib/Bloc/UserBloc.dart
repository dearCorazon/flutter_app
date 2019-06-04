import 'dart:async';


import 'package:flutter/widgets.dart';
import 'package:flutter_app/Bean/User.dart';
import 'package:flutter_app/Log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc{
  User _user;
  
  StreamController<User> _streamController = new StreamController();
  Stream<User>  _stream;

  UserBloc(){
    Logv.Logprint("in UserBloc constructor:");
    _streamController=StreamController.broadcast();

    _stream=_streamController.stream;
    loadUser();
  }

  User get user=>_user;
  StreamController<User> get streamController=> _streamController;
  Stream<User> get  stream=>_stream;
  

  loadUser()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    int uid =sharedPreferences.getInt('userId');
    String email = sharedPreferences.getString('email');
    bool isLogin = sharedPreferences.getBool('isLogin');
    _user= User(email, uid,isLogin);
    await _streamController.sink.add(_user);
  }
  
  login(String email,int uid)async{
    _user = User(email,uid,true);
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isLogin', true);
    await sharedPreferences.setString('email', email);
    await sharedPreferences.setInt('userId', uid);
    await _streamController.sink.add(_user);
  }
  dispose(){
    _streamController.close();
  }

}