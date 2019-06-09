import 'package:flutter/material.dart';
import 'package:flutter_app/Bloc/UserBloc.dart';
import 'package:flutter_app/DAO/DaoApi.dart';
import 'package:flutter_app/Log.dart';
import 'package:flutter_app/Utils/Api.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  Api api = new Api();
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    TextEditingController _emailController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    ;
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldkey,
        appBar: new AppBar(
          title: new Text("登录注册"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("login"),
                        onPressed: () async {
                          int id = await api.login(
                              _emailController.text, _passwordController.text);
                          if (id == 0) {
                            _scaffoldkey.currentState.showSnackBar(SnackBar(
                              content: Text("email或密码错误"),
                            ));
                          } else {
                            userBloc.login(_emailController.text, id);
                            Navigator.pop(context);
                          }
                          Logv.Logprint(_passwordController.text);
                          Logv.Logprint(_emailController.value.toString());
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text("Register"),
                        onPressed: () async {
                          await api.register(_emailController.value.toString(),
                              _passwordController.text);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Login2 extends StatelessWidget {
  //const Login2({Key key}) : super(key: key);
  Api api = new Api();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.text_fields),
                            labelText: '请输入你的email',
                          ),
                        ),
                        TextFormField(
                          
                          validator: (v)=>(v == null || v.isEmpty)?"请输入密码": null,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.text_fields),
                            labelText: '请输入你的密码',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("登录"),
                          onPressed: () async {
                            if (_emailController.text == null ||
                                _passwordController.text == null) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("输入不能为空"),
                              ));
                            }
                            int id = await api.login(_emailController.text,
                                _passwordController.text);
                            if (id == 0) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("email或密码错误"),
                              ));
                            } else {
                              userBloc.login(_emailController.text, id);
                              Navigator.pop(context);
                            }
                            Logv.Logprint(_passwordController.text);
                            Logv.Logprint(_emailController.value.toString());
                          },
                        ),
                        RaisedButton(
                          child: Text("注册"),
                          onPressed: () async {
                            await api.register(
                                _emailController.value.toString(),
                                _passwordController.text);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("注册成功"),
                            ));
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
