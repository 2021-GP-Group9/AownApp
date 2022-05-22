import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant.dart';

class Message extends StatefulWidget {
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
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  late String formattedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.parse(widget.message['time']);
    formattedDate= DateFormat('dd-MM-yy - kk:mm').format(now);
  }
  @override
  Widget build(BuildContext context) {
    Radius radius=new Radius.circular(50);
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
              widget.message['fromUser']==widget.user_id ? MainAxisAlignment.start :
              MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.message['fromUser']==widget.user_id ? Colors.grey:Colors.black12,
                      borderRadius: new BorderRadius.circular(15),
                      //  borderRadius: new BorderRadius.all(radius),
                    ),
                    child: Text(
                      widget.message['message'],
                     // textAlign: TextAlign.right ,
                      //textDirection: TextDirection.rtl,
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Almarai Regular',),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment:
            widget.message['fromUser']==widget.user_id ? MainAxisAlignment.start :
            MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  formattedDate,
                  style:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500,fontFamily: 'Almarai Regular',),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

