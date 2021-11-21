
//need to be check again

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
class Conn {
  final String donorName;
  final String phonenumber;
  final String email;
  final String password;

  Conn(@required this.donorName,@required this.phonenumber,@required this.email,@required this.password);
  Future<String> save_it_to_db() async
  { String deb;
  try{
    final response =await http.post(Uri.parse(constant.url),body:{
      "donorName":donorName,
      "email":email,
      "phone":phonenumber,
      "password":password
    });
    if(true)
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
