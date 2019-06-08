import 'dart:convert';

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
  Future<String> getNews()async{
    Dio dio= new Dio();
    var url2='http://api01.idataapi.cn:8000/news/qihoo?kw=%E7%BD%91%E7%BB%9C%E5%AE%89%E5%85%A8&apikey=224R21RTiRmm3V4p2ETzeoGYq09JP5o2Kg0PqbN9tGvAU4ECJaPV0kfjnxfEg4eH';
    var  url3= 'http://api01.idataapi.cn:8000/news/qihoo?kw=%E7%BD%91%E7%BB%9C%E5%AE%89%E5%85%A8&site=qq.com&apikey=224R21RTiRmm3V4p2ETzeoGYq09JP5o2Kg0PqbN9tGvAU4ECJaPV0kfjnxfEg4eH';
    var url  ='http://api01.idataapi.cn:8000/news/qihoo?kw=%E7%BD%91%E7%BB%9C%E5%AE%89%E5%85%A8%E6%B3%95&site=qq.com&apikey=224R21RTiRmm3V4p2ETzeoGYq09JP5o2Kg0PqbN9tGvAU4ECJaPV0kfjnxfEg4eH';
    //var url1= 'http://api01.idataapi.cn:8000/news/qihoo?apikey={224R21RTiRmm3V4p2ETzeoGYq09JP5o2Kg0PqbN9tGvAU4ECJaPV0kfjnxfEg4eH}&kw=网络完全法&site=qq.com';
    //var url ='http://api01.idataapi.cn:8000/news/qihoo?kw=%E7%BD%91%E7%BB%9C%E5%AE%89%E5%85%A8&site=qq.com&apikey=224R21RTiRmm3V4p2ETzeoGYq09JP5o2Kg0PqbN9tGvAU4ECJaPV0kfjnxfEg4eH';
    Response response= await dio.get(url3);
   // Logv.Logprint("dio news test"+response.toString());
    return response.toString();
  }
}