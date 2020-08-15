import 'package:flutter/material.dart';
import 'package:liv_app/models/user.dart';
import 'package:liv_app/screens/app_drawer.dart';

import 'package:liv_app/screens/contact_tile.dart';
import 'package:liv_app/screens/transfer_screen.dart';
import 'package:liv_app/services/auth.dart';
import 'package:liv_app/screens/form_transfer.dart';

import 'package:liv_app/models/transfer.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {

  //final User user;


  final Function logout;

  Account({this.logout});
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  String _salutation;
  String _value;
  AuthService _auth;

  bool hasUpdate = false;

  List<Transfer> TransferTileList = List();

  MoneyMaskedTextController moneyController = new MoneyMaskedTextController(leftSymbol: 'R\$ ');


  Card topArea(String money) => Card(
    margin: EdgeInsets.symmetric(vertical: 10.0),
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(1.0))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[900],
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
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
      if(await response.success){
        _auth.localUser.updateFromMap(response.message);
      }

      
      setState((){
        moneyController.updateValue(_auth.localUser.value);
      });
    } 
    
  }

  void _updateTransactions() async {
    dynamic response = await _auth.updateTransactions();
    hasUpdate = true;

    if(await response != null){
      if(await response.success){
        setState((){
          TransferTileList.clear();
        });
        
        _addContactTile(response.message);
        
      } 
    }
  }

  Widget _getTransactionsList(){
    if(!hasUpdate){
      return Center( child: Text("Atualize para ver o histórico de transações!"));
    }else if(TransferTileList.length >= 1){
      return ListView.builder(
              itemCount: TransferTileList.length,
              itemBuilder: (BuildContext ctxt, int Index) {
                  return ContactTile(TransferTileList[Index],Index % 2 ==0, _updateAll);
              });
    }else{
      return Center( child: Text("Você ainda não fez nenhuma transação!"));
    }
  }



  @override
  Widget build(BuildContext context) {

    _auth = Provider.of<AuthService>(context);

    _salutation = "Bem vindo, "+ _auth.localUser.user + "!";

    setState((){
      moneyController.updateValue(_auth.localUser.value);
    });


    return Scaffold(
      drawer: AppDrawer(logout:widget.logout),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blue, 
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          _salutation,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            topArea(moneyController.text),
            SizedBox(
                height: 40.0,
                child:  FlatButton.icon(
                  icon: Icon(Icons.refresh,color: Colors.white),
                  label: Text("Atualizar", style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                  onPressed: () => _updateAll(),
                ),
            ),
            SizedBox(height:10),
            Expanded(child: _getTransactionsList(),
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
