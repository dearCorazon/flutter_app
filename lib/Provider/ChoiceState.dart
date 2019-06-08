import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChoiceState with ChangeNotifier{

  bool isShow = true;
  bool isTrue =false;
  bool isShowIcon=  true;


  
  Color seletedColor =Colors.red ;
  Color unselectedColor =Colors.red ;
  Icon icon;
  int  grop_value= 0;
 
  Icon icon_true  =  Icon(Icons.check,color:  Colors.green,);
  Icon icon_false  =  Icon(Icons.smoke_free,color:  Colors.red,);
  Icon _current ;


  void show(){
    isShow=!isShow;
    notifyListeners();
  }
  void showIcon(){
    isShowIcon=true;
    notifyListeners();
  }
  void trueAnswer(){
    isTrue= true;
    icon=icon_true;
    notifyListeners();
  }
  void fault(){
    isTrue=false;
    icon=icon_false;
    notifyListeners();
  }
  void  ShowIcon(){
    isShowIcon=false;
    notifyListeners();
  }

  void updateGroupValue(int value){
    grop_value=value;
  notifyListeners();
  }

  String answer;
  void loadanwer(){
    
  }

}