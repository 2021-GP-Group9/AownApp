import 'package:aownapp/cases/cases_connection.dart';
import 'package:aownapp/cases/view_specific_case.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';
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
      Favorite_screen()
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
}
