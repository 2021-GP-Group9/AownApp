import 'dart:convert';
import 'dart:ui';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:aownapp/cases/cases_page.dart';
import 'package:aownapp/chat/chat_screen.dart';
import 'package:aownapp/connection/charity_model.dart';
import 'package:aownapp/connection/get_charaty_data.dart';
import 'package:aownapp/favoriteList/favoirte_screen.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import '../viewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'delete_Conn.dart';
import 'get_favorite_list.dart';

class Favorite_screen extends StatefulWidget {
  @override
  State<Favorite_screen> createState() => _Favorite_screenState();
}

class _Favorite_screenState extends State<Favorite_screen> {
  String user_id=AppColors.user;
  List<String> myListOfStrings = [];
  List<int> myList = [];
  Color _favIconColor = Colors.grey;
  List<Color> colors_list = [];

  TextEditingController passwordController = TextEditingController();
//method to show the download icone befor get data
  bool _isLoadingData = true;
  final CharityDataConnection _charityDataConnection = CharityDataConnection();
  final get_favorite_DataConnection _get_favorite_DataConnection=get_favorite_DataConnection();
  int selectedPage = 3;
  final _pageOption = [
    Profile(),
    HomeScreen(),
    CasesPage(),
    Favorite_screen(),
    ChatsScreen(),
  ];
  void requestData() {
    _charityDataConnection.requestCharityData().then((value) =>

        _get_list()

    );

  }

  @override
  void initState() {

    getuser_id();

    fill_color();

    super.initState();
  }
  Future<void> getuser_id()async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.containsKey("idKey")) {

      user_id=prefs.get('idKey').toString();
      print("user_id1");
      print(user_id);
      requestData(); // method load befor load the page to get information of charities

    }else{
      requestData();
    }

  }
  void fill_color() {
    int length = _charityDataConnection.allCharityList.length;
    print("length".length);
    // _charityDataConnection.allCharityList[i];

    for (int i = 0; i < length; i++) {
      colors_list[i] = Colors.grey;
    }
    colors_list.toString();
  }

  @override
  Widget build(BuildContext context) {
    // main axis alignment : start
    // cross axis alignment : center

    return Scaffold(
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
            labelText: '??????',
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
                            10.0), // changes position of shadow
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
                                  id: _charityDataConnection.allCharityList[index].charityId,
                                   index: index,
                                    charityDataConnection : _charityDataConnection
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
                              width: 210,
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
          TabItem(icon: Icon(Icons.person), title: '?????? ????????'),
          TabItem(icon: Icon(Icons.chat), title: '??????????????????'),
          TabItem(icon: Icon(Icons.assignment_rounded), title: '?????????????????'),
          TabItem(icon: Icon(Icons.favorite,color: Colors.black,),title: '?????????????? '),
          TabItem(icon: Icon(Icons.house), title: '????????????????'),
        ],
        color: Colors.black,
        height: 60,
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

    } else if (selectedPage == 4) {
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
    } else if (selectedPage == 1) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatsScreen()),
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
      print('charity_id $id');
      print('user_id $user_id');

      Conn_delete_favorite _remove= Conn_delete_favorite(id,int.parse(user_id));
      _remove.delete_function().then((value) => {
        setState(() {
          myList.removeWhere((item) => item == id);
        })


      });


      //myList.add(1);

      //replytile.removeWhere((item) => item.id == '001')
      //myList.add(int.parse(_CharityModel.charityId));
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // List<String> myList1 =
      //     (prefs.getStringList('mylist12') ?? List<String>.empty());
      // //List<int> myOriginaList = myList1.map((i) => int.parse(i)).toList();
      // //print('Your list  $myOriginaList');
      // print('before remove Your list  $myList1');
      // myList1.removeWhere((item) => item == id.toString());
      // // myList1.indexOf(id.);
      // print('After remove Your list  $myList1');
      // await prefs.setStringList('mylist12', myList1);
    }
  }

  Future<void> _get_list() async {

    print("user_id1");
    print(user_id);

    _get_favorite_DataConnection.requestFavouriteData(user_id).then((value) {
      myList =_get_favorite_DataConnection.favoriteList;
      print(myList.toString());
      int length = _charityDataConnection.allCharityList.length;
      print(length);
      for (int i = 0; i < length; i++) {
        check_favo(_charityDataConnection.allCharityList[i].charityId)
            ? colors_list.add(Colors.red)
            : colors_list.add(Colors.grey);
      }
      colors_list.toString();

      setState(() {
        _isLoadingData = false;

        // print(_charityDataConnection.allCharityList.length);

      });
    });
  }


  check_favo(String charityId) {
    int id = int.parse(charityId);
    print(id);
    print(myList.contains(id));
    return myList.contains(id);
  }
}
