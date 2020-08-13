import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:liv_app/screens/transfer_screen.dart';
import 'package:liv_app/screens/form_transfer.dart';

import 'package:liv_app/models/transfer.dart';

class ContactTile extends StatefulWidget {
  @override
  _ContactTileState createState() => _ContactTileState();

  Transfer _transfer;

  bool _odd;
  Function _updateAll;

  ContactTile(Transfer transfer, bool oddColour, Function updateFunction){
  	_transfer = transfer;
	  _odd = oddColour;
    _updateAll = updateFunction;
  }

  
}

class _ContactTileState extends State<ContactTile> {

  var moneyController = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
  //double _moneyDouble = widget.charge;
  //String _moneyText = _moneyDouble.toString();

//  moneyController.updateText(_moneyText);

  //_moneyText = moneyController.text;

  String moneyFormatedValue(double money){
  	moneyController.updateValue(money);
  	return moneyController.text;
  }

  Color getColorType(String type){
  	switch(type){
  		case "Entrada":
  			return Colors.blue[700];
  			break;
  		case "Saida":
  			return Colors.red[700];
  			break;
  	}
  }

  Color getColor(bool odd){
  	if(odd)
  		return Colors.white;

  	return Colors.grey[100];
  }

  void _openTransferScreen(String _user) {
  		print(_user + "uaa");
    	Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FormTransfer( user: _user, functionUpdate: widget._updateAll) ));
  }


  @override
  Widget build(BuildContext context) {

  	return GestureDetector(
  		onTap: (){
          _openTransferScreen(widget._transfer.user);
        },
        child: Container(
	      decoration: BoxDecoration(color: getColor(widget._odd)),
	      padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
	        child: Column(
	          children: <Widget>[
	            Row(
	              mainAxisAlignment: MainAxisAlignment.spaceBetween,
	              children: <Widget>[
	                Text(widget._transfer.user, style: TextStyle(fontSize: 16.0)),
	                Text(moneyFormatedValue(widget._transfer.value), style: TextStyle(fontSize: 16.0, color: getColorType(widget._transfer.type)),)
	              ],
	            ),
	            SizedBox(
	              height: 10.0,
	            ),
	            Row(
	              mainAxisAlignment: MainAxisAlignment.spaceBetween,
	              children: <Widget>[
	                Text(widget._transfer.date,
	                    style: TextStyle(color: Colors.grey, fontSize: 14.0)),
	                Text(widget._transfer.type, style: TextStyle(color: Colors.grey, fontSize: 14.0))
	              ],
	            ),

	          ],
	    	),
	  	)
	);
  }
}