import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant.dart';
import '../global.dart';
import 'chat_db.dart';
import 'components/chat_input_field.dart';
import 'components/message.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Body extends StatefulWidget {
  final  String charityId;
  Body( this.charityId);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Conn_chat db= new Conn_chat();
  String user_id=AppColors.user;
  dynamic Messages;
  bool display=false;

  final StreamController<List<dynamic>> readingStreamController = StreamController<List<dynamic>>();
//for less respones time
  void startStreamReadingList() async {
    Timer.periodic(
      Duration(seconds: 10),
          (timer) async {
        if (readingStreamController.isClosed) return timer.cancel();
        getuser_id().then((value) {
          db.get_messages(widget.charityId, user_id).then((value) {
            print(value);
            //Messages=value;
            readingStreamController.sink.add(value);
            setState(() {
              display = true;
            });
            // print(Messages.length);
          });
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    update_status(widget.charityId,user_id).then((value) {

      print(value);
    });
    startStreamReadingList();
  }
  Future<dynamic> update_status(String charityId,String donorId) async {
    print(charityId);
    dynamic json;
    // var request = http.Request('GET', Uri.parse('${constant.comment}?charity_id=$charity_id'));
    var request = http.Request('GET', Uri.parse('${constant.update_status}?'
        'fromUser=${charityId}&toUser=${donorId}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print();
      json=(await response.stream.bytesToString());
      return json;
    }
    else {
      print(response.reasonPhrase);
    }
    return json;
  }

  @override
  void dispose() {
    readingStreamController.close();
    super.dispose();
  }
//user id for the db
  // to know which user sent
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

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              //height: 600,
              // width: 400,
              child: StreamBuilder<List<dynamic>>(
                stream: readingStreamController.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    // the messages
                    itemBuilder: (context, index) =>
                        Message(message:  snapshot.data![index],charity_id:widget.charityId,user_id:user_id),
                  );
                },
              ),
            ),
          ),
          ChatInputField(widget.charityId),
        ],
      ),
    );
  }
}


