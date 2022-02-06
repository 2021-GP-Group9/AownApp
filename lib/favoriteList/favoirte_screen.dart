import 'dart:convert';
import 'dart:ui';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:aownapp/cases/cases_page.dart';
import 'package:aownapp/connection/charity_model.dart';
import 'package:aownapp/connection/get_charaty_data.dart';
import 'package:aownapp/favoriteList/favoirte_screen.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../viewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite_screen extends StatefulWidget {
  @override
  State<Favorite_screen> createState() => _Favorite_screenState();
}

class _Favorite_screenState extends State<Favorite_screen> {
  List<String> myListOfStrings = [];
  List<int> myList = [];
  Color _favIconColor = Colors.grey;
  List<Color> colors_list = [];

  TextEditingController passwordController = TextEditingController();
//method to show the download icone befor get data
  bool _isLoadingData = true;
  final CharityDataConnection _charityDataConnection = CharityDataConnection();
  int selectedPage = 0;
  final _pageOption = [
    Profile(),
    Favorite_screen(),
    CasesPage(),
    Favorite_screen()
  ];
  void requestData() {
    _charityDataConnection.requestCharityData().then((value) {
      setState(() {
        _isLoadingData = false;
        print(_charityDataConnection.allCharityList.length);
        int length = _charityDataConnection.allCharityList.length;
        for (int i = 0; i < length; i++) {
          check_favo(_charityDataConnection.allCharityList[i].charityId)
              ? colors_list.add(Colors.red)
              : colors_list.add(Colors.grey);
        }
        print(colors_list[0].toString());
      });
    });
  }

  @override
  void initState() {
    requestData();
    _get_list().then((value) {
      myList = value;
      print(myList.toString());
    });
    fill_color();
    super.initState();
  }

  void fill_color() {
    int length = _charityDataConnection.allCharityList.length;
    print("length".length);


    for (int i = 0; i < length; i++) {
      colors_list[i] = Colors.grey;
    }
    colors_list.toString();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffD6DACA),

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

          itemBuilder: (BuildContext context, int index) {
            return check_favo(
                _charityDataConnection.allCharityList[index].charityId)
                ? Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white70),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 20,
                        offset: Offset(-10.0,
                            10.0),
                      ),
                    ]),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _remove(_charityDataConnection
                            .allCharityList[index])
                            .whenComplete(() {
                          setState(() {
                            //print(index);
                            //colors_list[index] = Colors.grey;
                          });
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Icon(
                          Icons.favorite,
                          color: colors_list[index],
                          size: 24.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewPage(
                                  charityModel:
                                  _charityDataConnection
                                      .allCharityList[index],
                                )));
                      },
                      child: Container(
                        // height: 100,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 240,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context)
                                          .size
                                          .width -
                                          145,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        _charityDataConnection
                                            .allCharityList[index]
                                            .name,
                                        style: TextStyle(
                                            fontFamily:
                                            'almarai Bold',
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context)
                                          .size
                                          .width -
                                          145,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        _charityDataConnection
                                            .allCharityList[index]
                                            .description,
                                        textAlign: TextAlign.right,
                                        textDirection:
                                        TextDirection.rtl,
                                        style: TextStyle(
                                          fontFamily:
                                          'almarai Regular',
                                          fontSize: 13,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(right: 40),
                              child: Container(
                                height: 49,
                                width: 49,
                                child: (_charityDataConnection
                                    .allCharityList[index]
                                    .imageString ==
                                    "")
                                    ? Icon(Icons.image, size: 49)
                                    : _charityDataConnection
                                    .allCharityList[index].image,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Container(
              color: Colors.white,
            );
          }),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icon(Icons.person), title: 'ملف شخصي'),
          TabItem(icon: Icon(Icons.house), title: 'الرئيسية'),
          TabItem(icon: Icon(Icons.assignment_rounded), title: 'الحالات‎'),
          TabItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              title: 'المفضلة '),
        ],
        height: 55,
        initialActiveIndex: selectedPage,
        onTap: (int index) {
          print(index);
          setState(() {
            selectedPage = index;
            _pageOption[selectedPage];
            _pn(selectedPage);
          });
        },
        backgroundColor: const Color(0xffD6DACA),
      ),
    );
  }

  _pn(int selectedPage) {
    if (selectedPage == 0) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
      // } else if(selectedPage == 1){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Book_appointment()),
      //   );
    } else if (selectedPage == 0) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    } else if (selectedPage == 1) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (selectedPage == 2) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CasesPage()),
      );
    } else if (selectedPage == 3) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Favorite_screen()),
      );
    }
  }

  // when notification icon button clicked
  void onNotification() {
    print('notification clicked');
  }

  Future _remove(CharityModel _CharityModel) async {
    // print('hello');

    int id = int.parse(_CharityModel.charityId);
    if (myList.contains(id)) {

      myList.removeWhere((item) => item == id);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> myList1 =
      (prefs.getStringList('mylist12') ?? List<String>.empty());

      print('before remove Your list  $myList1');
      myList1.removeWhere((item) => item == id.toString());

      print('After remove Your list  $myList1');
      await prefs.setStringList('mylist12', myList1);
    }
  }

  Future _get_list() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myList =
    (prefs.getStringList('mylist12') ?? List<String>.empty());
    List<int> myOriginaList = myList.map((i) => int.parse(i)).toList();
    print('Your list  $myOriginaList');
    return myOriginaList;
  }

  check_favo(String charityId) {
    int id = int.parse(charityId);
    print(myList.contains(id));
    return myList.contains(id);
  }
}
