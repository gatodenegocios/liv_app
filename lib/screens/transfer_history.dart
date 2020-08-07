import 'package:flutter/material.dart';
import 'package:liv_app/screens/form_transfer.dart';
import 'package:liv_app/screens/transfer_screen.dart';
import 'package:liv_app/screens/contact_tile.dart';

import 'package:liv_app/models/transfer.dart';


class TransferHistory extends StatefulWidget {
  @override
  _TransferHistoryState createState() => _TransferHistoryState();
}

class _TransferHistoryState extends State<TransferHistory> {
  @override
  Widget build(BuildContext context) {

  	void _openTransferScreen() {
    	Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TransferScreen()));
  	}

  	return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(																																																																																																			
          "Contatos",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,

        actions: [
	      	IconButton(
	            icon: Icon(Icons.add),
	            color: Colors.blue,
	            onPressed: () => _openTransferScreen(),
	        ),
	      ],
		),

      body: Container(
      	child: ListView(
        		children: <Widget>[
        			ContactTile(Transfer(user:"Julho",value: 500.00,date: "25/25/25",type: "Entrada"),true),
        			ContactTile(Transfer(user:"Agostor",value: 500.00,date: "25/25/25",type: "Saida"),false),
        			ContactTile(Transfer(user:"Semprtem",value: 500.00,date: "25/25/25",type: "Entrada"),true),
        			ContactTile(Transfer(user:"POutp",value: 500.00,date: "25/25/25",type: "Saida"),true),
        		],
        	),
      	margin: const EdgeInsets.all(10.0),
      ),
  	);
  }
}