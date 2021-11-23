import 'dart:convert';

CharityModel charityModelFromJson(String str) => CharityModel.fromJson(json.decode(str));

class CharityModel {
  CharityModel({
    required this.charityId,
    required this.name,
    required this.description,
    required this.service,
    required this.city,
  });

  String charityId;
  String name;
  String description;
  String service;
  String city;
  late String image = "";

  void setImageLink(String link){
    image = link;
  }

  factory CharityModel.fromJson(Map<String, dynamic> json) => CharityModel(
    charityId: json["charityId"],
    name: json["name"],
    description: json["descrption"],
    service: json["service"],
    city: json["city"],
  );

}
