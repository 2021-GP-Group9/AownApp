import 'dart:ui';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // main axis alignment : start
    // cross axis alignment : center

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xffD6DACA),
        leading: Icon(Icons.search),
        actions: [

          Image.asset("assets/finalLogo.jpeg")
        ],
      ),

      body:ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top:50,),
      child: Container(
      height: 100,
      color: const Color(0xffD6DACA),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("text 1"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("text 2"),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Container(
              height:45,
              width: 45,
              child: Image.asset("assets/finalLogo.jpeg",fit: BoxFit.cover,),
            ),
          )
        ],

      ),

      ),
    );
    }
    ),

    );
  }

  // when notification icon button clicked
  void onNotification() {
    print('notification clicked');
  }
}