import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Bean/NewsModel.dart';
import 'package:flutter_app/Bloc/NewsBloc.dart';
import 'package:flutter_app/Widget/NewsDetail.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class BodyNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsBloc = Provider.of<NewsBloc>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          print("refresh");
          newsBloc.loadNews();
        },
        child: StreamBuilder<NewsModel>(
            stream: Provider.of<NewsBloc>(context).stream,
            initialData: Provider.of<NewsBloc>(context).newsModel,
            builder: (context, snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NewsWebPage(snapshot.data.data[index].url,
                              snapshot.data.data[index].title);
                        }));
                      },
                      title: Text(snapshot.data.data[index].title),
                      subtitle: Row(
                        children: <Widget>[
                          Text(snapshot.data.data[index].posterScreenName),
                          Text(snapshot.data.data[index].dateString)
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
