// To parse this JSON data, do
//
//     final appointementModel = appointementModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AppointementModel appointementModelFromJson(String str) => AppointementModel.fromJson(json.decode(str));

String appointementModelToJson(AppointementModel data) => json.encode(data.toJson());
class AppointementModel {
  AppointementModel({
    required this.data,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  final List<Datum> data;
  final String responseCode;
  final String result;
  final String responseMsg;

  factory AppointementModel.fromJson(Map<String, dynamic> json) => AppointementModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    responseCode: json["ResponseCode"],
    result: json["Result"],
    responseMsg: json["ResponseMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "ResponseCode": responseCode,
    "Result": result,
    "ResponseMsg": responseMsg,
  };
}

class Datum {
  Datum({
    required this.appointmentId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.reserved,
  });

  final String appointmentId;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String reserved;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    appointmentId: json["appointmentId"],
    appointmentDate: DateTime.parse(json["appointmentDate"]),
    appointmentTime: json["appointmentTime"],
    reserved: json["reserved"],
  );

  Map<String, dynamic> toJson() => {
    "appointmentId": appointmentId,
    "appointmentDate": "${appointmentDate.year.toString().padLeft(4, '0')}-${appointmentDate.month.toString().padLeft(2, '0')}-${appointmentDate.day.toString().padLeft(2, '0')}",
    "appointmentTime": appointmentTime,
    "reserved": reserved,
  };
}
