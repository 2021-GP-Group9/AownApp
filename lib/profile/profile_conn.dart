import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import 'profile_data.dart';

class Conn {
  final int? donorId;
  final String? _name;
  final String? _phone_number;
  final String? _email;

  Conn(@required this.donorId, this._name, this._phone_number, this._email);

  // ignore: non_constant_identifier_names
  Future<profile_date> save_it_to_db() async {
    String deb;

    try {
      final response = await http.post(Uri.parse(constant.profile_url), body: {
        "donorId": donorId.toString(),
      });
      if (response.statusCode == constant.responseok) {
        print(jsonDecode(response.body));

        String objText = response.body.toString();
        profile_date mydata = profile_date.fromJson(jsonDecode(objText));
        // profile_date mydata =
        //   new profile_date(list[0], list[1].toString(), list[2]);
        print("mydata");
        print(mydata.name);
        return mydata;
      } else {
        print("error");
        return new profile_date("error", "error", "000");
      }
    } catch (exception) {
      print(exception.toString());
      return new profile_date("error", "error", "000");
    }
  }

  Future<String> update_it_to_db() async {
    String deb;

    try {
      final response = await http.post(Uri.parse(constant.update_url), body: {
        "donorId": donorId.toString(),
        "_name": _name.toString(),
        "_phone_number": _phone_number.toString(),
        "_email": _email.toString(),
      });
      if (response.statusCode == constant.responseok) {
        final result = jsonDecode(response.body);
        return result;
      } else {
        print("uperror");
        //return profile_date("error", "error", "000");
        return "objText";
      }
    } catch (exception) {
      print(exception.toString());
      //return new profile_date("error", "error", "000");
      return "objText";
    }
  }
}
