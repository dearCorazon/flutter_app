import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/User.dart';
import 'package:flutter_app/Bean/UserBean.dart';
import 'package:flutter_app/Bloc/UserBloc.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:provider/provider.dart';

import 'Card/CardsShowAll.dart';
class Mydrawer extends  StatelessWidget{
  const Mydrawer({
    Key key, }) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    //final userState =Provider.of<UserState>(context);
    final userBloc =Provider.of<UserBloc>(context);
      return  Drawer(
      child:   Container(
        child:   ListView(
          children: <Widget>[
              StreamBuilder<UserBean>(
                initialData: userBloc.user,
                stream: userBloc.stream,
                builder: (context, snapshot) {
                  return UserAccountsDrawerHeader(
                    accountName: Text(snapshot.data.uid.toString()),
                    accountEmail: Text(snapshot.data.email),
                    currentAccountPicture:  GestureDetector(
                      onTap:()=> Navigator.pushNamed(context, '/login'),
                      child:  Icon(Icons.account_circle,size: 40.0)
                   ),
                   decoration:  BoxDecoration(
                  image:  DecorationImage(
                      fit: BoxFit.fill,
                      image:  NetworkImage("https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2610059453,2498942292&fm=200&gp=0.jpg")
                      )
                  ),
                  );
                }
              ),
              ListTile(
              title: new Text("Deck"),
              trailing: new Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.of(context).pop();
                //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context));
              },
            ),
             ListTile(
              title :new Text("题库浏览"),
              trailing: new Icon(Icons.alternate_email),
              onTap:(){
                Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ShowAllCards();
                        } 
                      )
                  );

              },
            ),
             Divider(),
              ListTile(
              title: Text("Settings"),
              trailing: new Icon(Icons.settings),
              onTap: (){
              },
            )
          ],
        ),
      )

    );
  }
}
class Mydrawer1 extends StatelessWidget {
  //TODO:准备弃用
  const Mydrawer1({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    return Container(
      child: Drawer(
            child: Container(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text(userState.email),
                currentAccountPicture: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: Icon(Icons.account_circle, size: 40.0)),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2610059453,2498942292&fm=200&gp=0.jpg")
                              )
                              )
              ),
              ListTile(
                title: new Text("Deck"),
                trailing: new Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title:  Text("Card Browsers"),
                trailing:  Icon(Icons.alternate_email),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ShowAllCards();
                        } 
                      )
                  );
                },
              ),
              ListTile(
                title: Text("Test Browsers"),
                trailing: Icon(Icons.create),
              ),
              Divider(),
              ListTile(
                title: Text("Settings"),
                trailing: new Icon(Icons.settings),
                onTap: () {},
              )
            ],
          ),
        ),
    )
    );
}
}
