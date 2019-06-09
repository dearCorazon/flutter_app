import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/CatalogBean.dart';
import 'package:flutter_app/Bloc/ChoiceBloc.dart';
import 'package:flutter_app/Bloc/DropDownMenuBloc.dart';
import 'package:flutter_app/Bloc/JudgeBloc.dart';
import 'package:flutter_app/Bloc/MutiBloc.dart';
import 'package:flutter_app/Widget/Card/ChoiceCard.dart';
import 'package:flutter_app/Widget/Card/Judge.dart';
import 'package:flutter_app/Widget/Card/MutiChoice.dart';
import 'package:flutter_app/Widget/Page/chooseCatalog.dart';
import 'package:provider/provider.dart';

class BodyQuestion extends StatelessWidget {
  const BodyQuestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final choiceBloc = Provider.of<ChoiceBloc>(context);
    final mutiBloc = Provider.of<MutiBloc>(context);
    final judegBloc = Provider.of<JudgeBloc>(context);
    return Container(
      color: Colors.transparent,
      //color: Colors.transparent,
     
      margin: EdgeInsets.all(10.0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
             color: Colors.transparent,
            child: Column(
              children: <Widget>[
                catalogInformation(context),
                Card(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.ac_unit),
                          title: Text("单项选择"),
                          subtitle: Text("太阳每天都是新的"),
                          onTap: () async {
                            await choiceBloc.loadChoiceCard();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ChoiceCard();
                            }));
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.access_time),
                          title: Text("多项选择题"),
                          subtitle: Text("周而复始，如期而至"),
                          onTap: () async {
                            await mutiBloc.loadChoiceCard();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return MutiChoice();
                            }));
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.accessibility_new),
                          title: Text("判断题"),
                          subtitle: Text("每天进步一点点"),
                          onTap: () async {
                            await judegBloc.loadCards();
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Judge();
                            }));
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

Widget catalogInformation(BuildContext context) {
  return StreamBuilder<CatalogBean>(
    //initialData:  Provider.of<DropDownMenuBloc>(context).catalogBean,
    stream: Provider.of<DropDownMenuBloc>(context).stream,
    builder: (context, snapshot) {
      return snapshot.connectionState==ConnectionState.waiting?  CircularProgressIndicator():Container(
        child: Card(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text("学习次数"),
                              Text(snapshot.data.number==null?("还未答题"):(snapshot.data.number).toString()),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text("总题数"),
                              Text("${snapshot.data.quiznumber}个"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ListTile(
                  title: Text("${snapshot.data.catalogname}"),
                  trailing: FlatButton(
                    child: Text("切换题库"),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CatalogPage();
                        }));
                      
                    },
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "正确率:${(((snapshot.data.number-snapshot.data.faultnumber)/snapshot.data.number)*100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(icon:  Icon(Icons.data_usage),),
                            IconButton(icon:Icon(Icons.ac_unit),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  //TODO:后进度条的样式需要更改
                  child: Slider(
                    onChanged: (double value) {}, 
                    value: snapshot.data.number==0? 0.0: double.parse(((snapshot.data.number-snapshot.data.faultnumber)/snapshot.data.number).toStringAsFixed(2)),
                    )
                )
              ],
            ),
          ),
        ),
      );
    }
  );
}
