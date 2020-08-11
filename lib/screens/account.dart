import 'package:flutter/material.dart';
import 'package:liv_app/models/user.dart';
import 'package:liv_app/screens/app_drawer.dart';
import 'package:liv_app/screens/transfer_history.dart';
import 'package:liv_app/screens/contact_tile.dart';
import 'package:liv_app/screens/transfer_screen.dart';

import 'package:liv_app/models/transfer.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Account extends StatefulWidget {

  final User user;

  Account({this.user});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  String _salutation;
  String _value;

  MoneyMaskedTextController moneyController = new MoneyMaskedTextController(leftSymbol: 'R\$ ');


  Card topArea(String money) => Card(
    margin: EdgeInsets.all(10.0),
    elevation: 1.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(1.0))),
      child: Container(
        decoration: BoxDecoration(
          /*gradient: RadialGradient(
            colors: [Color(0xFF015FFF), Color(0xFF015FFF)]
          )*/
          color: Colors.green[900],
        ),
        padding: EdgeInsets.all(5.0),
        // color: Color(0xFF015FFF),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
              children: <Widget>[
                Center(
                  child: Text("Saldo:",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    textAlign: TextAlign.center,
                    ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(money,
                    style: TextStyle(color: Colors.white, fontSize: 24.0)
                  ),
                ),
                
              ],
          )
        )
      )
  );

  Container accountItems( String item, String charge, String dateString, String type,
   {Color oddColour = Colors.white}) => Container(
      decoration: BoxDecoration(color: oddColour),
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 16.0)),
                Text(charge, style: TextStyle(fontSize: 16.0))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                Text(type, style: TextStyle(color: Colors.grey, fontSize: 14.0))
              ],
            ),
          ],
    ),
  );





  displayAccoutList(){
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          accountItems("Trevello App", r"+ $ 4,946.00", "28-04-16", "credit",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"+ $ 5,428.00", "26-04-16", "credit"),
          accountItems("Amazon EU", r"+ $ 746.00", "25-04-216", "Payment",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"+ $ 14,526.00", "16-04-16", "Payment"),
          accountItems(
              "Book Hub Society", r"+ $ 2,876.00", "04-04-16", "Credit",
              oddColour: const Color(0xFFF7F7F9)),
        ],
      ),
    );
  }

  void _openTransferScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TransferScreen()));
  }

  @override
  void initState(){
    super.initState();
    _salutation = "Bem vindo, "+ widget.user.user + "!";
    //_value = moneyController.updateValue(widget.user.value);
    moneyController.updateValue(widget.user.value);
  }

  @override
  Widget build(BuildContext context) {

    //String salutation = "Bem vindo, "+ widget.user.user + "!";
    //String value = "Bem vindo, "+ widget.user.user + "!";

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          _salutation,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            topArea(moneyController.text),
            SizedBox(
                height: 40.0,
                child: Icon(
                  Icons.refresh,
                  size: 35.0,
                  color: Color(0xFF015FFF),
                ),
            ),
            Expanded(child: ListView(
              children:[
                ContactTile(Transfer(user:"Julho",value: 500.00,date: "25/25/25",type: "Entrada"),true),
                ContactTile(Transfer(user:"Agostor",value: 500.00,date: "25/25/25",type: "Saida"),false),
                ContactTile(Transfer(user:"Semprtem",value: 500.00,date: "25/25/25",type: "Entrada"),true),
                ContactTile(Transfer(user:"POutp",value: 500.00,date: "25/25/25",type: "Saida"),false),
                ContactTile(Transfer(user:"Julho",value: 500.00,date: "25/25/25",type: "Entrada"),true),
                ContactTile(Transfer(user:"Agostor",value: 500.00,date: "25/25/25",type: "Saida"),false),
                ContactTile(Transfer(user:"Semprtem",value: 500.00,date: "25/25/25",type: "Entrada"),true),
                ContactTile(Transfer(user:"POutp",value: 500.00,date: "25/25/25",type: "Saida"),false),
              ]
            ),
            ),/*
            ListView(
              children:[
                ContactTile(Transfer(user:"Julho",value: 500.00,date: "25/25/25",type: "Entrada"),true),
                ContactTile(Transfer(user:"Agostor",value: 500.00,date: "25/25/25",type: "Saida"),false),
                ContactTile(Transfer(user:"Semprtem",value: 500.00,date: "25/25/25",type: "Entrada"),true),
                ContactTile(Transfer(user:"POutp",value: 500.00,date: "25/25/25",type: "Saida"),true),
              ]
            ),*/

          ],
        ),
      ),

      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              _openTransferScreen();
            },
            child: Icon(Icons.compare_arrows),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      
    );
  }

}