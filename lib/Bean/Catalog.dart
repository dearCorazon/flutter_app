final String Columnid='id';
final String Columnname='name';
final String ColumnsuperiorId='superiorId';
//static final _sql_createTableCatalog='CREATE TABLE CATALOG(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,name TEXT,superiorId INTEGER)';

class Catalog{
  int id;
  String name;
  int superiorId;
  Catalog.create(String name){
    this.name=name;
    superiorId= -1;
  }
  Catalog.createWithSuperior(String name,int superiorId){
    this.name=name;
    this.superiorId=superiorId;
  }
  Catalog.fromMap(Map<String,dynamic> map){
    id=map[Columnid];
    name=map[Columnname];
    superiorId=map[ColumnsuperiorId];
  }
   Map<String,dynamic> toMap(){
    var map =<String,dynamic>{
      Columnid:id,
      Columnname:name,
      ColumnsuperiorId:superiorId,
    };
    return map;
  }
  @override
  String toString(){
    return "id:"+id.toString()+" name:"+name+" superiorId:"+superiorId.toString();

  }
  }