import 'package:aownapp/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';
class Book_appointment extends StatelessWidget {
  const Book_appointment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xffD6DACA),
        height: 50,
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
      body: Container(

        child: Center(
          child: Text("Book appoinment"),
        ),
      ),
    );
  }
}
