import 'package:flutter/material.dart';
import 'package:flutter_app/Bean/ChoiceCard.dart';
import 'package:flutter_app/Bloc/ChoiceBloc.dart';
import 'package:provider/provider.dart';

class statics extends StatelessWidget {
  const  statics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //appBar: AppBar(),
        body:Container(
          child: 
          Column(
            children: <Widget>[
              Expanded(child: Container(
                child:
                createListChoice(context)

              )),
              Expanded(child: Container(

              )),
              Expanded(child: Container(

              ))
            ],
          ),
        )
      ),
    );
  }
}
Widget createListChoice(BuildContext context){
  return StreamBuilder<List<ChoiceCardBean>>(
    initialData: Provider.of<ChoiceBloc>(context).card,
    stream: Provider.of<ChoiceBloc>(context).stream,
    builder: (context, snapshot) {
      return ListView.builder(
        itemCount: snapshot.data.length, 
        itemBuilder: (BuildContext context, int index) {
          Text(snapshot.data[index].question);
        },
      );
    }
  );
}