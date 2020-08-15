import 'package:flutter/material.dart';
import 'package:liv_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:liv_app/shared/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Configs extends StatefulWidget {

  final Function toggleView;
  final Function setUser;

  Configs({this.toggleView, this.setUser});

  @override
  _ConfigsState createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {


  AuthService _auth;
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  bool success = false;

  String error = "";

  Widget _getStateTest(){
  	if(loading){
  		return SpinKitCircle(color: Colors.blue);
  	}else{
  		return Text(error);	
  	}
  }

  @override
  Widget build(BuildContext context) {

  	TextEditingController _ipController = new TextEditingController();
  	_auth = Provider.of<AuthService>(context);

  	_ipController.text = _auth.SERVER_IP;

  
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                Row(
                  children:[
                    Text(_auth.HttpString , style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    SizedBox(width:10),
                    Container(
                      width: 150,
                      child: TextFormField(
                        controller: _ipController,
                          validator : (val) => val.isEmpty ? 'Digite o ip do servidor': null,

                        decoration:  textInputDecoration.copyWith(hintText: "Ip"),
                      ),
                    ),
                    SizedBox(width:10),
                    Text(_auth.Port , style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              	
	              
	              

              SizedBox(height: 20.0),

              RaisedButton(
                child:Text("Testar Conexão"),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(()=> loading = true);

                    dynamic result = await _auth.testConection(_ipController.text);

                    if(result==null){
                      setState(()=> error = "Sem conexão com o servidor!");
                    }else{
                      if(result.success){
                        setState(()=> error = "Conexão com o servidor bem sucedida!");
                      }else{
                        setState(()=> error = result.message);
                      }

                    }
                    setState(()=> loading = false);
                  }
                },
              ),
              SizedBox(height: 20.0),
              _getStateTest(),
            ],
          )
        )
      ),
    );
  }
}
