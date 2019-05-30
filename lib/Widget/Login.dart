import 'package:flutter/material.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Model/userModel.dart';
import 'package:flutter_app/Provider/UserState.dart';
import 'package:flutter_app/Utils/Api.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatelessWidget{
  Api api = new Api();
  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
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
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                  labelText: '请输入你的email',
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                  labelText: '请输入你的密码',
                ),
                // obscureText: true,
              ),
              Row(
                children: <Widget>[

                  Expanded(
                    child: RaisedButton(
                               child: Text("login"),
                      onPressed: ()async{
                          int id = await api.login(_emailController.text, _passwordController.text);
                          Logv.Logprint(_passwordController.text);
                          Logv.Logprint(_emailController.value.toString());
                          userState.login(id, _emailController.text);
                          Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                                      child: RaisedButton(
                      child: Text("Register"),
                      onPressed: ()async{
                        await api.register(_emailController.value.toString(), _passwordController.text);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )
            ],
          
          ),
        ),
    );
  }
}