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
  late var icon;

  void getIcon(){
    if(itemType == "كتب_وورق") {
      icon = Icons.menu_book_rounded;
    }
    else if(itemType == "أثاث"){
      icon = Icons.house_rounded;
    }
    else if(itemType == "الكترونيات") {
      icon = Icons.microwave_rounded;
    }
    else if(itemType == "ملابس") {
      icon = Icons.luggage_rounded;
    }
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
  });

  String donationId;
  String donationDescription;
  String itemName;
  String itemType;
  late var icon;

  void getIcon(){
    if(itemType == "كتب_وورق") {
      icon = Icons.menu_book_rounded;
    }
    else if(itemType == "أثاث"){
      icon = Icons.house_rounded;
    }
    else if(itemType == "الكترونيات") {
      icon = Icons.microwave_rounded;
    }
    else if(itemType == "ملابس") {
      icon = Icons.luggage_rounded;
    }
  }

  factory CasesModel.fromJson(Map<String, dynamic> json) =>
      CasesModel(
        donationId: json["donationId"],
        donationDescription: json["donationDescription"],
        itemName: json["itemName"],
        itemType: json["itemType"],
      );

  Map<String, dynamic> toJson() =>
      {
        "donationId": donationId,
        "donationDescription": donationDescription,
        "itemName": itemName,
        "itemType": itemType,
      };
}