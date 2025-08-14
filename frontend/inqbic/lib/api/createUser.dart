import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:inqbic/Constants/Constant.dart';
import '../Model/UserModel.dart';

Future<http.Response> createUser(UserModel userModel) async{
  const endPoint = 'register/';
  return http.post(
    Uri.parse(API+endPoint),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(userModel.toJson())
  );
}