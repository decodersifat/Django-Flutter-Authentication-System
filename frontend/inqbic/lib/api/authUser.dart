import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inqbic/Constants/Constant.dart';
import 'package:inqbic/Model/UserModel.dart';

Future<http.Response> authUser(AuthData authData) async{
  String endPoint = 'login/';
  return http.post(
      Uri.parse(API+endPoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(authData.toJson()),
    );

}