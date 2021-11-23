import 'dart:ui';

import 'package:aownapp/book_appointment.dart';
import 'package:aownapp/connection/get_charaty_data.dart';
import 'package:aownapp/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController passwordController = TextEditingController();

  bool _isLoadingData = true;
  final CharityDataConnection _charityDataConnection = CharityDataConnection();

  void requestData() {
    print("request Send");
    _charityDataConnection.requestCharityData().then((value) {
      setState(() {
        print("The data");
        print(_charityDataConnection.allCharityList.toString());
        _isLoadingData = false;
      });
    });
  }

  @override
  void initState() {
    requestData();
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
            Icon(Icons.house)
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
            // suffixIcon: Icon(
            //   Icons.remove_red_eye,
            // ),
            // border: OutlineInputBorder(),
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
                child: CircularProgressIndicator(
                    color: const Color(0xffD6DACA)
                ),
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
                  child: Container(
                    height: 100,
                    color: const Color(0xffD6DACA),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  _charityDataConnection
                                      .allCharityList[index].name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(_charityDataConnection
                                    .allCharityList[index].description),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40, left: 30),
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Image.asset(
                              "assets/finalLogo.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
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
