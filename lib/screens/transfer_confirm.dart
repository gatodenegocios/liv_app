import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:liv_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:liv_app/shared/constants.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class TransferConfirm extends StatefulWidget {
  @override
  TransferConfirmState createState() {
    return TransferConfirmState();
  }

  String _userTo;
  double _value;
  Function _updateAll;
  TransferConfirm({String userTo = "", double value, Function updateFunction}){
  	_userTo = userTo;
  	_value = value;

  	_updateAll = updateFunction;
  }

}


class TransferConfirmState extends State<TransferConfirm> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller;
  AuthService _auth;
  bool loading = true;

  bool correct = false;

  String stateTransaction = "Aguarde";

  Widget _stateTransactionIcon(){
  	if(loading){
  		return SpinKitCircle(color: Colors.blue,);
  	}else if(correct){
  		return Icon(
	      Icons.done,
	      color: Colors.green,
	      size: 70.0,
	      );
  	}else{
  		return Icon(
	      Icons.clear,
	      color: Colors.red,
	      size: 70.0,
	      );
  	}
  }


  void _exibirDialogo() {
    showDialog(
       context:  context,
       builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(stateTransaction),
          content: _stateTransactionIcon(),

          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
       },
       barrierDismissible:false,
       barrierColor: Colors.black54,
    );
  }



  @override
  Widget build(BuildContext context) {
  	var moneyController = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
  	TextEditingController _passwordController = new TextEditingController();

  	AuthService _auth = Provider.of<AuthService>(context);

    String userFrom = _auth.localUser.user;

    moneyController.updateValue(widget._value);

  	
    // Build a Form widget using the _formKey created above.
    return Scaffold(
    	appBar: AppBar(
    		title: Text("Confirmar transação!"),
    	),
    	body: Container(
	    	child: Form(
		      key: _formKey,
		      child: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text("De:", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
              ),
              SizedBox(height:10),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height:50,
                  child: Row(children:[
                    Icon(Icons.person),
                    Container(
                      child:Text(userFrom, style: TextStyle(fontSize: 20.0)),
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                  ]),
                ),
              ),
              SizedBox(height:20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Para:", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
              ),
              SizedBox(height:10),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height:50,
                  child: Row(children:[
                    Icon(Icons.person),
                    Container(
                      child:Text(widget._userTo, style: TextStyle(fontSize: 20.0)),
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                  ]),
                ),
              ),
              SizedBox(height:20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Valor:", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
              ),
              SizedBox(height:10),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height:50,
                  child: Row(children:[
                    Icon(Icons.person),
                    Container(
                      child:Text(moneyController.text, style: TextStyle(fontSize: 20.0)),
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                    ),
                  ]),
                ),
              ),
              SizedBox(height:20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirme sua senha:", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold))
              ),
              SizedBox(height:20),
              TextFormField(
                    controller:_passwordController,
                    validator : (val) => val.length < 3 ? 'A senha deve ser maior que 3 caracteres.': null,
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(hintText: "Senha"),
                ),
              SizedBox(height:20),
              RaisedButton(
               onPressed: () async {
                 if (_formKey.currentState.validate()) {
                    setState(()=> loading = true);
                    dynamic result = await _auth.transfer(widget._userTo,moneyController.numberValue,_passwordController.text);

                    _exibirDialogo();
                    if (result==null){
                      setState(()=> stateTransaction = "Sem conexão com o servidor!");
                      setState(()=> loading = false);
                    }else{
                      setState((){
                      correct =result.success;
                      stateTransaction = result.message;
                      loading = false;
                    });

                    widget._updateAll();
                    }
                }
              },
            child: Text('Confirmar'),
              ),
            ]
         )
          ),
          
		    ),
	    	margin: const EdgeInsets.all(10.0),
	    ),
    )


    ;


    

    
  }
}