// import 'package:flutter/material.dart';

// typedef void Submit(int answer);
// class MultipleChoiceWidget extends StatefulWidget{
//   //final List<String> answers;
//   //final Submit submit;
//   //final String question;
//   //final List<int> chosen;
//  // MultipleChoiceWidget({@required this.answers, @required this.question, @required this.chosen, @required this.submit});
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return new _MultipleChoiceState();
//   }
// }

// class _MultipleChoiceState extends State<MultipleChoiceWidget>{
//   List<String> alphabet = ['A', 'B', 'C', 'D', 'E', 'F'];
//   List<int> chosen;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     chosen = widget.chosen;
//     return new Container(
//       child: new Column(
//         children: <Widget>[
//           new Padding(padding: new EdgeInsets.all(10)),
//           new Row(
//             children: <Widget>[
//               new Expanded(child: new Container(), flex: 1),
//               new Expanded(
//                 flex: 10,
//                 child: new Text(
//                   widget.question,
//                   style: new TextStyle(
//                       fontSize: 18,
//                       letterSpacing: 2,
//                       color: Colors.black
//                   ),
//                   softWrap: true,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 5,
//                 ),
//               ),
//               new Expanded(child: new Container(), flex: 1),
//             ],
//           ),
//           new Padding(padding: new EdgeInsets.all(10)),
//           new Flexible(
//             child: new ListView.builder(
//               physics: BouncingScrollPhysics(),
//               itemCount: widget.answers.length,
//               itemBuilder: (context, index){
//                 return new Column(
//                   children: <Widget>[
//                     new Row(
//                       children: <Widget>[
//                         new Expanded(child: new Container(), flex: 1),
//                         new Expanded(
//                             flex: 10,
//                             child: new Container(
//                               child: new GestureDetector(
//                                 child: new Text(
//                                   alphabet[index]+". "+widget.question,
//                                   style: new TextStyle(
//                                       fontSize: 18,
//                                       color: chosen.contains(index) ? Colors.blue:Colors.black54
//                                   ),
//                                   softWrap: true,
//                                 ),
//                                 onTap: (){
//                                   if (widget.submit != null)
//                                     widget.submit(index);

//                                 },
//                               ),
//                             )
//                         ),
//                         new Expanded(child: new Container(), flex: 1),
//                       ],
//                     ),
//                     new Padding(padding: new EdgeInsets.all(5))
//                   ],
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }