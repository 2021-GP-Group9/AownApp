import 'dart:ui';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // main axis alignment : start
    // cross axis alignment : center

    return Scaffold(

      body: Text(
      'home page',
      style: TextStyle(

        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

  // when notification icon button clicked
  void onNotification() {
    print('notification clicked');
  }
}