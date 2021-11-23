import 'dart:convert';

import 'package:aownapp/connection/charity_model.dart';
import 'package:http/http.dart' as http;

class CharityDataConnection {
  List<CharityModel> finalCharityList = [];
  List<CharityModel> charityList = [];

  List<CharityModel> get allCharityList {
    return [...finalCharityList];
  }

  Future<void> requestCharityData() async {
    await http.get(
      Uri.parse(
          "https://awoon.000webhostapp.com/getData.php"
      ),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
    ).then((value) async {
      var response = await jsonDecode(value.body);
      for (var charity in response) {
        charityList.add(charityModelFromJson(jsonEncode(charity)));
        finalCharityList.add(charityModelFromJson(jsonEncode(charity)));
      }
    });
  }

  Future<void> requestImage(CharityModel charity) async {
    await http
        .post(
      Uri.parse(""),
      body: jsonEncode(<String, String>{
        'id': charity.charityId,
      }),
    )
        .then((value) {
      charity.setImageLink(value.body);
    });
  }

  void searchingTheCharityList(String query){
    finalCharityList.clear();
    if(query.isEmpty){
      finalCharityList = charityList.map((v) => v).toList();
    }
    else{
      for(var charity in charityList){
        if(charity.name.contains(query)) finalCharityList.add(charity);
      }
    }
  }

}
