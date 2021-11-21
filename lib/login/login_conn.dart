import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
class Conn_login {
  final String email;
  final String password;

  Conn_login(@required this.email,@required this.password);
  Future<String> login_function() async
  {
  try{
    final response =await http.post(Uri.parse(constant.login_url),body:{
      "email":email,
      "password":password
    });
    if(response.statusCode==constant.responseok)
    {
      final result=jsonDecode(response.body);
      return result;
    }
    else{
      return "error";
    }
  }
  catch(exception){
    return exception.toString();
  }
  }
}
