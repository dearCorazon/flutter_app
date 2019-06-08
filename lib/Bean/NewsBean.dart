import 'package:flutter_app/Utils/ProcessJson.dart';

class NewsBean {
  String title;
  String posterScreenName;
  String url;
  String content;
  List<String> imageUrl;
  String imageUrls;
  String dateString;
  
  
  NewsBean.fromJson(Map<String ,dynamic> json)
  :
    title=json['title'],
    url=json['url'],
    content=json['content'],
    imageUrls=json['imageUrls'].toString(),
    posterScreenName=json['posterScreenName'],
    dateString=json['publishDateStr'].toString();
  @override
  String toString() {
    return "$imageUrls";
  }
}