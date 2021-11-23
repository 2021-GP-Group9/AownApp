import 'dart:math';

import 'package:aownapp/home_screen/home_screen.dart';
import 'package:aownapp/sinup/signup_screen.dart';
import '../home_screen.dart';
import 'login_conn.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'تسجيل دخول',
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
      body:Container(
        child: Stack(
            children:[
        Positioned(
        top: -MediaQuery.of(context).size.height * .15,
        right: -MediaQuery.of(context).size.width * .4,
        child: Container(
            child: Transform.rotate(
              angle: -pi / 3.5,
              child: ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.lightGreen.shade50,
                        Colors.lightGreen.shade50,

                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'البريد الالكتروني',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    border: OutlineInputBorder( borderRadius: BorderRadius.circular(30),),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                    ),
                    border: OutlineInputBorder( borderRadius: BorderRadius.circular(30),),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration( color: Colors.black87,borderRadius: BorderRadius.circular(30)),

                  child: MaterialButton(

                    onPressed: () {
                      print(emailController.text);
                      print(passwordController.text);
                      Conn_login(emailController.text,passwordController.text).login_function().then((value){
                        print("login $value");
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>HomeScreen()),);
                      });

                     },
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>Signup()),);
                      },
                      child: Text(
                        'تسجيل جديد',
                      ),
                    ), Text(
                      'ليس لديك حساب؟',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
            ], ),
      ),
    );
  }
}