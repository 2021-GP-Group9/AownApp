
import 'package:aownapp/connection/charity_model.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'body.dart';


class MessagesScreen extends StatefulWidget {
  final  CharityModel user;
  MessagesScreen(this.user);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(widget.user.charityId),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xffD6DACA),

      title: Row(
        children: [
          BackButton(color: Colors.grey,),
          // CircleAvatar(
          //   backgroundImage: AssetImage("assets/images/user_2.png"),
          // ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),

            ],
          )
        ],
      ),

    );
  }
}
