import 'package:flutter/material.dart';

class Me extends StatelessWidget {
  const Me({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                       padding: EdgeInsets.only(top: 20.0,bottom: 20.0),
                     ),
                     Stack(
                      alignment:  AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Card(
                          child: Container(
                            height: 80.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: <Widget>[
                                      Text("奖励积分"),
                                      Text('--')
                                    ],
                                  ),
                                ),
                                Divider(),
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: <Widget>[
                                      Text("答题次数"),
                                      Text("--")
                                    ],
                                  ),

                                )
                              ],
                          ),
                          ),
                        ),
                        CircleAvatar(

                        radius: 30,
                          backgroundColor: Colors.blueAccent,
                          child:
                          Text("鑫")),
                      ],
                    ),
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
                              title: Text("挑战错题"),
                              onTap: () {},
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
