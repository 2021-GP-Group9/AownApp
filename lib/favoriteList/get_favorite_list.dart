import 'dart:convert';

import 'package:aownapp/connection/charity_model.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
class get_favorite_DataConnection {


  List<int> favoriteList = [];



  Future<void> requestFavouriteData(String user_id) async {
    print("userId");
    print (user_id);
    await http
        .post(
      Uri.parse(constant.favouriteurl),
      body: {
        'User_id': user_id,
      },
    ).then((value) async {
      var response = await jsonDecode(value.body);
      if(response!="no data")
      {

        for (var favourite in response) {
          favoriteList.add((int.parse(favourite['charityId'])));
        }
      } else{
        print( "error");
      }



    });

  }

}
