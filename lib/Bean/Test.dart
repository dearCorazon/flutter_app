
final String ColumnId ='id';
final String ColumnAdderId ='adderId';
final String ColumnQuestion ='question';
final String ColumnAnswer='answer';
final String ColumnType='type';
final String ColumnCatalogId='catalogId';
final String ColumnTagID='tag';
final String ColumnChaos='chaos';

class Test{
  int id;
  int adderId;
  String question;
  String answer;
  int type;
  int catalogId;
  int tag;//TODO:后期改为json
  String chaos;//json
  Test(String question,String answer,int type,int catalogId,int adderId){
    this.question=question;
    this.answer=answer;
    this.type=type;
    this.catalogId=catalogId;
    this.adderId=adderId;
  }
  Test.create(String question,String answer){
    this.question=question;
    this.answer=answer;
    this.type=-1;
    this.catalogId=-1;
    this.adderId=-1;
  }

  Test.fromMap(Map<String ,dynamic> map){
    id=map[ColumnId];
    adderId=map[ColumnAdderId];
    question=map[ColumnQuestion];
    answer=map[ColumnAnswer];
    type=map[ColumnType];
    catalogId=map[ColumnCatalogId];
    tag=map[ColumnTagID];
    chaos=map[ColumnChaos];
  }

  Map<String ,dynamic> toMap(){
    var map =<String,dynamic>{
      ColumnId:id,
      ColumnAdderId:adderId,
      ColumnQuestion:question,
      ColumnAnswer:answer,
      ColumnType:type,
      ColumnTagID:tag,
      ColumnChaos:chaos,
      ColumnCatalogId:catalogId
    };
    return map;
  }
  @override
  String toString() {
    return "id:${id.toString()}  question:$question  answer:$answer,catalogid:$catalogId";
  }
}
