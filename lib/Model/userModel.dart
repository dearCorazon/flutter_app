import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class userModel extends Model{
  userModel(){
    _init();
  }
  String  _email='no email(not sign)';
  String  _name = 'no name(not sign)';

  String get email => _email;
  String get name => _name;
  _init()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('name', 'name(not sign)');
    await sharedPreferences.setString('email', 'null(not sign)');
  }
  void change_info(String email,String name)async{
    _email=email;
    _name=name;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("name", name);
    await sharedPreferences.setString("email", email); 
    notifyListeners();

  }
}