import 'package:flutter/material.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Model/userModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _emailController= new TextEditingController();;
    return new Scaffold(
        appBar: new AppBar(
          title:  new Text("login"),
          leading: IconButton(icon: Icon(Icons.arrow_back)),
        ),
        body:Container(
          child: Column(
            children: <Widget>[
              TextField(
                textAlign: TextAlign.center,
                controller: _emailController,
                decoration: InputDecoration(
                  
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _nameController,
              ),
              Row(
                children: <Widget>[
                  ScopedModel<userModel>(
                    model: userModel(),
                    child: RaisedButton(
                      child: Text("login"),
                      onPressed: (){
                          
                          Logv.Logprint("${_nameController.text}");
                          Logv.Logprint("${_emailController.value.toString()}");
                      },
                    ),
                  ),
                  RaisedButton(
                    child: Text("Register"),
                    onPressed: (){
                    },
                  ),
                ],
              )
            ],
          
          ),
        ),
    );
  }
}