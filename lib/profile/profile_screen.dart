import 'dart:math';

import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
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
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      // get_id();
    }
    return Scaffold( bottomNavigationBar: Container(
      color: Color(0xffD6DACA),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            // onTap: (){
            //   Navigator.push(context,
            //     MaterialPageRoute(builder: (context) =>Profile()),);
            // },
              child: Icon(Icons.person, size: 35,)),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => Book_appointment()),);
              },
              child: Icon(Icons.add_circle, size: 49,)),


          GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),);
              },
              child: Icon(Icons.house, size: 35,))


        ],
      ),
    ),
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


    );;
  }
}


  // void get_id() async {
  //   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //   final SharedPreferences prefs = await _prefs;
  //   if (prefs.containsKey("idKey")) {
  //     profile_date mydata=Conn(prefs.getInt("idKey")).save_it_to_db() as profile_date;
  //     print(mydata.name);
  //   }
  //   else {
  //     print("key error");
  //
  //   }
  // }

