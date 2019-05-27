import 'package:flutter/material.dart';
import 'package:flutter_app/Provider/CatalogState.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:flutter_app/Widget/ShowAllCards.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/Model/userModel.dart';
class MDrawer extends  StatelessWidget{
  const MDrawer({
    Key key, }) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    return  Drawer(
      child:   Container(
        child:   ListView(
          children: <Widget>[
              ScopedModel<userModel>(
                model: userModel(),
                child: UserAccountsDrawerHeader(
                  accountName: ScopedModelDescendant<userModel>(
                    builder: (context,child,model)=> Text('${model.name}'),
                  ),
                  accountEmail: ScopedModelDescendant<userModel>(
                    builder: (context,child,model)=> Text('${model.email}'),
                  ),
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
                ),

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
              title :new Text("Card Browsers"),
              trailing: new Icon(Icons.alternate_email),
              onTap:(){
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
              onTap: (){
              },
            )
          ],
        ),
      )

    );
  }
}
class Mydrawer extends StatelessWidget {
  const Mydrawer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    return Container(
      child: Drawer(
            child: Container(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text(userState.getEmail),
                accountName: Text("UID:"+userState.getId.toString()),
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
