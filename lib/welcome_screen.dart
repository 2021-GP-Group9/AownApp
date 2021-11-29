//heloo
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';

import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';
import 'signup/signup_screen.dart';
import 'login/login_screen.dart';

class WelcomeScrean extends StatelessWidget {
  const WelcomeScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6DACB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/finalLogo.jpeg',
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
          ),
        SizedBox(height: 83,),
          Container(
            width: 200,
            height: 45,
            decoration: BoxDecoration( color: Colors.black87,borderRadius: BorderRadius.circular(30), boxShadow:[
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ] ) //border:Border.all( width: 10,color: Colors.black12)),
            ,
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>Signup()),);
              },
              child: Center(child: Text("تسجيل جديد",style: TextStyle(color: Colors.white),)),
            ),
          ),

          SizedBox(height:28,),
          Container(
            width: 200,
            height: 45,
            decoration: BoxDecoration( color: Colors.black87,borderRadius: BorderRadius.circular(30),boxShadow:[
            BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ] ),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>LoginScreen()),);
              },
            child: Center(child: Text("دخول",style: TextStyle(color: Colors.white),)),
          ),
          ),

          SizedBox(height:28,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>HomeScreen()),);
                },
                child: Text(
                  '<<تخطي',
                    style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
        ],

      ),
    );
  }
}


