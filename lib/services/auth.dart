
import 'package:liv_app/models/user.dart';
import 'package:liv_app/models/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'http://192.168.0.5:3000';



class AuthService{
  final storage = new FlutterSecureStorage();

  User localUser = null;


  //aith change user stream

  //Stream<User> get user{
  //  return _user;//_auth.onAuthStateChanged.map(_userFromFirebaseUser);
  //}

  User getUser(){
    return localUser;
  }

  Future<User> setUser (String jwt) async {
    if(jwt == null)
      return null;

    localUser = User.fromMap(parseJwtPayLoad(jwt),jwt);

    return await localUser;

  }


  Future<Response> signUpUser(String user,String password) async {
    var res = await http.post(
      "$SERVER_IP/sign-up",
      body: {
        //"email": email,
        //"last_email_check": email,
        "user": user,
        "password": password,
      }
    );

    //print(res.body);

    return Response.fromJson(json.decode(res.body));
  }

  Future<Response> signInUserJWT(String user, String password) async {

    try{

      var res = await http.post(
        "$SERVER_IP/sign-in",
        body: {
          "user": user,
          "password": password
        }
      );

      return Response.fromJson(json.decode(res.body));
    
    }catch(e) {
     return null;
    }
    //print(res.body)
    //print(res.body);


//    if(res.statusCode == 200) return Response.fromJson(json.decode(res.body));

    //return null;
  }

  Future<Response> transfer( String userTo, double value, String password) async {

    try{

      var res = await http.post(
        "$SERVER_IP/transfer",
        body: {
          "userFrom": getUser().user,
          "userTo": userTo,
          "value": value.toString(),

          "password": password
        }
      );

      return Response.fromJson(json.decode(res.body));
    
    }catch(e) {
      print(e);
     return null;
    }

  }

  Future<Response> updateValue() async { print("vamo tenta");

  print("enviando");
    try{

      var res = await http.post(
        "$SERVER_IP/updateValue",
        headers: {HttpHeaders.authorizationHeader: getUser().jwt},
        body: {
          "user": getUser().user,
        }
      );
      /*
      print("enviado");

      Response response = Response.fromJson(json.decode(res.body));

      print("enviei");

      if(response.success){print("deu boia");
        localUser.value = double.parse(response.message);
      }else{ print("deu ruim");}
      */

      return Response.fromJson(json.decode(res.body));
    
    }catch(e) {
      print(e);
     return null;
    }

  }

  Future<Response> updateTransactions() async { print("vamo tenta");

  print("enviando");
    try{

      var res = await http.post(
        "$SERVER_IP/updateTransactions",
        headers: {HttpHeaders.authorizationHeader: getUser().jwt},
        body: {
          "user": getUser().user,
        }
      );

      return Response.fromJson(json.decode(res.body));
    
    }catch(e) {
      print(e);
     return null;
    }

  }




  void storeJwt(String token) async {

    await storage.write(key: 'jwt', value: token);//,jwt['name'],jwt['email'],token

    String value = await storage.read(key: 'jwt');

    //setState(()=> _user = User.fromMap(parseJwtPayLoad(value))) ;

    //setState(() {
    
    //});

    //var jwt = parseJwt(token);
    //print(value);


  }

Map<String, dynamic> parseJwtPayLoad(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

Map<String, dynamic> parseJwtHeader(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[0]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
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

