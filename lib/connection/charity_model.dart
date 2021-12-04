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
    required this.location,
    required this.phone,
    required this.email,
    required this.donationType,
    required this.licenseNumber,

  });

  final String charityId;
  final String name;
  final String description;
  final String service;
  final String city;
  final String status ;
  final String phone;
  final String location;
  final String email;
  final String donationType;
  final String licenseNumber;
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
    phone: json['phone'],
    location: json['location'],
    email: json['email'],
    licenseNumber: json['licenseNumber'],
    donationType: json['donationType'],


  );
}
