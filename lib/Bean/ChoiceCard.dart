class ChoiceCardBean {
  // static final sql_table_ChoiceCard='create table choice(id integer not null primary key autoincrement,
  // catalogId integer,
  //  star integer,
  //  catalogname text,
  //  number integer,
  //  faultnumber integer,
  //  answer text,
  //  chaos1 text,
  //  chaos2 text,
  //  chaos3 text,
  //  question text)';

  int id;
  int catalogId=1;
  String catalogname='默认';
  int number=0;
  int faultnumber=0;
  String question;
  String answer;
  String chaos1;
  String chaos2;
  String chaos3;
  String chaos4;
  ChoiceCardBean.creat(this.question,this.answer,this.chaos1,this.chaos2,this.chaos3,this.chaos4);
  ChoiceCardBean.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    catalogId = map['catalogId;'];
    catalogname = map['catalogname'];
    number = map['number'];
    faultnumber = map['faultnumber'];
    question = map['question'];
    answer = map['answer'];
    chaos1 = map['chaos1'];
    chaos2 = map['chaos2'];
    chaos3 = map['chaos3'];
    chaos4= map['chaos4'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'catalogId': catalogId,
      'catalogname': catalogname,
      'number': number,
      'faultnumber': faultnumber,
      'question': question,
      'answer': answer,
      'chaos1': chaos1,
      'chaos2': chaos2,
      'chaos3': chaos3,
      'chaos4': chaos4,
    };
    return map;
  }
}
