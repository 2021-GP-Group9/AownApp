
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';

class add_favorite {
  final int listId;
  final int charityId;
  final int donarId;

  add_favorite(@required this.listId,@required this.charityId,@required this.donarId);
  Future<void> save_it_to_db() async
  {
    print('char $charityId');


    await http
        .post(
      Uri.parse(constant.favouriteurl),
      body: {
        "User_id":donarId.toString(),
        "charityId":charityId.toString(),
      },
    ).then((value)  {
      //var response = await jsonDecode(value.body);
      print(value);

    });
  }
}
