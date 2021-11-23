

import 'package:aownapp/book_appointment.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // main axis alignment : start
    // cross axis alignment : center

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
      Icon(Icons.house)


    ],
  ),
),
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffD6DACA),
        // leading: Icon(Icons.search),
   title:TextFormField(
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
       labelText: 'بحث',
       prefixIcon: Icon(
         Icons.search,
       ),
       // suffixIcon: Icon(
       //   Icons.remove_red_eye,
       // ),
       // border: OutlineInputBorder(),
     ),
   ),
        actions: [

          Image.asset("assets/finalLogo.jpeg")
        ],
      ),

      body:ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          itemCount: 10, // #of charities
          itemBuilder: (BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(top:50,),
      child: Container(
      height: 100,
      color: const Color(0xffD6DACA),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 40,),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center
              ,crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("text 1 small",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("text 2 this is a long text"),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40,left: 30),
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