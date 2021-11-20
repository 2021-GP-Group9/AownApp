//heloo
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

class WelcomeScrean extends StatelessWidget {
  const WelcomeScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6DACB),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/finalLogo.jpeg',
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
          ),
        SizedBox(height: 83,),
             Container(
              width: 290,
             height: 45,
              decoration: BoxDecoration( color: Colors.black87,borderRadius: BorderRadius.all(Radius.circular(6))),
               child: MaterialButton(
                 onPressed: () {
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) =>Signup()),);
                 },
                 child: Text(
                   'تسجيل جديد',
                   style: TextStyle(
                     color: Colors.white,
                   ),
                 ),
               ),
             ),
          SizedBox(height:28,),
          Container(
            width: 290,
            height: 45,
            decoration: BoxDecoration( color: Colors.black54,borderRadius: BorderRadius.all(Radius.circular(6))),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>LoginScreen()),);
              },
            child: Center(child: Text("دخول",style: TextStyle(color: Colors.white),)),
          ),
          ),

          SizedBox(height:28,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>HomeScreen()),);
                },
                child: Text(
                  '<<تخطي',
                    style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
        ],

      ),
    );
  }
}


