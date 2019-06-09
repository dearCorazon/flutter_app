class JudgementBean {
  int id;
  String question;
  String answer;
  int number = 0;
  int faultnumber = 0;
  int catalogId = 1;
  int star = 0;
  String catalogname = '默认';

  JudgementBean.create(String question, String answer) {
    this.question = question;
    this.answer = answer;
    assert(answer=='true'||answer=='false');
  }
  JudgementBean.create2(String question, String answer) {
    this.question = question;
     catalogId = 2;
    this.answer = answer;
    assert(answer=='true'||answer=='false');
  }

  JudgementBean.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    catalogId = map['catalogId;'];
    catalogname = map['catalogname'];
    number = map['number'];
    faultnumber = map['faultnumber'];
    question = map['question'];
    answer = map['answer'];
    star = map['star'];
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
      'star': star
    };
    return map;
  }
  @override
  String toString() {
    // TODO: implement toString
    return "qustion: $question,answer$answer";
  }
}
