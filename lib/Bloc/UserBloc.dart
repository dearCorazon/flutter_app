import 'dart:async';


import 'package:flutter/widgets.dart';
import 'package:flutter_app/Bean/User.dart';
import 'package:flutter_app/Bean/UserBean.dart';
import 'package:flutter_app/Log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc{
  UserBean _user;
  
  StreamController<UserBean> _streamController = new StreamController();
  Stream<UserBean>  _stream;

  UserBloc(){
    Logv.Logprint("in UserBloc constructor:");
    _streamController=StreamController.broadcast();
    _stream=_streamController.stream;
    loadUser();
  }

  UserBean get user=>_user;
  StreamController<UserBean> get streamController=> _streamController;
  Stream<UserBean> get  stream=>_stream;
  

  loadUser()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    int uid =sharedPreferences.getInt('userId');
    String email = sharedPreferences.getString('email');
    bool isLogin = sharedPreferences.getBool('isLogin');
    String name =sharedPreferences.getString('name');
    _user= UserBean(uid,name,email,isLogin);
    Logv.Logprint("in loadUser:"+_user.toMap().toString());
    await _streamController.sink.add(_user);
  }
  
  login(String email,int uid)async{
    _user = UserBean.createwithoutname(uid,email,true);
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