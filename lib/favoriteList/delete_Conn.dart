import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
class Conn_delete_favorite {
  final int charaity_id;
  final int user_id;



  Conn_delete_favorite(@required this.charaity_id,@required this.user_id);
  Future<void> delete_function() async
  {
    await http
        .post(
      Uri.parse(constant.favouriteurl),
      body: {
        "charity_id":charaity_id.toString(),
        "us_id":user_id.toString(),

      },
    ).then((value)  {
      print(value.body.toString());

    });


  }
}
