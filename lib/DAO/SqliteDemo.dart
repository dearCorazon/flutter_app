//TODO:abandoned?
// import 'package:sqflite/sqflite.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:async/async.dart';
// import 'dart:io';
// import 'package:flutter_app/Bean/Test.dart';

// import 'package:flutter_app/DAO/Sqlite_helper.dart';
// import 'package:flutter_app/Knowledge_bean.dart';

// class Sqlite_demo extends StatelessWidget{

//   KnowledgeSqlite knowledgeSqlite=new KnowledgeSqlite();
//   List<Knowledge_bean> knowledges;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("demo"),
//       ),
//       body:  Builder(
//         builder: (BuildContext context){
//           return Column(
//             children: <Widget>[
//               MaterialButton(
//                 child:  Text("插入数据1"),
//                 onPressed: ()async{
//                   print(knowledgeSqlite.insert(Knowledge_bean("testdemo")));
//                 },
//               ),
//               MaterialButton(
//                 child: Text("show all"),
//                 onPressed: ()async{
//                   List<Knowledge_bean> knowledegs=await knowledgeSqlite.queryAll();
//                   print("show all:");
//                   print(knowledegs.toList());
//                 },

//               ),
//               Text("记忆功能测试"),
//               //Text(content),
//               MaterialButton(
//                 child: Text("显示下一条消息"),
//                 onPressed: ()async{
//                   knowledges=await knowledgeSqlite.queryAll();
//                   print("一共有条"+knowledges.length.toString()+"数据");
//                   for(int i=0;i<knowledges.length;i++){
//                     print("id:"+knowledges[i].id.toString()+"内容为："+knowledges[i].content);
//                   }
//                 },
//               ),
//               MaterialButton(
//                 child: Text("update测试"),
//                 onPressed: ()async{
//                   knowledgeSqlite.update_status(1);
//                 },
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }

// }
