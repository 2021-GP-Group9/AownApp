import 'package:aownapp/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

import 'home_screen/home_screen.dart';
class Book_appointment extends StatelessWidget {
  const Book_appointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffd6daca),
          actions: [

            Image.asset("assets/finalLogo.jpeg")
          ],
        ),
      bottomNavigationBar: Container(
        color:
        const Color(0xffD6DACA),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>Profile()),);
                },
                child: Icon(Icons.person,)),
            GestureDetector(
                onTap: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>Book_appointment()),);
                },
                child: Icon(Icons.add_circle,size: 49,)),
        GestureDetector(
            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>HomeScreen()),);
            },
            child: Icon(Icons.house))


          ],
        ),
      ),
      body:Column(
        children: [
      TableCalendar(
      firstDay: DateTime.utc(2021, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
        
    ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              //changes
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: 34,
                    width: 120,

                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(6))

                    ),
                    child: Center(child: Text("الغاء",style: TextStyle(color: Colors.white),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: 34,
                    width: 120,

                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(6))

                    ),
                    child: Center(child: Text("حجز موعد",style: TextStyle(color: Colors.white),)),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
