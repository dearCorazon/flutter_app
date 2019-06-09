import 'package:flutter_app/Log.dart';

class CatalogBean{
  int catalogId;
  String catalogname;
  int choicenumber=0;
  int mutinumber=0;
  int number=0;
  int judgenumber=0;
  int faultnumber=0;
  int quiznumber;
  CatalogBean(this.catalogname);
  CatalogBean.create(this.catalogId,this.choicenumber,this.mutinumber,this.number,this.faultnumber,this.judgenumber,this.catalogname,this.quiznumber);
  CatalogBean.fromMap(Map<String, dynamic> map){
    catalogId=map['id'];
    catalogname = map['catalogname'];
    choicenumber= map['choicenumber'];
    mutinumber=map['mutinumber'];
    number=map['number'];
    judgenumber=map['judgenumber'];
    faultnumber=map['faultnumber'];
    quiznumber=map['quiznumber'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'catalogId': catalogId,
      'catalogname': catalogname,
      'number': number,
      'choicenumber': choicenumber,
      'mutinumber': mutinumber,
      'judgenumber':judgenumber,
      'faultnumber':faultnumber,
      'quiznumber':quiznumber,
    };
    return map;
  }
  @override
  String toString() {
    Logv.Logprint("in CatalogBean toString");
    return "$catalogId $catalogname 答题总数$number 单选$choicenumber 多选$mutinumber 判断$judgenumber 总数$quiznumber 错题数$faultnumber" ;
  }
}
