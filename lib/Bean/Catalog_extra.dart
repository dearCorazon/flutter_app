import 'package:flutter_app/Bean/Catalog.dart';
class Catalog_extra extends Catalog{
  int cards;
  int status1numbers;
  int status2numbers;
  int status3numbers;
  int status4numbers;
  
  Catalog_extra.create(String name,int cards) : super.create(name){
    this.cards=cards;
  }
  Catalog_extra.fromMap(Map<String,dynamic> map):super.fromMap(map){
    this.cards=map[Columncards];
  }
  Map<String,dynamic> toMap(){
    var map =<String,dynamic>{
      Columnid:id,
      Columnname:name,
      ColumnsuperiorId:superiorId,
      Columncards:cards,
    };
    return map;
  } 

  @override
  String toString(){
    return " id:"+id.toString()+" name:"+name+" superiorId:"+superiorId.toString()+" cards:$cards";
  }
}