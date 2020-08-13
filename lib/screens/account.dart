import 'package:flutter/material.dart';
import 'package:liv_app/models/user.dart';
import 'package:liv_app/screens/app_drawer.dart';
import 'package:liv_app/screens/transfer_history.dart';
import 'package:liv_app/screens/contact_tile.dart';
import 'package:liv_app/screens/transfer_screen.dart';
import 'package:liv_app/services/auth.dart';
import 'package:liv_app/screens/form_transfer.dart';

import 'package:liv_app/models/transfer.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {

  final User user;

  Account({this.user});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  String _salutation;
  String _value;
  AuthService _auth;

  List<Transfer> TransferTileList = List();

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

  _addContactTile(List<dynamic> json){//
    setState((){
      for(int i = 0; i < json.length; i++){
        TransferTileList.add(
          Transfer.fromMap(json[i])
        );
      }

      for(int i = 0; i < json.length; i++){
        //print(TransferTileList[i].value);
        //print(i);
      }
    });

  }


  void _openTransferScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FormTransfer( functionUpdate: _updateAll) ));
  }

  void _updateAll(){
    _updateMoneyCounter();
    _updateTransactions();
  }

  void _updateMoneyCounter() async {
    dynamic response = await _auth.updateValue();

    if(await response != null){
      if(await response.success){print("puts, deu true");
        widget.user.updateFromMap(response.message);
        print(widget.user.value);
      }else{
        print("puts, deu false");
      }

      
      setState((){
        moneyController.updateValue(widget.user.value);
      });//  
    }else{ print("deu ruim");}

    //requisição 
    
  }

  void _updateTransactions() async {
    dynamic response = await _auth.updateTransactions();

    if(await response != null){
      if(await response.success){print("puts, deu true");
//        widget.user.updateFromMap(response.message);
        setState((){
          TransferTileList.clear();
        });
        //for(int i = 0; i < response.message.length; i++){
          _addContactTile(response.message);
        //}
      }else{
        print("puts, deu false");
      }

      
      
    }else{ print("deu ruim");}

    //requisição 
    
  }

  @override
  void initState(){
    super.initState();
    //_salutation = "Bem vindo, "+ widget.user.user + "!";
    //_value = moneyController.updateValue(widget.user.value);
    //_value = widget.user.value;
    setState((){
      moneyController.updateValue(widget.user.value);
    });

    _updateAll();
  }

  @override
  Widget build(BuildContext context) {

    _auth = Provider.of<AuthService>(context);

    _salutation = "Bem vindo, "+ _auth.localUser.user + "!";

    setState((){
      moneyController.updateValue(_auth.localUser.value);
    });

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
                child:  IconButton(
                  icon: Icon(Icons.refresh),
                  color: Colors.blue,
                  onPressed: () => _updateAll(),
                ),
            ),
            Expanded(child: ListView.builder(
              itemCount: TransferTileList.length,
              itemBuilder: (BuildContext ctxt, int Index) {
                  return ContactTile(TransferTileList[Index],Index % 2 ==0, _updateAll);
              },
              ),
              /*TransferTileList[index]
              
              ),*/
            ),

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
