import "package:flutter/material.dart";
import 'Drawer.dart';
class HomePage extends StatelessWidget{
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text("添加"),
        onPressed: (){},
      ),
      appBar:  AppBar(
          title: Text('demo'),
          actions: <Widget>[
              MaterialButton(
                child:  Text("db"),
                onPressed: (){
                  Navigator.pushNamed(context, "/daotest");
                }
              ),
              IconButton(
                  icon: Icon(Icons.sync),
                  onPressed: () {}
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){},
              ),
            ],
          ),
      drawer: MDrawer(),
      body:  Container(
        child:Text("09"),
        
        
      )
       
       );
  }
}