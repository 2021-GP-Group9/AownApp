
import 'package:flutter/material.dart';


import '../../constant.dart';

class Message extends StatelessWidget {
  const Message( {
    Key? key,
    required this.message,
    required this.charity_id,
    required this.user_id

  }) : super(key: key);

  final dynamic message;
  final String charity_id;
  final String user_id;


  @override
  Widget build(BuildContext context) {

    Radius radius=new Radius.circular(50);
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
        message['fromUser']==user_id ? MainAxisAlignment.start :
        MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            //width: 250,
            decoration: BoxDecoration(
              color: message['fromUser']==user_id ? Colors.grey:Colors.blue,
              //  borderRadius: new BorderRadius.all(radius),
            ),
            child: Expanded(
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        message['message'],
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    // SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
