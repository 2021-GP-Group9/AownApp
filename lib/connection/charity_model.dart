import 'dart:convert';
import 'package:flutter/cupertino.dart';

CharityModel charityModelFromJson(String str) =>
    CharityModel.fromJson(json.decode(str));

class CharityModel {
  CharityModel({
    required this.charityId,
    required this.name,
    required this.description,
    required this.service,
    required this.city,
    required this.status,

  });

  final String charityId;
  final String name;
  final String description;
  final String service;
  final String city;
  final String status ;
  String imageString = "";
  late Image image;

  void setImageLink(String link) {
    imageString = link;
    try {
      image = Image.memory(base64Decode(link));
    } catch (e) {
      imageString = "";
    }
  }
// convert image type from json to map
  factory CharityModel.fromJson(Map<String, dynamic> json) => CharityModel(
    charityId: json["charityId"],
    name: json["name"],
    description: json["descrption"],
    service: json["service"],
    city: json["city"],
    status: json['status'],


  );
}
