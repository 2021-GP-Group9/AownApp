import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:aownapp/view_screen.dart';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'connection/charity_model.dart';
import 'connection/get_charaty_data.dart';
import 'home_screen/home_screen.dart';
import 'package:http/http.dart' as http;




class ViewScreen extends StatefulWidget {

  @override
  _ViewScreenState createState() => _ViewScreenState();
  final CharityModel charityModel;
  ViewScreen({Key? key,required this.charityModel}) : super(key: key);
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },

                child: Icon(
                  Icons.house,
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
      // body: Column(
      //   children:[
      //     Text(charityModel.name),
      //     Image.network(charityModel.imageString),
      //     Text(charityModel.description)
      //   ],
      // )

    );
  }}
