

import 'package:flutter_app/Bean/NewsBean.dart';

class NewsModel{
  List<NewsBean> data;
  int length=0;
  NewsModel(this.data,this.length);
  NewsModel.fromJson(Map<String, dynamic> json){
    //:data  = (List.from(json['data']).map((i)=>News.fromJson(i));
     data = (List.from(json['data'])).map((i) => NewsBean.fromJson(i)).toList(); 
    (List.from(json['data'])).map((i){
       // NewsBean.fromJson(i);
        length++;
     }).toList();
  }

  // NewsModel process(NewsModel newsmodel){
  //   List<NewsBean> newslist= newsmodel.data;
  //   for (var news  in newslist){
  //     length++;
  //     if(news.title.contains("&quot")){
  //       news.title.replaceAll("&quot", '"');
  //     }
  //   }
  //   return NewsModel(newslist);
  // }
  @override
  String toString() {
     return "共$length篇文章"+data.toString();
  }
}