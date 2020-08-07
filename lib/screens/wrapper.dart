import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:receitas_mmm/screens/home/home.dart';
import 'package:liv_app/authenticate/authenticate.dart';
import 'package:liv_app/models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Authenticate();

    /*
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
    */
  }
}
