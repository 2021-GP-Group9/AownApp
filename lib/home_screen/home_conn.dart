//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../constant.dart';
//
// class Conn_home {
//   final String charityName ;
//
//   Conn(@required this.charityName);
//   Future<String> save_it_to_db() async
//   { String deb;
//   try{
//     final response =await http.post(Uri.parse(constant.url),body:{
//       "charityName":charityName
//     });
//     if(true)
//     {
//       final result=jsonDecode(response.body);
//       return result;
//     }
//     else{
//       return "error";
//     }
//   }
//   catch(exception){
//     return exception.toString();
//   }
//   }
//
// }
