import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
class Conn_Review {

  Future<dynamic> store_review(String comment_text,double rating, String charity_id,String donar_id) async
  {
    print("Yes11 $comment_text ,$rating ,$charity_id ,$donar_id");
    var request = http.MultipartRequest('POST',
        Uri.parse(constant.comment));
    request.fields.addAll({
      'comment_text': '$comment_text',
      'donar_id': donar_id,
      'charity_id': charity_id,
      'rating_score': rating.toString()
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> get_review(String charity_id) async {
    print(charity_id);
    dynamic json;
    // var request = http.Request('GET', Uri.parse('${constant.comment}?charity_id=$charity_id'));
    var request = http.Request('GET', Uri.parse('${constant.comment}?charity_id=${charity_id}'));



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
