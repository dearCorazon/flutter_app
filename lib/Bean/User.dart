class User{
  int uid;
  String email;
  bool isLogin=false;
  User(this.email,this.uid,this.isLogin);
  @override
  String toString(){
    return "用户Id：$uid  email$email 是否登录$isLogin";
  }
}