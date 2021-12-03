import 'dart:convert';
import 'dart:ui';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:aownapp/connection/charity_model.dart';
import 'package:aownapp/connection/get_charaty_data.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:aownapp/view_screen.dart';
import 'package:flutter/material.dart';

import '../viewPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController passwordController = TextEditingController();
//method to show the download icone befor get data
  bool _isLoadingData = true;
  final CharityDataConnection _charityDataConnection = CharityDataConnection();

  void requestData() {
    _charityDataConnection.requestCharityData().then((value) {
      setState(() {
        _isLoadingData = false;
      });
    });
  }

  @override
  void initState() {
    requestData(); // method load befor load the page to get information of charities
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // main axis alignment : start
    // cross axis alignment : center

    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xffD6DACA),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
                child: Icon(
                  Icons.person,
                  size: 35,
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Book_appointment()),
                  );
                },
                child: Icon(
                  Icons.add_circle,
                  size: 49,
                )),
            Icon(
              Icons.house ,
            size: 35,)
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffD6DACA),
        // leading: Icon(Icons.search),
        title: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: false,
          onFieldSubmitted: (String value) {
            print(value);
          },
          onChanged: (String value) {
            setState(() {
              _charityDataConnection.searchingTheCharityList(value);
            });
            print(value);
          },
          decoration: InputDecoration(
            labelText: 'بحث',
            prefixIcon: Icon(
              Icons.search,
            ),

          ),
        ),
        actions: [Image.asset("assets/finalLogo.jpeg")],
      ),
      body: (_isLoadingData)
          ? Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child:
          CircularProgressIndicator(color: const Color(0xffD6DACA)),
        ),
      )
          : ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          itemCount: _charityDataConnection.allCharityList.length,
          // #of charities
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewPage(charityModel:_charityDataConnection.allCharityList[index],)));
                },
                child: Container(
                  // height: 100,
                  color: const Color(0xffD6DACA),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                MediaQuery.of(context).size.width - 145,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  _charityDataConnection
                                      .allCharityList[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                MediaQuery.of(context).size.width - 145,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(_charityDataConnection
                                    .allCharityList[index].description),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Container(
                          height: 49,
                          width: 49,
                          child: (_charityDataConnection
                              .allCharityList[index].imageString ==
                              "")
                              ? Icon(
                              Icons.image,
                              size:55
                          )
                              : _charityDataConnection
                              .allCharityList[index].image,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  // when notification icon button clicked
  void onNotification() {
    print('notification clicked');
  }
}
