import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:liv_app/screens/transfer_confirm.dart';

class FormTransfer extends StatefulWidget {
  @override
  FormTransferState createState() {
    return FormTransferState();
  }

  String _user;
  FormTransfer({String user = ""}){
  	_user = user;
  }

}

// Define a corresponding State class.
// This class holds data related to the form.
class FormTransferState extends State<FormTransfer> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<FormTransferState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller;
  double _money = 0;

  //String _money = "";

  void _openConfirmScreen(String u, double v) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TransferConfirm(userTo: u,value :v)));
  }

  @override
  void initState() {
    super.initState();
     _controller = new TextEditingController(text: widget._user);
  }

  @override
  Widget build(BuildContext context) {
  	var moneyController = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
    // Build a Form widget using the _formKey created above.
    return Container(
    	child: Form(
	      key: _formKey,
	      child: Column(
	        children: <Widget>[
	            TextFormField(
	            	controller: _controller,
	                validator : (val) => val.isEmpty ? 'Usuario em branco': null,
	                onChanged: (val){
	                  //setState(() => _user = val);
	                },
	            	decoration: const InputDecoration(
					    icon: Icon(Icons.person),
					    labelText: 'User',
					),
	          	),
	            SizedBox(
	              height: 30.0,
	            ),
	          	TextFormField(
	          		controller: moneyController,
	                validator : (val) => _money <= 0  ? 'Insira um valor valido!': null,

	            	decoration: const InputDecoration(
					    icon: Icon(Icons.attach_money),
					    labelText: 'Valor:',
					),

					onChanged: (val){
                  		_money = moneyController.numberValue;
                	},
					keyboardType: TextInputType.number,
	          	),
	          	SizedBox(
	              height: 30.0,
	            ),
	          	RaisedButton(
				  onPressed: (){
				    if (_formKey.currentState.validate()) {
				    	_openConfirmScreen(_controller.text,moneyController.numberValue);
				  	}
				  },
				  child: Text('Transferir'),
				),
	        ]
	     )
	    ),
    	margin: const EdgeInsets.all(10.0),
    );

    
  }
}