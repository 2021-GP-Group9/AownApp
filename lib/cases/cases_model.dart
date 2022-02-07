import 'dart:convert';

import 'package:flutter/material.dart';

CasesDisplayModel casesDisplayModelFromJson(String str) => CasesDisplayModel.fromJson(json.decode(str));

String casesDisplayModelToJson(CasesDisplayModel data) => json.encode(data.toJson());

class CasesDisplayModel {
  CasesDisplayModel({
    required this.donationId,
    required this.charityId,
    required this.donationDescription,
    required this.itemName,
    required this.itemType,
    required this.itemSize,
    required this.itemColor,
    required this.itemCount,
  });

  String donationId;
  String charityId;
  String donationDescription;
  String itemName;
  String itemType;
  String itemSize;
  String itemColor;
  String itemCount;
  late String charityName;
  late String charityPhone;
  late String charityCity;
  late String charityLocation;
  late String charityEmail;
  late var icon;

  void getIcon(){
    icon = _getIcon(itemType);
  }

  void setCharityData(String _name, String _city, String _location, String _phone, String _email){
    charityName = _name;
    charityCity = _city;
    charityEmail = _email;
    charityLocation = _location;
    charityPhone = _phone;
  }

  factory CasesDisplayModel.fromJson(Map<String, dynamic> json) => CasesDisplayModel(
    donationId: json["donationId"],
    charityId: json["charity_id"],
    donationDescription: json["donationDescription"],
    itemName: json["itemName"],
    itemType: json["itemType"],
    itemSize: json["itemSize"],
    itemColor: json["itemColor"],
    itemCount: json["itemCount"],
  );

  Map<String, dynamic> toJson() => {
    "donationId": donationId,
    "charity_id": charityId,
    "donationDescription": donationDescription,
    "itemName": itemName,
    "itemType": itemType,
    "itemSize": itemSize,
    "itemColor": itemColor,
    "itemCount": itemCount,
  };
}


CasesModel casesModelFromJson(String str) => CasesModel.fromJson(json.decode(str));

String casesModelToJson(CasesModel data) => json.encode(data.toJson());

class CasesModel {
  CasesModel({
    required this.donationId,
    required this.donationDescription,
    required this.itemName,
    required this.itemType,
    required this.city,
  });

  String donationId;
  String donationDescription;
  String itemName;
  String itemType;
  String city;
  late var icon;

  void getIcon(){
    icon = _getIcon(itemType);
  }

  factory CasesModel.fromJson(Map<String, dynamic> json) =>
      CasesModel(
        donationId: json["donationId"],
        donationDescription: json["donationDescription"],
        itemName: json["itemName"],
        itemType: json["itemType"],
        city: json["city"]
      );

  Map<String, dynamic> toJson() =>
      {
        "donationId": donationId,
        "donationDescription": donationDescription,
        "itemName": itemName,
        "itemType": itemType,
        "city": city
      };
}

IconData _getIcon(String itemType){
  late IconData _icon;
  itemType = itemType.trim();
  if(itemType == "كتب_وورق") {
    _icon = Icons.menu_book_rounded;
  }
  else if(itemType == "أثاث" || itemType == "اثاث"){
    _icon = Icons.house_rounded;
  }
  else if(itemType == "الكترونيات") {
    _icon = Icons.microwave_rounded;
  }
  else if(itemType == "ملابس") {
    _icon = Icons.checkroom_sharp;
  }

  return _icon;
}