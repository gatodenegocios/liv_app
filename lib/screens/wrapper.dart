import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:receitas_mmm/screens/home/home.dart';
import 'package:liv_app/authenticate/authenticate.dart';
import 'package:liv_app/models/user.dart';
import 'package:liv_app/screens/account.dart';
import 'package:liv_app/services/auth.dart';


class Wrapper extends StatefulWidget {


  @override
  _WrapperState createState() => _WrapperState();
}


class _WrapperState extends State<Wrapper> {

  AuthService _auth;

  void setUser  (String message) async{
    setState((){
      dynamic user = _auth.setUser(message);
    });
  }

  void logout(){
    setState((){
      _auth.localUser = null;
    });
  }

  


  @override
  Widget build(BuildContext context) {

    _auth = Provider.of<AuthService>(context);
    


    //return Authenticate();

    //return Account();

    
    if(_auth.localUser != null){

      return Account(logout:logout);
    }else{

      return Authenticate(setUser : setUser);

    }
    
  }
}
