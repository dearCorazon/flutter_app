import 'package:flutter/foundation.dart';
import 'package:flutter_app/Log.dart';

class BottonBarState with ChangeNotifier{
  int index=0;
  loadIndex(int index){
    this.index= index;
    //Logv.Logprint("当前为第$index页");
    notifyListeners();
  }
}