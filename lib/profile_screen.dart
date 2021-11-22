import 'package:aownapp/book_appointment.dart';
import 'package:flutter/material.dart';

import 'home_screen/home_screen.dart';
class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
                // onTap: (){
                //   Navigator.push(context,
                //     MaterialPageRoute(builder: (context) =>Profile()),);
                // },
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
        child: Text("Profile"),
      ),
    );
  }
}
