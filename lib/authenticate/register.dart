import 'package:flutter/material.dart';
import 'package:liv_app/services/auth.dart';
import 'package:liv_app/shared/loading.dart';
import 'package:liv_app/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool loading = false;



  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Login"),
              onPressed: (){
                widget.toggleView();
              }
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "User"),
                    validator : (val) => val.isEmpty ? 'Usuario em branco': null,
                    controller: _userController,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Senha"),
                    validator : (val) => val.length < 3  ? 'A senha deve ser maior que 3 caracteres.': null,
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child:Text("Register"),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        setState(()=> loading = true);
                        dynamic result = await _auth.signUpUser(_userController.text,_passwordController.text);

                        if(result == null){
                          setState(()=> error = "Sem conexão com o servidor!");
                          loading = false;
                        }else{

                          if(result.success){
                            setState(()=> error = "Conta criada com sucesso!");
                          }else{
                            print(result.success);
                            print(result.message);
                            setState(()=> error = result.message);
                          }

                          loading = false;
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    error,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize:14.0
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}

