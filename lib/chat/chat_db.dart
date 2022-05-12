import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import '../global.dart';
class Conn_chat {

  Future<dynamic> store_message(String message,String toUser,String fromUser) async
  {
    print("Yes11 $message ,$toUser ,$fromUser ");
    var request = http.MultipartRequest('POST',
        Uri.parse(constant.send_message));
    request.fields.addAll({
      'fromUser': fromUser,
      'message': message,
      'toUser': toUser,
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> get_messages(String toUser,String fromUser) async {
    print(toUser);
    dynamic json;
    print(Uri.parse('${constant.received_message}'
        '?toUser=${toUser}&userId=${fromUser}'));
    // var request = http.Request('GET', Uri.parse('${constant.comment}?charity_id=$charity_id'));
    var request = http.Request('GET', Uri.parse('${constant.received_message}'
        '?toUser=${toUser}&userId=${fromUser}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      json=jsonDecode(await response.stream.bytesToString());
      return json;
    }
    else {
      print(response.reasonPhrase);
    }
    return json;
  }

  Future<dynamic> get_donation_status(String charityId,String donorId) async {
    print(charityId);
    dynamic json;
    // var request = http.Request('GET', Uri.parse('${constant.comment}?charity_id=$charity_id'));
    var request = http.Request('GET', Uri.parse('${constant.get_donation_status}?'
        'charityId=${charityId}&donorId=${donorId}'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print();
      json=jsonDecode(await response.stream.bytesToString());
      return json;
    }
    else {
      print(response.reasonPhrase);
    }
    return json;
  }

}
