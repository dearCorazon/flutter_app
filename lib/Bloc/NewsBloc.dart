import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/Bean/NewsBean.dart';
import 'package:flutter_app/Bean/NewsModel.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Utils/Api.dart';
import 'package:provider/provider.dart';

class NewsBloc {
  StreamController<NewsModel> _streamController = new StreamController();
  Stream<NewsModel> _stream;
  NewsModel _newsModel;

  NewsBloc() {
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
    loadNews();
  }

  NewsModel get newsModel => _newsModel;
  Stream<NewsModel> get stream => _stream;

  loadNews() async {
    Api api = new Api();
    NewsModel newsModel;
    String jsonString = await api.getNews();
    var json = jsonDecode(jsonString);
    //_newsModel = NewsModel.fromJson(json);
    //_newsModel= process(_newsModel);
    newsModel = NewsModel.fromJson(json);
    newsModel =  process(newsModel);
    _newsModel = newsModel;
    await _streamController.sink.add(_newsModel);
  }

  dispose() {
    _streamController.close();
  }

  NewsModel process(NewsModel newsmodel) {
    int length=0;
    List<NewsBean> newslist = newsmodel.data;
    for (var news in newslist) {
      length++;
      news.title= news.title.replaceAll('&quot;', '"');
      //Logv.Logprint("处理后的title"+news.title);
    }
    //Logv.Logprint(NewsModel(newslist,length).toString());
    return NewsModel(newslist,length);
  
  }
}
