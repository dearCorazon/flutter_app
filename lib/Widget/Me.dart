import 'package:flutter/material.dart';
import 'package:flutter_app/Widget/Login.dart';

class Me extends StatelessWidget {
  const Me({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("11"),),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('Picture/网络安全法.png')
                        )
                      ),
                    ),
                    Text("同步"),
                    ListTile(
                      isThreeLine: true,
                      title: Text("email"),
                      subtitle: Text("uid"),
                      trailing: IconButton(icon:Icon(Icons.arrow_right),onPressed:(){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>Login2()
                        ));
                      },),
                    )
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