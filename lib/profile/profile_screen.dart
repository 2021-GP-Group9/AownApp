import 'dart:math';

import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:aownapp/login/login_screen.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../welcome_screen.dart';
import 'profile_data.dart';
import 'profile_conn.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedPage = 0;
  final _pageOption=[Profile(),HomeScreen()];
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    get_id();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>
                      WelcomeScrean()), (Route<dynamic> route) => false);
            },
            child: Icon(Icons.logout_rounded, color: Colors.black54,)
        ),
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'الملف الشخصي',
          style: TextStyle(color: Colors.black87),),
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

      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: -MediaQuery
                  .of(context)
                  .size
                  .height * .15,
              right: -MediaQuery
                  .of(context)
                  .size
                  .width * .4,
              child: Container(
                  child: Transform.rotate(
                    angle: -pi / 3.5,
                    child: ClipPath(
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .5,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.lightGreen.shade50,
                              Colors.lightGreen.shade50,

                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            Padding(

              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'الملف الشخصي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        onChanged: (String value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'الإسم',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ), SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        onChanged: (String value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius
                              .circular(30),),
                        ),
                      ), SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        onChanged: (String value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'رقم الجوال',
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius
                              .circular(30),),
                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.black87,
                            borderRadius: BorderRadius.circular(30)),

                        child: MaterialButton(
                          onPressed: () {
                            print(nameController.text);
                            print(emailController.text);
                            print(phoneController.text);
                          },
                          child: Text(
                            'حفظ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon:Icon(Icons.person),title:'ملف شخصي'),
          // TabItem(icon:Icon(Icons.add_circle),title:'موعد '),
          TabItem(icon:Icon(Icons.house),title:'الرئيسية'),
        ],
        height: 55,
        initialActiveIndex: selectedPage,
        onTap: (int index){
          print(index);
          setState(() {
            selectedPage = index;
            _pageOption[selectedPage];
            _pn(selectedPage);
          });
        },
        backgroundColor: const Color(0xffD6DACA),
      ),

    );;
  }
  _pn(int selectedPage) {
    if (selectedPage == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    }else if (selectedPage == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

    }
  }
}


void get_id() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // final SharedPreferences prefs = await _prefs;
  if (prefs.containsKey("idKey")) {
    print(prefs.getInt("idKey"));
    profile_date mydata=await Conn(prefs.getInt("idKey")).save_it_to_db() as profile_date;
    // profile_date mydata=Conn(prefs.getInt("idKey")).save_it_to_db() as profile_date;
    print(mydata.name.toString());
  }
  else {
    print(prefs.getInt("idKey"));
    print("key error");

  }
}

