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
    ).then((value) async {
      var response = await jsonDecode(value.body);
      for (var charity in response) {
        charityList.add(charityModelFromJson(jsonEncode(charity)));
      }
      for(int i=0;i<charityList.length;i++){
        await requestImage(charityList[i]);
      }
    });
    finalCharityList = charityList.map((v) => v).toList();
  }

  Future<void> requestImage(CharityModel charity) async {
    await http
        .post(
      Uri.parse("https://awoon.000webhostapp.com/getImage.php"),
      body: {
        'id': charity.charityId,
      },
    )
        .then((value) {
      charity.setImageLink(value.body);
    });
  }

  CharityModel getThisCharity(String id){
    late CharityModel _thisCharity;
    for(CharityModel charity in charityList){
      if(charity.charityId == id){
        _thisCharity = charity;
        break;
      }
    }
    return _thisCharity;
  }

  Future<List<CharityModel>> getRecommendation(String type, String city, String service) async {
    List<CharityModel> _recommendedCharityList = [];

    await http.post(
      Uri.parse(
          "https://awoon.000webhostapp.com/getRecommendation.php"
      ),
      body: {
        'type': type,
        'city': city,
        'service': service,
      },
    ).then((value) async {
      var response = await jsonDecode(value.body);
      for (var charity in response) {
        _recommendedCharityList.add(charityModelFromJson(jsonEncode(charity)));
      }
      for(int i=0;i<_recommendedCharityList.length;i++){
        await requestImage(_recommendedCharityList[i]);
      }
    });

    return _recommendedCharityList;
  }

  void searchingTheCharityList(String query){
    finalCharityList.clear();
    if(query.isEmpty){
      finalCharityList = charityList.map((v) => v).toList();
    }
    else{
      query = query.trim();
      for(var charity in charityList){
        if(charity.name.contains(query)) finalCharityList.add(charity);
      }
    }
  }

  void addingFilter(String filter){
    finalCharityList.clear();
    filter.trim();
    if (filter == "????????") finalCharityList = charityList.map((v) => v).toList();
    for (var thisCharity in charityList) {
      if (thisCharity.donationType.contains(filter) || thisCharity.city == filter) finalCharityList.add(thisCharity);
    }
  }

}
