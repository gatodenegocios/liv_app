import 'package:flutter/material.dart';
import 'package:liv_app/screens/form_transfer.dart';

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();

  String _user;

  TransferScreen({String user = ""}){
    _user = user;
  }
}

class _TransferScreenState extends State<TransferScreen> {


  @override
  Widget build(BuildContext context) {
  	return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Nova transferencia",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
		),
      body: FormTransfer(user: widget._user),
  	);
  }
}