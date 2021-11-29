import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:aownapp/view_screen.dart';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';

import 'home_screen/home_screen.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: Container(
        color: Color(0xffD6DACA),
    height: 70,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Profile()),
    );
    },
    child: Icon(
    Icons.person,
    size: 35,
    )),
    GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Book_appointment()),
    );
    },
    child: Icon(
    Icons.add_circle,
    size: 49,
    )),
    GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> HomeScreen()),
        );
      },

    child: Icon(
    Icons.house ,
    size: 35,)
    )
    ],
    ),
    ),
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'تفاصيل الجمعية الخيرية',
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
    );

}
}
