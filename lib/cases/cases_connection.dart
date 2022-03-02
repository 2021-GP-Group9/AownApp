import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aownapp/cases/cases_model.dart';

class CasesConnection {
  List<CasesModel> allCasesList = [];
  List<CasesModel> casesToPresent = [];
  late CasesDisplayModel specificCase;
  bool getSpecificCase = false;

  List<CasesModel> get getAllCasesList {
    return [...casesToPresent];
  }

  Future requestAllCasesList() async {
    var res = await http.get(
      Uri.parse("https://awoon.000webhostapp.com/get_donation.php"),
    );
    var response = await jsonDecode(res.body);
    allCasesList.clear();
    for (var charity in response) {
      allCasesList.add(CasesModel.fromJson(charity));
      allCasesList.last.getIcon();
    }
    casesToPresent.clear();
    casesToPresent = allCasesList.map((v) => v).toList();
  }

  Future requestSpecificCase(String id) async {
    getSpecificCase = false;
    var response = await http.post(
      Uri.parse("https://awoon.000webhostapp.com/get_specific_donation.php"),
      body: {
        'id': id,
      },
    );
    var res = await jsonDecode(response.body);
    print(res);
    if (res is List) {
      getSpecificCase = true;
      specificCase = CasesDisplayModel.fromJson(res[0]);
      Map<String, dynamic> charityData =
          await _requestSpecificCharity(specificCase.charityId);
      specificCase.setCharityData(
        charityData['name'],
        charityData['city'],
        charityData['location'],
        charityData['phone'],
        charityData['email'],
      );
      specificCase.getIcon();
    }
  }

  Future<Map<String, dynamic>> _requestSpecificCharity(String id) async {
    var response = await http.post(
      Uri.parse("https://awoon.000webhostapp.com/get_single_charity.php"),
      body: {
        'charityId': id,
      },
    );
    var res = await jsonDecode(response.body);
    return res[0];
  }

  void addingFilter(String filter) {
    casesToPresent.clear();
    filter.trim();
    if (filter == "الكل") casesToPresent = allCasesList.map((v) => v).toList();
    for (var thisCase in allCasesList) {
      if (thisCase.itemType == filter || thisCase.city == filter) casesToPresent.add(thisCase);
    }
  }


  void searchingTheCasesList(String query) {
    casesToPresent.clear();
    if (query.isEmpty) {
      casesToPresent = allCasesList.map((v) => v).toList();
    } else {
      query = query.trim();
      for (var charity in allCasesList) {
        if (charity.itemName.contains(query) ||
            charity.donationDescription.contains(query))
          casesToPresent.add(charity);
      }
    }
  }
}
