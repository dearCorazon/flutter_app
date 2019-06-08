import 'package:flutter/material.dart';
import 'package:flutter_app/Bloc/ChoiceBloc.dart';
import 'package:flutter_app/Bloc/JudgeBloc.dart';
import 'package:flutter_app/Bloc/MutiBloc.dart';
import 'package:flutter_app/Widget/Card/ChoiceCard.dart';
import 'package:flutter_app/Widget/Card/Judge.dart';
import 'package:flutter_app/Widget/Card/MutiChoice.dart';
import 'package:provider/provider.dart';

class BodyQuestion extends StatelessWidget {
  const BodyQuestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choiceBloc = Provider.of<ChoiceBloc>(context);
    final mutiBloc = Provider.of<MutiBloc>(context);
    final judegBloc = Provider.of<JudgeBloc>(context);
    return Container(
      margin:EdgeInsets.all(20.0) ,
      child: Scaffold(
        body: SingleChildScrollView(
                  child: Container(
            child: Column(
              children: <Widget>[
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
                              child: Column(
                                children: <Widget>[
                                  Text("奖励积分"),
                                  Text('--')
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
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
                      backgroundColor: Colors.blueAccent,
                      child:
                      Text("鑫")),
                  ],
                ),
                Card(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.ac_unit),
                          title: Text("单项选择"),
                          subtitle: Text("太阳每天都是新的"),
                          onTap: ()async{
                            await choiceBloc.loadChoiceCard();

                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return ChoiceCard();
                            }

                            ));
                            
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text("多项选择题"),
                          subtitle: Text("周而复始，如期而至"),
                          onTap: ()async{
                            await mutiBloc.loadChoiceCard();
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return MutiChoice();
                            }
                            ));
                            
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.accessibility_new),
                          title:Text("判断题"),
                          subtitle: Text("每天进步一点点"),
                          onTap: ()async{
                            await judegBloc.loadCards();
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return Judge();
                            }
                            ));
                          },
                        )
                      ],
                    ),
                  ),
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
