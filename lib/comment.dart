import 'package:aownapp/rating_star.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'Comment_Conn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global.dart';

class comment extends StatefulWidget {
  late final String id;
  late final String charity_id;

  comment(this.id, this.charity_id);

  @override
  _commentState createState() => _commentState();


}

class _commentState extends State<comment> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  dynamic comments;
  bool display_comment=false;
  int display=0;
  bool disp=true;
  double rating_value=0.0;
  String user_id=AppColors.user;
  double average_rating=0.0;
  //final TextEditingController commentController = TextEditingController();
  @override
  void initState() {

    getComments(widget.charity_id);

    super.initState();
  }


  Widget commentChild(data) {
    return
      ListView(
        shrinkWrap: true,
        children: [
          for (var i = 0; i < data.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  //  width: 800,
                  decoration: BoxDecoration(
                    //  color: Colors.green,
                    // border: Border.all(
                    //     width: 1,
                    //     color: Colors.black
                    // )
                  ),
                  child: Text(
                    data[i]['comment_text'],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                StarRating(
                  rating:double.parse(data[i]['rating']),
                  onRatingChanged: (rating) => setState((){
                  })
                  , color: Colors.yellow,
                ),
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),



        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Comments "),
    //     backgroundColor: Colors.pink,
    //   ),
    //   body: Container(
    //     width: 400,
    //     height: 500,
    //     child: CommentBox(
    //       userImage: "\/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
    //       child: commentChild(filedata),
    //       labelText: 'Write a comment...',
    //       withBorder: false,
    //       errorText: 'Comment cannot be blank',
    //       sendButtonMethod: () {
    //         if (formKey.currentState!.validate()) {
    //           print(commentController.text);
    //           setState(() {
    //             var value = {
    //               'name': 'New User',
    //               'pic':
    //               'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
    //               'message': commentController.text
    //             };
    //             filedata.insert(0, value);
    //           });
    //           commentController.clear();
    //           FocusScope.of(context).unfocus();
    //         } else {
    //           print("Not validated");
    //         }
    //       },
    //       formKey: formKey,
    //       commentController: commentController,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'التقييم و التعليقات',
          style:
          TextStyle(color: Colors.black87, fontFamily: 'Almarai Regular'),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            )),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //Text("ملاحظة:لا يسمح لك التقييم إلا بعد حجز موعد ",
                //textAlign: TextAlign.left,

                //style:TextStyle(fontSize: 18,color: Colors.black),),
              Text("تقييم الجمعية",
                style: TextStyle(fontSize: 30,color: Colors.black),),
              Row(

                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Text((average_rating.toStringAsFixed(2)),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 30),),


                  SizedBox(width: 50,),
                  StarRating(
                    rating:average_rating,
                    onRatingChanged: (rating) => setState((){
                    })
                    , color: Colors.yellow,
                  ),



                ]
                ,),

              Divider(
                color: Colors.grey,
              ),


              display==1?Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("التعليقات:",style: TextStyle(fontSize: 20,color: Colors.black),),
                ],
              ):Text("لا يوجد تتعليقات !"),
              display==1?
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Container(
                      width: 392,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.black
                        ),),
                      //   //color: Colors.yellow,
                      // ),
                      child: commentChild(comments),
                    ),
                  ),
                ],
              ) :display==2?Container():Center(child: CircularProgressIndicator()),
              display_comment?Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("قيَم الجمعية"), SizedBox(width: 40,),
                  StarRating(
                    rating:rating_value,
                    onRatingChanged: (rating) => setState((){

                      setState(() {
                        rating_value=rating;
                      });

                    }), color: Colors.yellow,
                  ),
                ],
              ):Container(),
              display_comment?ListTile(
                tileColor: Colors.white,
                // leading: Container(
                //   height: 40.0,
                //   width: 40.0,
                //   decoration: new BoxDecoration(
                //       color: Colors.blue,
                //       borderRadius: new BorderRadius.all(Radius.circular(50))),
                //   child:
                //   CircleAvatar(
                //       radius: 50, backgroundImage: NetworkImage("https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400"
                //   )),
                // ),
                title: Form(
                  child: TextFormField(
                    maxLines: 10,
                    minLines: 1,
                    //  focusNode: focusNode,
                    //  cursorColor: textColor,
                    style: TextStyle(color: Colors.black),
                    controller: commentController,
                    // decoration: InputDecoration(
                    //   enabledBorder: !withBorder
                    //       ? InputBorder.none
                    //       : UnderlineInputBorder(
                    //     borderSide: BorderSide(color: textColor!),
                    //   ),
                    //   focusedBorder: !withBorder
                    //       ? InputBorder.none
                    //       : UnderlineInputBorder(
                    //     borderSide: BorderSide(color: textColor!),
                    //   ),
                    //   border: !withBorder
                    //       ? InputBorder.none
                    //       : UnderlineInputBorder(
                    //     borderSide: BorderSide(color: textColor!),
                    //   ),
                    //   labelText: labelText,
                    //   focusColor: textColor,
                    //   fillColor: textColor,
                    //   labelStyle: TextStyle(color: textColor),
                    // ),
                    // validator: (value) => value!.isEmpty ? errorText : null,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: (){
                    disp=false;
                    setState(() {

                    });
                    sendButtonMethod(commentController.text,rating_value);
                  },
                  child:Icon(Icons.send_sharp, size: 30, color: Colors.black),
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );

  }
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
  void sendButtonMethod(String text, double rating_value) {
    Conn_Review db=new Conn_Review();
    getuser_id().then((value) {

      print("Yes");
      db.store_review(text,rating_value,widget.charity_id,user_id).then((value) {
        setState(() {
          display_comment=false;
          disp=true;
          comments=null;
          setState(() {
            display=0;
          });
          getComments(widget.charity_id);
        });
      });
    });

  }

  Future<void> getComments(String charityId) async {

    Conn_Review db=new Conn_Review();
    db.get_review(charityId).then((value) {
      print(value);
      if(value!="no data"){
        get_averge_rating(value);
        print("get ${value[0]['comment_text']}");
        getuser_id().then((value1) {
          db.get_donation_status(charityId,user_id).then((value3) {
            print(value3);
            if(value3=="no"){
              setState(() {
                display_comment=false;
              });
            }else{
              setState(() {
                display_comment=true;
                Get.snackbar(

                    'تنبيه', ' ملاحظة:لا يسمح لك التقييم والتعليق إلا بعد حجز موعد لدى هذه الجمعية');

              });


            }
          });


          setState(() {
            comments=value;
            display=1;
          });
        });

      }
      else{
        getuser_id().then((value1) {
          db.get_donation_status(charityId,user_id).then((value) {
            print(value);
            if(value=="no"){
              setState(() {
                display_comment=false;
                display=2;
                rating_value=0.0;
              });
            }else{
              setState(() {
                display_comment=true;
                display=2;
                rating_value=0.0;
              });
            }
          });
        });

      }


    });
  }

  void get_averge_rating(value) {
    double sum=0.0;
    for(int i=0;i<value.length;i++){
      sum=sum+double.parse(value[i]['rating']);
    }
    average_rating=(sum/value.length);
    setState(() {

    });

  }
}