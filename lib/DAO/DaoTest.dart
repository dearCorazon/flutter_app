import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/Test.dart';
import 'package:flutter_app/Log.dart';
import 'TestDao.dart';

class DaoTest extends StatefulWidget{
 @override
  State<StatefulWidget> createState() {
    return DaoTestState();
  }
}
class DaoTestState extends State<DaoTest>{
  String result='';
  String question='';
  String id='';
  List<Test> tests=[];
  String questions='';
  String answers='';
  String ids='';
  @override
  void initState(){
    super.initState();
    loadlistdata();
  }
  void  loadlistdata()async{
    TestDao testDao = new TestDao();
    tests = await testDao.queryAll();
    setState(() {
      tests = tests;
  });
  Logv.Logprint("initState: length of tests :" + tests.length.toString());
}
  TextEditingController question_controller=new TextEditingController();
  TextEditingController answer_controller=new TextEditingController();
  Widget getRow(int index){
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
           
            Text(tests[index].question),
            Text(tests[index].answer),
            Row(
              children: <Widget>[
                Text(tests[index].id.toString()),
                RaisedButton(
                  child: Text("delete"),
                  onPressed: ()async{
                    TestDao testdao= new TestDao();
                    testdao.delete(tests[index].id);
                    loadlistdata();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("demo"),),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("show database"),
              onPressed: ()async{
                // Sqlite_helper sqlite_helper = new Sqlite_helper();
              }
            ),
            Text("null"),
            Divider(),
            TextField(
              controller: question_controller,

            ),
            TextField(
              controller: answer_controller,
            ),
            RaisedButton(
              child: Text("insert"),
              onPressed: ()async{
                  Logv.Logprint(question_controller.value.text+answer_controller.value.text);
                  Test test= Test.create(question_controller.text, answer_controller.text);
                  Logv.Logprint(test.toString());
                  TestDao testdao= new TestDao();
                  await testdao.insert(test);
              },
            ),
            RaisedButton(
              child: Text("显示"),
              onPressed: ()async{
                TestDao testdao=new TestDao();
                Test test= await testdao.query(1);
                setState((){
                  id=test.id.toString();
                  result=test.answer;
                  question=test.question;
                });
              },
            ),
            Text(id),
            Text(question),
            Text(result),
            Divider(),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tests.length,
                  itemBuilder:(BuildContext context,int index){
                    return getRow(index);
                  }
              ),
            )
          ],
        ),
      ),
    );
  }


}
