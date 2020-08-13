import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:liv_app/services/auth.dart';
import 'package:provider/provider.dart';

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

// Define a corresponding State class.
// This class holds data related to the form.
class TransferConfirmState extends State<TransferConfirm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<FormTransferState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller;
  AuthService _auth;
  bool loading = true;

  bool correct = false;

  String stateTransaction = "Aguarde...";

  Widget _stateTransactionIcon(){
  	if(loading){
  		return SpinKitCircle(color: Colors.blue,);
  	}else if(correct){
  		return Icon(
	      Icons.done,
	      color: Colors.green,
	      size: 30.0,
	      );
  	}else{
  		return Icon(
	      Icons.clear,
	      color: Colors.red,
	      size: 30.0,
	      );
  	}
  }

  //String _money = "";
  void _exibirDialogo() {
    showDialog(
       context:  context,
       builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text("Aguarde"),
          content: Container(
          		child:Column(
          			children:[
          			_stateTransactionIcon(),
					Center(
						child: Text(stateTransaction)
					),
          			]
          		),
				width: 50,
				height:150,
				margin: const EdgeInsets.all(10.0),
          	),

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
  void initState() {
    super.initState();
     //_controller = new TextEditingController(text: widget._user);
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
		      child: Column(
		        children: <Widget>[
		        	Text("De"),
		        	Text(userFrom),
		        	Text("Para"),
		        	Text(widget._userTo),
		        	Text(moneyController.text),
		        	TextFormField(
		                controller:_passwordController,
		                validator : (val) => val.length < 3 ? 'A senha deve ser maior que 3 caracteres.': null,
		                obscureText: true,
		            ),
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
					  child: Text('Confirma'),
					),
		        ]
		     )
		    ),
	    	margin: const EdgeInsets.all(10.0),
	    ),
    )


    ;


    

    
  }
}