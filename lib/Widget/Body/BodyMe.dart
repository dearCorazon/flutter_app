import 'package:flutter/material.dart';
import 'package:flutter_app/Widget/Login.dart';

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
                    Center(
                      child: Card(
                        elevation: 1.5,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                            child: Image.asset(
                          'lib/Picture/heading.png',
                          // scale: 0.2,
                        )),
                      ),
                    ),
                    Divider(),
                    Card(
                      child: ListTile(
                        isThreeLine: true,
                        title: Text("email"),
                        subtitle: Text("uid"),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_right),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                        ),
                      ),
                    ),
                    Divider(),
                    Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.account_balance_wallet),
                            title: Text("挑战错题"),
                            subtitle: Text("挑战你的能力，给你超越的机会"),
                            onTap: () {},
                          )
                        ],
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
