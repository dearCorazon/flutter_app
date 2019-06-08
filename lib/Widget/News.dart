import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class News extends StatelessWidget {
  const News({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("案例"),
        
        ),
        body: Container(
          child: 
            Column(
              children: <Widget>[
                Swiper(
                  itemCount: 3,
                  itemBuilder: (BuildContext context,int index){
                    return new Image.network("",fit :BoxFit.fill);
                  },
                ),
              ListView.builder(
                itemBuilder: (BuildContext conetext,int index){
                  
                },
              )
              ],
              
            ),
        ),
      ),
    );
  }
}
