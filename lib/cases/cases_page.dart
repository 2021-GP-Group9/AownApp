import 'package:aownapp/cases/cases_connection.dart';
import 'package:aownapp/cases/view_specific_case.dart';
import 'package:aownapp/chat/chat_screen.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:aownapp/favoriteList/favoirte_screen.dart';

class CasesPage extends StatefulWidget {
  const CasesPage({Key? key}) : super(key: key);

  @override
  _CasesPageState createState() => _CasesPageState();
}

class _CasesPageState extends State<CasesPage> {
  final CasesConnection _casesConnection = CasesConnection();
  bool _isLoadingData = true;

  void _requestForAllCasesList() {
    _casesConnection.requestAllCasesList().then((value) {
      setState(() {
        _isLoadingData = false;
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
                        _casesConnection.addingFilter(_filterStringType[i]);
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
                        _casesConnection.addingFilter(_filterStringCity[i]);
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
                      _casesConnection.addingFilter('الكل');
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
    _requestForAllCasesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int selectedPage = 2;
    final _pageOption = [
      Profile(),
      HomeScreen(),
      CasesPage(),
      Favorite_screen(),
      ChatsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffD6DACA),
        // leading: Icon(Icons.search),
        title: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          obscureText: false,
          onFieldSubmitted: (String value) {
            print(value);

          },

          onChanged: (String value) {
            setState(() {
              _casesConnection.searchingTheCasesList(value);
            });
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
              itemCount: _casesConnection.getAllCasesList.length,
              // #of charities
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewSpecificPage(
                                _casesConnection
                                    .getAllCasesList[index].donationId,
                                _casesConnection)),
                      );
                    },
                    child: Container(
                      // height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Colors.white70) ,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50)),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              _casesConnection.getAllCasesList[index].icon,
                              size: 50,
                            ),
                          ),
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
                                      _casesConnection
                                          .getAllCasesList[index].itemName,
                                      style: TextStyle(
                                          fontFamily: 'almarai Bold',
                                          fontSize: 15,
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
                                    child: Text(
                                      _casesConnection
                                          .getAllCasesList[index].itemType,
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
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 145,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      _casesConnection.getAllCasesList[index]
                                          .donationDescription,
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
                        ],
                      ),
                    ),
                  ),
                );
              }),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icon(Icons.person), title: 'ملف شخصي'),
          TabItem(icon: Icon(Icons.chat), title: 'المحادثات'),
          TabItem(icon: Icon(Icons.assignment_rounded), title: 'الحالات‎'),
          TabItem(icon: Icon(Icons.favorite,color: Colors.black,),title: 'المفضلة '),
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
}
