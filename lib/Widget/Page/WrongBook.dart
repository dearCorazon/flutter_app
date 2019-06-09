import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/CatalogBean.dart';
import 'package:flutter_app/Bloc/ChoiceBloc.dart';
import 'package:flutter_app/Bloc/MutiBloc.dart';
import 'package:flutter_app/Bloc/WrongBookBloc.dart';
import 'package:flutter_app/Widget/Card/ChoiceCard.dart';
import 'package:flutter_app/Widget/Card/Judge.dart';
import 'package:flutter_app/Widget/Card/MutiChoice.dart';
import 'package:flutter_app/Widget/Wrongbook/WJudge.dart';
import 'package:provider/provider.dart';

class WrongBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wrongbookBloc = Provider.of<WrongBookBloc>(context);
    return Container(
      child: Scaffold(
          appBar: AppBar(),
          body: Container(
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("错题本"),
                        //subtitle: DropDownMenu_catalog2(),
                      ),
                      
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: StreamBuilder<CatalogBean>(
                   initialData: Provider.of<WrongBookBloc>(context).catalogBean,
                    stream: Provider.of<WrongBookBloc>(context).catalogStream,
                    
                    builder: (context, snapshot) {
                      final mutiBloc = Provider.of<MutiBloc>(context);
                      final choiceBloc = Provider.of<ChoiceBloc>(context);
                      return Card(
                        child: Column(
                          children: <Widget>[
                             ListTile(
                          leading: Icon(Icons.ac_unit),
                          title: Text("总数"),
                          subtitle: Text(snapshot.data.quiznumber.toString()),
                        ),
                            ListTile(
                          leading: Icon(Icons.ac_unit),
                          title: Text("单项选择"),
                          subtitle: Text(snapshot.data.choicenumber.toString()),
                          onTap: snapshot.data.choicenumber==0?()=>null:()async{
                            await choiceBloc.loadWrongBook();
                            await  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                               return ChoiceCard();
                              }
                                
                              ));
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text("多项选择题"),
                          subtitle:Text(snapshot.data.mutinumber.toString()),
                          onTap: snapshot.data.mutinumber==0?()=>null:()async{
                            await mutiBloc.loadWrongBook();
                            await  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                return MutiChoice();
                              }
                                
                              ));
                          },
                          
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.accessibility_new),
                          title: Text("判断题"),
                          subtitle: Text(snapshot.data.judgenumber.toString()),
                          onTap: snapshot.data.judgenumber==0?()=>null:()async{
                            await wrongbookBloc.loadJudge();
                             await  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                return WJudge();
                              }
                                
                              ));
                          },
                          
                        )
                            // ListTile(title: Text("选择题"+snapshot.data.choicenumber.toString()),),
                            // ListTile(title: Text(snapshot.data.mutinumber.toString()),),
                            // ListTile(title: Text(snapshot.data.judgenumber.toString()),),
                            // ListTile(title: Text(snapshot.data.number.toString()),),
                          ],
                        ),
                      );
                    }
                  ),
                )
                // RaisedButton(
                //   child: Text("asd"),
                // )
              ],
            ),
          )),
    );
  }
}