import 'package:flutter/material.dart';
import 'package:liv_app/services/auth.dart';
import 'package:liv_app/shared/loading.dart';
import 'package:liv_app/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  bool loading = false;

  String email = "";
  String password = "";

  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      appBar: AppBar(
        title: Text("Loggin"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
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
                controller: _userController,
                  validator : (val) => val.isEmpty ? 'Usuario em branco': null,
                  onChanged: (val){
                    //setState(() => _user = val);
                  },
                decoration:  textInputDecoration.copyWith(hintText: "User"),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller:_passwordController,
                decoration: textInputDecoration.copyWith(hintText: "Senha"),
                validator : (val) => val.length < 3 ? 'A senha deve ser maior que 3 caracteres.': null,
                obscureText: true,
                onChanged: (val){
                  //setState(() => password = val);
                },
              ),

              SizedBox(height: 20.0),
              RaisedButton(
                child:Text("Login"),
                onPressed: () async {
                  if(_formKey.currentState.validate()){/*
                    setState(()=> loading = true);

                    dynamic result = await _auth.signInUserJWT(email,password);
                    if(result==null){
                      setState(()=> error = "Error");
                      loading = false;
                    }else{
                      if(result.success){
                        setState(()=> error = "Vamos Lá!");
                        _auth.storeJwt(result.message);
                      }else{
                        print(result.success);
                        print(result.message);
                        setState(()=> error = result.message);
                      }

                      loading = false;
                    }*/
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
