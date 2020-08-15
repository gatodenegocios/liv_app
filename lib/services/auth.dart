
import 'package:liv_app/models/user.dart';
import 'package:liv_app/models/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';




class AuthService{
  final storage = new FlutterSecureStorage();

  User localUser = null;

  String HttpString = "http://";
  String SERVER_IP = '192.168.0.5';
  String Port = ":3000";

  User getUser(){
    return localUser;
  }

  Future<User> setUser (String jwt) async {
    if(jwt == null)
      return null;

    localUser = User.fromMap(parseJwtPayLoad(jwt),jwt);

    return await localUser;

  }

  void SetIp(String ip){
    SERVER_IP = ip;
  }

  Future<Response> testConection(String ipTest) async {

    try{
      var res = await http.post(
        "$HttpString$ipTest$Port/test-conection",
        body: {
          "test":"test"
        }
      );

      Response response = Response.fromJson(json.decode(res.body));


      if(response.success){
        SetIp(ipTest);
      }

      return response;


    }catch(e){
        return null;
    }
  }


  Future<Response> signUpUser(String user,String password) async {
    try{
      var res = await http.post(
        "$HttpString$SERVER_IP$Port/sign-up",
        body: {
          "user": user,
          "password": password,
        }
      );
      return Response.fromJson(json.decode(res.body));
    }catch(e){
        return null;
    }

    
  }

  Future<Response> signInUserJWT(String user, String password) async {

    try{

      var res = await http.post(
        "$HttpString$SERVER_IP$Port/sign-in",
        body: {
          "user": user,
          "password": password
        }
      );

      return Response.fromJson(json.decode(res.body));
    
    }catch(e) {
     return null;
    }

  }

  Future<Response> transfer( String userTo, double value, String password) async {

    try{

      var res = await http.post(
        "$HttpString$SERVER_IP$Port/transfer",
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

  Future<Response> updateValue() async { 


    try{

      var res = await http.post(
        "$HttpString$SERVER_IP$Port/updateValue",
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

  Future<Response> updateTransactions() async {


    try{

      var res = await http.post(
        "$HttpString$SERVER_IP$Port/updateTransactions",
        headers: {HttpHeaders.authorizationHeader: getUser().jwt},
        body: {
          "user": getUser().user,
        }
      );

      return Response.fromJson(json.decode(res.body));
    
    }catch(e) {

     return null;
    }

  }




  void storeJwt(String token) async {

    await storage.write(key: 'jwt', value: token);

    String value = await storage.read(key: 'jwt');



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

