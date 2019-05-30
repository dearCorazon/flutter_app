import 'package:flutter/material.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Model/userModel.dart';
import 'package:flutter_app/Utils/Api.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatelessWidget{
  Api api = new Api();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _passwordController= new TextEditingController();;
    return  Scaffold(
        appBar: new AppBar(
          title:  new Text("登录注册"),
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
                controller: _passwordController,
                obscureText: true,
              ),
              Row(
                children: <Widget>[
                  RaisedButton(
                    child: Text("login"),
                    onPressed: ()async{
                        await api.login(_emailController.text, _passwordController.text);
                        Logv.Logprint(_passwordController.text);
                        Logv.Logprint(_emailController.value.toString());
                        Navigator.pop(context);
                    },
                  ),
                  RaisedButton(
                    child: Text("Register"),
                    onPressed: ()async{
                      await api.register(_emailController.value.toString(), _passwordController.text);
                      Navigator.pop(context);
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