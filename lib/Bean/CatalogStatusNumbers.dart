import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/Utils/Prefab.dart';
class CatalogStatusNumbers{
  int catalogId;
  int number;
  int status1;
  int status2;
  int status3;
  int status4;
  CatalogStatusNumbers.create(this.catalogId,this.number,this.status1,this.status2,this.status3,this.status4);
   Map<String,dynamic> toMap(){
    var map =<String,dynamic>{
      ColumnCatalogId:catalogId,
      Columnnumber:number,
      Columnstatus1:status1,
      Columnstatus2:status2,
      Columnstatus3:status3,
      Columnstatus4:status4,
    //  Columnallcards:allcards,
    };
    return map;
  }

  CatalogStatusNumbers.fromMap(Map<String ,dynamic> map){
    catalogId=map[ColumnCatalogId];
    number=map[Columnnumber];
    status1=map[Columnstatus1];
    status2=map[Columnstatus2];
    status3=map[Columnstatus3];
    status4=map[Columnstatus4];
  }
@override
String toString(){
  return "catalogId:$catalogId,number:$number,status1:$status1,status2:$status2,status3:$status3,status4:$status4\n";
}

}