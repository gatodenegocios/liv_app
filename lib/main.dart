import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liv_app/models/user.dart';
import 'package:liv_app/screens/wrapper.dart';
import 'package:liv_app/services/auth.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//import 'package:liv_app/screens/account.dart';

const SERVER_IP = 'https://food.api.pliffer.com.br';
final storage = FlutterSecureStorage();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false
        home: Wrapper(),
      ),
    );
  }
}

