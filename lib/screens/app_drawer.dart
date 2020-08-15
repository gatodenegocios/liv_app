import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final Function logout;

  AppDrawer({this.logout});
  

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 160.0,
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFF015FFF),
                  ),
                  onPressed: null,
                  label: Text("Back",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.black)),
                  color: Colors.black,
                ),
              ),
              buildMenuItem(Icons.exit_to_app, "SAIR DA CONTA", widget.logout,
                  opacity: 1.0, color: Color(0xFF015FFF)),
              Divider(),
            ],
          ),
        ),
      )
    );
    
  }

  GestureDetector buildMenuItem(IconData icon, String title, Function f,
      {double opacity = 0.3, Color color = Colors.black}) {
    return GestureDetector(
      onTap: (){
          f();
        },
        child: Opacity(
      opacity: opacity,
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Icon(
              icon,
              size: 50.0,
              color: color,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 14.0, color: color)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    ),
    );

    
  }
}