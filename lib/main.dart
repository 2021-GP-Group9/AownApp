import 'package:aownapp/welcame_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

void main()
{
  runApp(MyApp());
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcameScrean(),
    );
  }
}