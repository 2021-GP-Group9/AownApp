//heloo
import 'package:flutter/material.dart';

class WelcameScrean extends StatelessWidget {
  const WelcameScrean({Key? key}) : super(key: key);

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

               child: Center(child: Text("Sign In",style: TextStyle(color: Colors.white),)),
            ),
          SizedBox(height:28,),
          Container(
            width: 290,
            height: 45,
            decoration: BoxDecoration( color: Colors.black87,borderRadius: BorderRadius.all(Radius.circular(6))),

            child: Center(child: Text("Log In",style: TextStyle(color: Colors.white),)),
          ),

        ],
      ),
    );
  }
}


