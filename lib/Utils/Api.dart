import 'package:dio/dio.dart';
import 'package:flutter_app/Log.dart';
//　注册http://148.70.98.252:8080/Testv/register?email=example@qq.com&password=1223123
//登录　http://148.70.98.252:8080/Testv/login?email=example@qq.com&password=1223123
class Api{
  void register(String email, String  password)async{
    Dio dio = new Dio();
    var url ='http://148.70.98.252:8080/Testv/register?email=$email&password=$password';
    await Dio().get(url);
  }
  Future<int> login(String email,String password)async{
    Dio dio = new Dio();
    var url='http://148.70.98.252:8080/Testv/login?email=$email&password=$password';
    Response response = await dio.get(url);
    Logv.Logprint("Api:********************************login\n"+response.data.toString());
    return int.parse(response.data.toString());
  }
  Future<String> getZhengzhi()async{
    Dio dio = new Dio();
    var url='http://148.70.98.252:8080/Testv/getbanklist';
    Response response = await dio.get(url);
    Logv.Logprint("Api:********************************login\n"+response.data.toString());
    return response.data;
    }
}