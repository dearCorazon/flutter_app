import 'package:flutter/material.dart';

class FetchCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("获取共享题库"),
         
      ),
      body: Container(
        child: Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context,int index ){
              return Column(
                children: <Widget>[
                  Card(),
                  Divider(),
                ],
              );

            },
            
          ),
        ),
      ),
    );
  }
}