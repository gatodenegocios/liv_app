
import 'package:liv_app/models/user.dart';
import 'package:liv_app/models/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'https://food.api.pliffer.com.br';



class AuthService{
  final storage = new FlutterSecureStorage();

  final _user = null;


  //aith change user stream

  Stream<User> get user{
    return _user;//_auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  Future<Response> signUpUser(String name, String password, String email, String login) async {
    print("up");
    var res = await http.post(
      "$SERVER_IP/user/signup",
      body: {
        "email": email,
        "last_email_check": email,
        "login": login,
        "name": name,
        "password": password,
      }
    );

    if(res.statusCode == 200) return Response.fromJson(json.decode(res.body));

    return null;
  }

  Future<Response> signInUserJWT(String email, String password) async {

    print("in");

    var res = await http.post(
      "$SERVER_IP/user/signin",
      body: {
        "email": email,
        "password": password
      }
    );

    print(res.body);

    if(res.statusCode == 200) return Response.fromJson(json.decode(res.body));

    return null;
  }

  void storeJwt(String token) async {

    await storage.write(key: 'jwt', value: token);//,jwt['name'],jwt['email'],token

    //String value = await storage.read(key: 'jwt');

    //var jwt = parseJwt(token);
    //print(value);


  }

  Map<String, String> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);print(payload);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, String>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }


}

