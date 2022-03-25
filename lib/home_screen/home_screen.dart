import 'dart:convert';
import 'dart:ui';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:aownapp/cases/cases_page.dart';
import 'package:aownapp/connection/charity_model.dart';
import 'package:aownapp/connection/get_charaty_data.dart';
import 'package:aownapp/favoriteList/favoirte_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../viewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aownapp/cases/cases_connection.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> myListOfStrings = [];
  List<int> myList = [];
  Color _favIconColor = Colors.grey;
  List<Color> colors_list = [];

  TextEditingController passwordController = TextEditingController();

//method to show the download icone befor get data
  bool _isLoadingData = true;
  final CharityDataConnection _charityDataConnection = CharityDataConnection();
  int selectedPage = 3;
  final _pageOption = [Profile(), HomeScreen(), CasesPage(), Favorite_screen()];

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

  final List<String> _filterStringType = [
    'كتب_وورق',
    'أثاث',
    'الكترونيات',
    'ملابس',
  ];

  final List<String> _filterStringCity = [
    'منطقة الرياض',
    'منطقة مكة المكرمة',
    'منطقة المدينة المنورة',
    'منطقة القصيم',
    'المنطقة الشرقية',
    'منطقة عسير',
    'منطقة تبوك',
  ];

  void _showSheetWithoutList() {
    showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.4,
      maxHeight: 1,
      context: context,
      builder: _buildBottomSheet,
      anchors: [0, 0.4, 0.4],
    );
  }

  Widget _buildBottomSheet(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        padding:
        const EdgeInsets.only(top: 40, right: 10, left: 10, bottom: 50),
        child: Material(
          color: Colors.white,
          child: Column(
            children: [
              const Center(
                child: Text(
                  "تصفية",
                  style: TextStyle(
                      fontFamily: 'almarai Bold',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ExpansionTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  "الأصناف",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  for (int i = 0; i < _filterStringType.length; i++)
                    GestureDetector(
                      onTap: (){
                        _charityDataConnection.addingFilter(_filterStringType[i]);
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        title: Text(
                          _filterStringType[i],
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                ],
              ),
              ExpansionTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  "المناطق",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                children: <Widget>[
                  for (int i = 0; i < _filterStringCity.length; i++)
                    GestureDetector(
                      onTap: (){
                        _charityDataConnection.addingFilter(_filterStringCity[i]);
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        title: Text(
                          _filterStringCity[i],
                          textAlign: TextAlign.end,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: const Text(
                        "الغاء",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _charityDataConnection.addingFilter('الكل');
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: const Text(
                        "الغاء جميع التصفية",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
            labelText: 'بحث',
            prefixIcon: Icon(
              Icons.search,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showSheetWithoutList,
            icon: Icon(Icons.filter_alt),
            color: Colors.grey[700],
          ),
          Image.asset("assets/finalLogo.jpeg")
        ],
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
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white70),
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 20,
                        offset: Offset(
                            -10.0, 10.0), // changes position of shadow
                      ),
                    ]),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _save(_charityDataConnection.allCharityList[index])
                            .whenComplete(() => setState(() {
                          print(index);
                          colors_list[index] = Colors.red;
                        }));
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
                                    id: _charityDataConnection
                                        .allCharityList[index].charityId,
                                    index: index,
                                    charityDataConnection: _charityDataConnection
                                )));
                      },
                      child: Container(
                        // height: 100,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Container(
                              width: 240,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                            .allCharityList[index].name,
                                        style: TextStyle(
                                            fontFamily: 'almarai Bold',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
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
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                          fontFamily: 'almarai Regular',
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
                              padding: const EdgeInsets.only(right: 4),
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
            );
          }),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icon(Icons.person), title: 'ملف شخصي'),
          TabItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              title: 'المفضلة '),
          TabItem(icon: Icon(Icons.assignment_rounded), title: 'الحالات‎'),
          TabItem(icon: Icon(Icons.house), title: 'الرئيسية'),
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
    } else if (selectedPage == 0) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    } else if (selectedPage == 3) {
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
    } else if (selectedPage == 1) {
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

  Future _save(CharityModel _CharityModel) async {
    // print('hello');

    int id = int.parse(_CharityModel.charityId);
    if (!myList.contains(id)) {
      myList.add(int.parse(_CharityModel.charityId));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> myList1 =
      (prefs.getStringList('mylist12') ?? List<String>.empty());
      List<int> myOriginaList = myList1.map((i) => int.parse(i)).toList();

      myListOfStrings = myList1.toList();
      myListOfStrings.add(_CharityModel.charityId);
      print('Your list  $myListOfStrings');
      await prefs.setStringList('mylist12', myListOfStrings);
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