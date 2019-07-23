import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/UserBean.dart';
import 'package:flutter_app/Bloc/UserBloc.dart';
import 'package:flutter_app/Bloc/WrongBookBloc.dart';
import 'package:flutter_app/Widget/Login.dart';
import 'package:flutter_app/Widget/NewsDetail.dart';
import 'package:flutter_app/Widget/Page/WrongBook.dart';
import 'package:provider/provider.dart';

class Me extends StatelessWidget {
  const Me({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final  wrongBloc = Provider.of<WrongBookBloc>(context);
    return Container(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    ),
                    StreamBuilder<UserBean>(
                        initialData: Provider.of<UserBloc>(context).user,
                        stream: Provider.of<UserBloc>(context).stream,
                        builder: (context, snapshot) {
                          return Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: <Widget>[
                              Card(
                                child: Container(
                                  height: 80.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Column(
                                          children: <Widget>[
                                            Text("奖励积分"),
                                            Text(snapshot.data.isLogin
                                                ? '${snapshot.data.score}'
                                                : '--')
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Container(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Column(
                                          children: <Widget>[
                                            Text("答题次数"),
                                            Text(snapshot.data.isLogin
                                                ? '${snapshot.data.numberofanswer}'
                                                : '--')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return Login2();
                                    }

                                  ));
                                },
                                child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blueAccent,
                                    child: Text(snapshot.data.isLogin
                                        ? '${snapshot.data.numberofanswer}'
                                        : '未登录')),
                              ),
                            ],
                          );
                        }),
                    // Center(
                    //   child: Card(
                    //     elevation: 1.5,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(15.0))),
                    //     clipBehavior: Clip.antiAlias,
                    //     chil[=d: Container(
                    //         child: Image.asset(
                    //       'lib/Picture/heading.png',
                    //       // scale: 0.2,
                    //     )),
                    //   ),
                    // ),
                    // Container(
                    //   child: Card(
                    //     child: ListTile(
                    //       leading: CircleAvatar(
                    //           backgroundColor: Colors.blueAccent,
                    //           child: Text("鑫")),
                    //       title: Text("email"),
                    //       subtitle: Text("uid"),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10, bottom: 20),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.account_balance_wallet),
                              title: Text("错题本"),
                              onTap: () async{
                                await wrongBloc.loadCatalog();
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return WrongBook();
                                  }

                                ));
                                
                              },
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.add_a_photo),
                              title: Text("收藏案例"),
                              onTap: () {},
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.data_usage),
                              title: Text("网络安全法总则"),
                              onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return NewsWebPage('https://duxiaofa.baidu.com/detail?searchType=statute&from=aladdin_28231&originquery=%E7%BD%91%E7%BB%9C%E5%AE%89%E5%85%A8%E6%B3%95&count=79&cid=f66f830e45c0490d589f1de2fe05e942_law',
                              '网络安全法总则');
                        }));
                      },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(),
      ),
    );
  }
}
