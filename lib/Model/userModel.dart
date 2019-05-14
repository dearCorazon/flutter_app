import 'package:scoped_model/scoped_model.dart';
class userModel extends Model{
  String  _email='no email';
  String  _name = 'no name';

  String get email => _email;
  String get name => _name;

  void change_info(String email,String name){
    _email=email;
    _name=name;
    notifyListeners();

  }
}