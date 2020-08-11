import 'package:flutter/material.dart';
import 'package:liv_app/authenticate/register.dart';
import 'package:liv_app/authenticate/sign_in.dart';


class Authenticate extends StatefulWidget {

  final Function setUser;

  Authenticate({this.setUser});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView,setUser: widget.setUser);
    }else{
      return Register(toggleView: toggleView);
    }

  }
}
