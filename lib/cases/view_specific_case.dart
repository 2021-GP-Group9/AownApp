import 'package:aownapp/cases/cases_connection.dart';
import 'package:aownapp/cases/cases_page.dart';
import 'package:aownapp/donation/donation_page.dart';
import 'package:aownapp/favoriteList/favoirte_screen.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class ViewSpecificPage extends StatefulWidget {
  String Id;
  CasesConnection casesConnection;

  ViewSpecificPage(this.Id, this.casesConnection, {Key? key}) : super(key: key);

  @override
  _ViewSpecificPageState createState() => _ViewSpecificPageState();
}

class _ViewSpecificPageState extends State<ViewSpecificPage> {
  int selectedPage = 2;
  final _pageOption = [Profile(), HomeScreen(), CasesPage(), Favorite_screen()];
  bool _showLoading = true;

  void _getThisSpecificCase() {
    widget.casesConnection.requestSpecificCase(widget.Id).then((value) {
      setState(() {
        _showLoading = false;
      });
    });
  }

  @override
  void initState() {
    _getThisSpecificCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          "تفاصيل الحالة‎",
          style:
              TextStyle(color: Colors.black87, fontFamily: 'Almarai Regular'),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CasesPage()),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            )),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/finalLogo.jpeg',
              fit: BoxFit.contain,
              width: 45,
              height: 45,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: (_showLoading)
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Center(
                child:
                    CircularProgressIndicator(color: const Color(0xffD6DACA)),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                // container 1 that contain every thing
                padding: const EdgeInsets.all(50),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 20,
                        offset:
                            Offset(-10.0, 10.0), // changes position of shadow
                      ),
                    ]),
                child: Column(
                  children: [
                   // Icon(widget.casesConnection.specificCase.icon, size: 50,),
                    Container(
                      child: Text(
                        widget.casesConnection.specificCase.itemName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Almarai Bold',
                          fontSize: 20, fontWeight: FontWeight.bold,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                        child: Text(
                            widget.casesConnection.specificCase
                                .donationDescription,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Almarai Bold',
                              fontSize: 14,
                            ))),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(children: <Widget>[
                      Expanded(
                          child: Text("معلومات الحالة‎:",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Almarai Bold',
                                fontSize: 14,
                              )))
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                          child: Text("",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Almarai Light',
                                fontSize: 14,
                              )))
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                        child:
                            Text(widget.casesConnection.specificCase.itemType,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'Almarai Light',
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                )),
                      ),
                      Expanded(
                          child: Text("نوع المنتج:",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Almarai Regular',
                                fontSize: 14,
                              )))
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                        child:
                            Text(widget.casesConnection.specificCase.itemSize,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'Almarai Light',
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                )),
                      ),
                      Expanded(
                          child: Text("حجم المنتج:",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Almarai Regular',
                                fontSize: 14,
                              )))
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                        child:
                            Text(widget.casesConnection.specificCase.itemColor,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'Almarai Light',
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                )),
                      ),
                      Expanded(
                          child: Text("لون المنتج:",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Almarai Regular',
                                fontSize: 14,
                              )))
                    ]),
                    Row(children: <Widget>[
                      Expanded(
                        child:
                            Text(widget.casesConnection.specificCase.itemCount,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'Almarai Light',
                                  fontSize: 14,
                                  color: Colors.blueGrey,
                                )),
                      ),
                      Expanded(
                          child: Text("عدد القطع:",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Almarai Regular',
                                fontSize: 14,
                              )))
                    ]),Row(children: <Widget>[
                      Expanded(
                          child: Text("",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Almarai Light',
                                fontSize: 14,
                              )))
                    ]),
                    Divider(
                      color: Colors.grey,
                    ),Row(children: <Widget>[
                      Expanded(
                          child: Text("",
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Almarai Light',
                                fontSize: 14,
                              )))
                    ]),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DonationPage(widget.Id, widget.casesConnection.specificCase)),
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text("تبرع الآن‎",
                              style: TextStyle(fontFamily: 'almarai Regular'))
                            ,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icon(Icons.person), title: 'ملف شخصي'),
          TabItem(icon: Icon(Icons.favorite,color: Colors.black,),title: 'المفضلة '),
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
    }else if (selectedPage == 1) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Favorite_screen()),
      );
    }
  }
}
