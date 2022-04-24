import 'package:aownapp/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'cases/cases_page.dart';
import 'favoriteList/favoirte_screen.dart';
import 'home_screen/home_screen.dart';

class Donate_Screen extends StatefulWidget {
   Donate_Screen({Key? key,required this.user_id,required this.charity_id, required this.charity_name}) : super(key: key);

      String charity_name;
      String user_id;
      String charity_id;


  @override
  _Donate_ScreenState createState() => _Donate_ScreenState();
}

class _Donate_ScreenState extends State<Donate_Screen> {
   TextEditingController _donate_text_field=new TextEditingController();
   String? _err_msg="null";
   int selectedPage = 3;
   final _pageOption = [Profile(), HomeScreen(), CasesPage(), Favorite_screen()];

     @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'التبرع المباشر',
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
       body: SafeArea(
      child:Center(
      child: Container(
      width: 350,
      height: 300,
      padding: new EdgeInsets.all(10.0),
      child: Card(
         color:Colors.white,
         child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("ادخل المبلغ للتبرع لـ (${widget.charity_name})"),
            _err_msg!="null"?Align(
              alignment: Alignment.center,
              child: Text(_err_msg.toString(),style: TextStyle(color: Colors.red),),

                   ):Container(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
            width:100,
                decoration: BoxDecoration(
                border: Border.all(
                      width: 1,
                      color: Colors.grey,
                  )
                ),
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _donate_text_field,
                  decoration: InputDecoration(
                    hintText: "10",

                  ),
                ),
              ),
            ),

            Container(
              //color : Colors.grey,
                child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                     // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                     //  textStyle: TextStyle(
                     //      fontSize: 15,
                           //fontWeight: FontWeight.bold)
                ),
                  onPressed: (){
                    if(_donate_text_field.text.trim().isEmpty){
                      _err_msg="ادخل المبلغ كعدد صحيح";
                      setState(() {

                      });
                    }
                    else {
                      _launchInBrowser(_donate_text_field.text);
                    }

                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      //color : Colors.grey,
                    ),
                    child: Center(
                      child: Text("     تبرع للجمعية   ",
                          style: TextStyle(fontFamily: 'almarai Regular'))
                      ,
                    ),
                  ),
                ),
                ),
          ],
        ),
    ), ),),),
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
  Future<void> _launchInBrowser(String amount) async {

    String url="https://awoon.000webhostapp.com/test_payment.php?amount=$amount &&user_id=${widget.user_id}&& charity_id=${widget.charity_id}";

    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch1 $url';
    }
  }
}

