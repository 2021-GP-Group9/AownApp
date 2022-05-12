// ignore_for_file: file_names
import 'package:aownapp/cases/cases_page.dart';
import 'package:aownapp/connection/get_charaty_data.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:aownapp/rating_star.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Comment_Conn.dart';
import 'bookAppointment/book_appointment_screen.dart';
import 'comment.dart';
import 'connection/charity_model.dart';
import 'favoriteList/favoirte_screen.dart';
import 'global.dart';
import 'home_screen/home_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'donate_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ViewPage extends StatefulWidget {
  final String id;
  final int index;
  final CharityDataConnection charityDataConnection;

  const ViewPage(
      {Key? key,
        required this.id,
        required this.index,
        required this.charityDataConnection})
      : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  late String user_id=AppColors.user;
  bool _recommendationLoading = true;
  int selectedPage = 3;
  final _pageOption = [Profile(), HomeScreen(), CasesPage(), Favorite_screen()];
  List<CharityModel> _recommendedList = [];

  dynamic comments;
  late CharityModel charityModel;
  bool display_comment=false;
  int display=0;
  bool disp=true;
  final TextEditingController commentController = TextEditingController();


  void getCharity() {
    setState(() {
      charityModel = widget.charityDataConnection.getThisCharity(widget.id);
    });
  }

  void getRecommendations() async {
    await widget.charityDataConnection
        .getRecommendation(
        charityModel.donationType, charityModel.city, charityModel.service)
        .then((value) {
      _recommendedList.clear();
      _recommendedList.addAll(value);
      setState(() {
        _recommendationLoading = false;
      });
    });
  }
  double rating_value=0.0;
  @override
  void initState() {
    getCharity();
    getRecommendations();
    getuser_id().then((value) {
      setState(() {

      });
    });

    super.initState();
  }
var height;
  var width;
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=double.infinity;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'تفاصيل الجمعية الخيرية',
          style:
          TextStyle(color: Colors.black87, fontFamily: 'Almarai Regular'),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            )
        ),
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
      body: SingleChildScrollView(
        child: Container(
          // container 1 that contain every thing
            padding: const EdgeInsets.all(40),

            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius: 20,
                    offset: Offset(-10.0, 10.0), // changes position of shadow
                  ),
                ]),
            child: disp?Column(
              children: [
                Container(
                  child: Text(
                    charityModel.name,
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
                  height: 100,
                  width: 100,
                  child: (charityModel.imageString == "")
                      ? Icon(Icons.image, size: 100)
                      : charityModel.image,
                ),
                Container(
                    child: Text(charityModel.description,
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
                      child: Text("معلومات الجمعية:",
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
                    child: Text(charityModel.licenseNumber,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light',
                          fontSize: 14,
                          color: Colors.blueGrey,
                        )),
                  ),
                  Expanded(
                      child: Text("رقم الترخيص:",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Almarai Regular',
                            fontSize: 14,
                          )))
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Text(charityModel.city,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light',
                          fontSize: 14,
                          color: Colors.blueGrey,
                        )),
                  ),
                  Expanded(
                      child: Text("المدينة:",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Almarai Regular',
                            fontSize: 14,
                          )))
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Text(charityModel.location,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light',
                          fontSize: 14,
                          color: Colors.blueGrey,
                        )),
                  ),
                  Expanded(
                      child: Text("الموقع:",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Almarai Regular',
                            fontSize: 14,
                          )))
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Text(charityModel.donationType,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light',
                          fontSize: 14,
                          color: Colors.blueGrey,
                        )),
                  ),
                  Expanded(
                      child: Text("نوع التبرعات:",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Almarai Regular',
                            fontSize: 14,
                          )))
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Text(charityModel.service,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light',
                          fontSize: 14,
                          color: Colors.blueGrey,
                        )),
                  ),
                  Expanded(
                      child: Text("استلام التبرعات من المنزل:",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Almarai Regular',
                            fontSize: 14,
                          )))
                ]),
                Divider(
                  color: Colors.grey,
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: Text("للتواصل:",
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
                    child: Text(charityModel.phone,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light',
                          fontSize: 14,
                          color: Colors.blueGrey,
                        )),
                  ),
                  Expanded(
                      child: Text("رقم الهاتف:",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Almarai Regular',
                            fontSize: 14,
                          )))
                ]),
                Row(children: <Widget>[
                  Expanded(
                    child: Text(charityModel.email,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light',
                          fontSize: 14,
                          color: Colors.blueGrey,
                        )),
                  ),
                  Expanded(
                      child: Text("البريد الإلكتروني:",
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Almarai Regular',
                            fontSize: 14,
                          )))
                ]),
                Divider(
                  color: Colors.grey,
                ),
                Row(children: <Widget>[
                  if (charityModel.service == 'نعم')
                    Expanded(
                        child: Container(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Book_appointment(
                                        charityId: charityModel.charityId,
                                      )),
                                );
                              },
                              child: Icon(
                                Icons.calendar_today_outlined,
                                size: 30,
                              )),
                        )),
                  if (charityModel.service == 'نعم')
                    Expanded(
                        child: Text("لحجز مواعيد الاستلام >>>",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'Almarai Light',
                              fontSize: 14,
                            )))
                ]),

                // const SizedBox(
                //   height: 1,
                //
                // ),

                Divider(
                  color: Colors.grey,
                ),
                ElevatedButton(


                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    //  textStyle: TextStyle(
                    //      fontSize: 15,
                    //fontWeight: FontWeight.bold)
                  ),
                  onPressed: () {
                  print("hello"); // just try

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    // hello()),
                    Donate_Screen( user_id: user_id, charity_id: charityModel.charityId,charity_name:charityModel.name)),

                  );


                },

                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text("     تبرع للجمعية   ",
                          style: TextStyle(fontFamily: 'almarai Regular'))
                      ,
                    ),
                  ),
                ),



                (_recommendationLoading)
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffD6DACB),
                  ),
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    const Text(

                      "جمعيات مشابهة:",
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Bold',
                        fontSize: 14,
                        height: 4,
                      ),
                    ),
                    const SizedBox(
                      height: 2,

                    ),
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          scrollDirection: Axis.horizontal,
                          itemCount: _recommendedList.length,
                          // #of charities
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Colors.white70),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.3),
                                      spreadRadius: 4,
                                      blurRadius: 20,
                                      offset: Offset(-10.0,
                                          10.0), // changes position of shadow
                                    ),
                                  ]),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewPage(
                                              id: _recommendedList[index]
                                                  .charityId,
                                              index: index,
                                              charityDataConnection: widget
                                                  .charityDataConnection)));
                                },
                                child: Container(
                                   height: 100,

                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,

                                    children: [
                                      Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 49,
                                              width: 49,
                                              child: (_recommendedList[
                                              index]
                                                  .imageString ==
                                                  "")
                                                  ? Icon(Icons.image,
                                                  size: 49)
                                                  : _recommendedList[
                                              index]
                                                  .image,
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.all(8.0),
                                              child: Text(
                                                _recommendedList[index]
                                                    .name,
                                                style: TextStyle(
                                                    fontFamily:
                                                    'almarai Light',
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.bold),
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
                    ),
                  ],
                ),


                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      // textStyle: TextStyle(
                      //     fontSize: 30,
                      //     fontWeight: FontWeight.bold)
                  ),

                  onPressed: () {
                  print("hello");

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                    // hello()),
                    comment( user_id,charityModel.charityId)),
                  );

                }, child:Row(

                  mainAxisAlignment: MainAxisAlignment.end,
                children:[
                  Icon(
                    Icons.arrow_back,

                  ),
                  SizedBox(width: 188,),
                  Text("التعليقات والتقييم"),


                ]

                ),),

              ],
            ):Center(child: SingleChildScrollView())
        ),
      ),

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
  Widget commentChild(data) {
    return
      ListView(
        shrinkWrap: true,
        children: [
          for (var i = 0; i < data.length; i++)
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Colors.black
                      )
                  ),
                  child: Text(
                    data[i]['comment_text'],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                StarRating(
                  rating:double.parse(data[i]['rating']),
                  onRatingChanged: (rating) => setState((){

                    // setState(() {
                    //   rating_value=rating;
                    // });

                  })
                  , color: Colors.yellow,
                ),
              ],
            ),



        ],
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



  Future<void> getuser_id()async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.containsKey("idKey")) {

      user_id=prefs.get('idKey').toString();
      print("user_id1");
      print(user_id);
      // method load befor load the page to get information of charities

    }else{

    }

  }

}