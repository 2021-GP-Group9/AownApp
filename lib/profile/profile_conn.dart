
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
class Conn {
  final String donorName;
  final String phonenumber;
  final String email;


  Conn(@required this.donorName,@required this.phonenumber,@required this.email,);
  Future<String> save_it_to_db() async
  { String deb;
  try{
    final response =await http.post(Uri.parse(constant.url),body:{
      "donorName":donorName,
      "email":email,
      "phone":phonenumber,

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
