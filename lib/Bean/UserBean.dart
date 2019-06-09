class UserBean{
  String name;
  int uid;
  String email;
  int score=0;
  bool isLogin;
  int numberofanswer=0;
  UserBean(this.uid,this.name,this.email,this.isLogin);
  UserBean.createwithoutname(this.uid,this.email,this.isLogin);
  UserBean.fromMap(Map<String,dynamic> map){
    name=map['name'];
    uid= map['uid'];
    email= map['email'];
    score= map['score'];
    isLogin=map['isLogin'];
    numberofanswer=map['numberofanswer'];
  }
   Map<String,dynamic> toMap(){
    var map =<String,dynamic>{
      'uid':uid,
      'name':name,
      'email':email,
      'score':score,
      'isLogin':isLogin,
      'numberofanswer':numberofanswer
    };
    return map;
  }

}