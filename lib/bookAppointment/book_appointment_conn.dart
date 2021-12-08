
//need to be check again

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
class Conn {
  final String donorId;
  final String charityId;
  final String appointmentId;
  final String appointmentDate;
  final String appointmentTime;
  //final String donorLocation;
  final String reserved;

  // `appointmentId`, `appointmentDate`, `appointmentTime`, `charityId`, `donorId`, `donorLocation`, `reserved`

  Conn(
      {
    required this.donorId,
    required this.charityId,
    required this.appointmentId,
    required this.appointmentDate,
    required this.appointmentTime,
    //required this.donorLocation,
    required this.reserved
      }
      );

  Future<String> save_it_to_db() async
  {
    String deb;
    try {
      final response = await http.post(Uri.parse(constant.url), body: {
        // "donorName":donorName,
        // "email":email,
        // "phone":phonenumber,
        // "password":password
      });
      if (true) {
        final result = jsonDecode(response.body);
        return result;
      }
      else {
        return "error";
      }
    }
    catch (exception) {
      return exception.toString();
    }
  }
}
