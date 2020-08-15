import 'package:flutter/material.dart';
import 'package:liv_app/services/auth.dart';
import 'package:liv_app/shared/loading.dart';
import 'package:liv_app/shared/constants.dart';
import 'package:liv_app/screens/configs.dart';
import 'package:provider/provider.dart';

import 'package:liv_app/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  final Function setUser;

  SignIn({this.toggleView, this.setUser});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  AuthService _auth;
  final _formKey = GlobalKey<FormState>();


  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool loading = false;

  String error = "";

  _openConfigScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Configs()));
  }

  @override
  Widget build(BuildContext context) {

    _auth = Provider.of<AuthService>(context);

    return loading? Loading():Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () => _openConfigScreen(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        //color: Colors.blue[50],
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                SizedBox(height: 50),
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child:Image.asset('assets/img/logo.png', width: 50, height: 50.0),
                  ),
                  
                  SizedBox(height: 75.0),
                  TextFormField(
                    controller: _userController,
                      validator : (val) => val.isEmpty ? 'Usuario em branco': null,

                    decoration:  textInputDecoration.copyWith(hintText: "User"),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller:_passwordController,
                    decoration: textInputDecoration.copyWith(hintText: "Senha"),
                    validator : (val) => val.length < 3 ? 'A senha deve ser maior que 3 caracteres.': null,
                    obscureText: true,

                  ),

                  SizedBox(height: 50.0),

                  Container(
                    width: 100.0,
                    height: 50.0,
                    child:RaisedButton(
                    child:Text("Login"),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(()=> loading = true);

                        dynamic result = await _auth.signInUserJWT(_userController.text,_passwordController.text);

                        if(result==null){
                          setState(()=> error = "Sem conexão com o servidor!");
                          setState(()=> loading = false);
                        }else{
                          if(result.success){
                            setState(()=> error = "Vamos Lá!");

                            widget.setUser(result.message);

                          }else{
                            setState(()=> error = result.message);
                          }

                          setState(()=> loading = false);
                        }
                      }
                    },
                  ),
                  ),
                  
                  SizedBox(height: 20.0),
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize:14.0
                    ),
                  ),
                  SizedBox(height: 20.0),
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text("Criar conta"),
                    onPressed: (){
                     widget.toggleView();
                    }
                  ),
                ],
              )
          ),


        )
      ),
    );
  }
}
