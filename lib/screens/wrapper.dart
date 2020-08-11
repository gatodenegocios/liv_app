import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:receitas_mmm/screens/home/home.dart';
import 'package:liv_app/authenticate/authenticate.dart';
import 'package:liv_app/models/user.dart';
import 'package:liv_app/screens/account.dart';
import 'package:liv_app/services/auth.dart';


class Wrapper extends StatefulWidget {

  //final Function toggleView;

  //SignIn({this.toggleView});

  @override
  _WrapperState createState() => _WrapperState();
}


class _WrapperState extends State<Wrapper> {

  AuthService _auth = AuthService();  
  bool authenticated = false;

  //void toggleView(){
  //  setState(() => showSignIn = !showSignIn);
  //}

  void setAuthenticated(bool b){
    setState(() => authenticated = b);
  }

  void setUser  (String message) async{
    dynamic user = _auth.setUser(message);

    setAuthenticated(await user!=null);
  }


  @override
  Widget build(BuildContext context) {

    


    //return Authenticate();

    //return Account();

    
    if(authenticated){
      //return Account();

        return  Account(user : _auth.getUser());
    }else{
      //return Authenticate();
      //return Provider<_WrapperState>.value(
      //  value: this,
      return Authenticate(setUser : setUser);
      //);
    }
    
  }
}
