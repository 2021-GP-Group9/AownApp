import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../global.dart';
import '../chat_db.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatInputField extends StatefulWidget {
  final  String charityId;
  const ChatInputField(this.charityId, {
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController message=new  TextEditingController();
  Conn_chat db= new Conn_chat();
  String user_id=AppColors.user;
  bool display=true;
  Future<void> getuser_id()async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.containsKey("idKey")) {

      user_id=prefs.get('idKey').toString();
      print("user_id1");
      print(user_id);
      // requestData(); // method load befor load the page to get information of charities

    }else{
      //requestData();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: display?Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: message,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    //send button
                    GestureDetector(
                      onTap: (){
                        print('hello');
                        if(message.text==" "){
                          print("no Message");
                        }
                        else{
                          send_message(message.text);
                          setState(() {
                            message.text="";
                          });

                        }

                      },
                      child:Icon(Icons.send_sharp, size: 30, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ):Center(child: CircularProgressIndicator()),
      ),
    );
  }
//send message to db
  void send_message(String message) {
    setState(() {
      display=false;
    });
    getuser_id().then((value) {

      db.store_message(message,widget.charityId, user_id).then((value) {
        setState(() {
          display=true;
        });
      });
    });
  }
}
