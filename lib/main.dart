import 'package:aownapp/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/constant_controller.dart';
import 'login/login_screen.dart';
void main()
{
  Get.put(ConstantController());
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScrean(),
    );
  }
}