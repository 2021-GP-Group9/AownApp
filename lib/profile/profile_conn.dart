import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import 'profile_data.dart';
class Conn {
  final int ?donorId;
  Conn(@required this.donorId);
  // ignore: non_constant_identifier_names
  Future<profile_date> save_it_to_db() async
  { String deb;

  try{
    final response =await http.post(Uri.parse(constant.profile_url),body:{
      "donorId":donorId.toString(),
    });
    if(response.statusCode==constant.responseok)
    {
      final List<dynamic> list = await jsonDecode(response.body);
      profile_date mydata=new profile_date(list[0],list[1].toString(),list[2]);
      print("mydata");
      print(mydata.name);
      return mydata;
    }
    else{
      print("error");
      return new profile_date("error" ,"error", 000);
    }
  }
  catch(exception){
    print(exception.toString());
    return new profile_date("error" ,"error", 000);
  }

  }
}