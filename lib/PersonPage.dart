import 'package:flutter/material.dart';
class PersonPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return personPageState();
  }
}
class personPageState extends State<PersonPage>{

  @override
  Widget build(BuildContext context) {
    String name='null';
    String passwd='null';
    TextEditingController nameController= new TextEditingController();
    //nameController.addListener(listener);
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.grey,
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
              color: Colors.grey,
              icon: Icon(Icons.account_balance),
              onPressed: null
          )
        ],
      ),
      body:Container(
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text){
                name  =text;
                print(name);
                setState(() {
                  name=text;
                });
              },
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name ',
              ),
            ),
            Text(name),
            RaisedButton(
              onPressed: (){
                setState(() {
                  name=nameController.text;
                });
              },
            )
          ],
        ),
      )
    );



  }

}
