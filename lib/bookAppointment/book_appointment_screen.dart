import 'dart:convert';


import 'package:aownapp/appointment/appointment_model.dart';
import 'package:aownapp/bookAppointment/book_appointment_controller.dart';
import 'package:aownapp/controller/constant_controller.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:aownapp/location/location_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:aownapp/constant.dart';
class Book_appointment extends StatelessWidget {
  final String charityId;
  String? donorLocation;

  Book_appointment({Key? key,required this.charityId,this.donorLocation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "حجز المواعيد ",
      home: Calendar(charityId: charityId,donorLocation: donorLocation,),
    );
  }
}
class Calendar extends StatefulWidget {
  final String charityId;
  String? donorLocation;

  Calendar({Key? key,required this.charityId,this.donorLocation}) : super(key: key);
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int selectedPage = 0;
  final _pageOption=[Profile(),HomeScreen()];
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  BookAppointmentController _bookAppointmentController=Get.put(BookAppointmentController());
  ConstantController _constantController=Get.find<ConstantController>();
  Future<AppointementModel>? getAppointementRef;
  List<Event> eventList=[];
  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    print(_bookAppointmentController.selectedEvents[DateFormat('yyyy-MM-dd').format(date)] ?? []);
    eventList=_bookAppointmentController.selectedEvents[DateFormat('yyyy-MM-dd').format(date)] ?? [];
    return _bookAppointmentController.selectedEvents[DateFormat('yyyy-MM-dd').format(date)] ?? [];

  }

  @override
  void dispose(){
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var floatingActionButton;
    return Scaffold(
      appBar: AppBar(
        title: Text("جدول المواعيد"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffd6daca),
        actions: [Image.asset("assets/finalLogo.jpeg")],
      ),

      body: FutureBuilder<AppointementModel?>(
          future: _bookAppointmentController.getAppointmentApi(widget.charityId, _constantController.donorId!),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.done){

              return  Column(
                children: [
                  TableCalendar(
                    focusedDay: selectedDay,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2030, 3, 14),
                    calendarFormat: format,
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    daysOfWeekVisible: true,

                    //Day changed
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                      //test
                      print(focusedDay);
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    //eventLoader: (Dat),

                    // To style the Calendar
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Colors.green,
                        //can be change to rectangle as:
                        // shape: BoxShape.rectangle,
                        //BorderRadius : BorderRadius.circular(5.0),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      todayDecoration: BoxDecoration(
                        color: Colors.pink,
                        //can be change to rectangle as:
                        // shape: BoxShape.rectangle,
                        //BorderRadius : BorderRadius.circular(5.0),
                        shape: BoxShape.circle,
                      ),
                      defaultDecoration: BoxDecoration(
                        // color: Colors.pink,
                        //can be change to rectangle as:
                        // shape: BoxShape.rectangle,
                        //BorderRadius : BorderRadius.circular(5.0),
                        shape: BoxShape.circle,
                      ),
                      weekendDecoration: BoxDecoration(
                        //can be change to rectangle as:
                        // shape: BoxShape.rectangle,
                        //BorderRadius : BorderRadius.circular(5.0),
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      formatButtonShowsNext: false,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      formatButtonTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //if(snapshot.data!=null)
                  Expanded(
                    child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 50, // <== change the height to fit your needs
                    ),
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _getEventsfromDay(selectedDay).length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: ()async{
                              if(_constantController.donorId!=null){
                                await showAlertDialog(context, eventList[index]);
                                setState(() {

                                });
                                //Get.snackbar('ALERT', response.body);
                              }else{
                                Get.snackbar('ALERT', 'يجب تسجبل الدخول لحجز موعد');
                              }
                              setState(() {

                              });


                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Container(
                                height: 34,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(Radius.circular(6))),
                                child: Center(
                                    child: Text(
                                      eventList[index].time,
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          );

                        }),
                  ),
                  // ..._getEventsfromDay(selectedDay).map(
                  //       (Event event) => Flexible(
                  //     child: ListTile(
                  //       title: Text(
                  //         event.time,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon:Icon(Icons.person),title:'ملف شخصي'),
          TabItem(icon:Icon(Icons.house),title:'الرئيسية'),
        ],
        height: 55,
        initialActiveIndex: selectedPage,
        onTap: (int index){
          print(index);
          setState(() {
            selectedPage = index;
            _pageOption[selectedPage];
            _pn(selectedPage);
          });
        },
        backgroundColor: const Color(0xffD6DACA),

      ),
    );
  }
  _pn(int selectedPage){
    if(selectedPage == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
      // } else if(selectedPage == 1){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Book_appointment()),
      //   );
    } else if(selectedPage == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );

    }else if (selectedPage == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

    }
  }
  // when notification icon button clicked
  void onNotification() {
    print('notification clicked');
  }
  Future<bool?> showAlertDialog(BuildContext context,Event event)async {

    // set up the AlertDialog


    // show the dialog
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return   AlertDialog(
          title: Text("هل انت متأكد؟"),
          content: Text("هل تريد حجز موعد في ${event.time}"),
          actions: [
            TextButton(
              child: Text("نعم"),
              onPressed:  ()async {
                print(_constantController.donorId);
                final response=await http.post(Uri.parse(constant.bookAppointmentUrl),body: {
                  'appointmentId':event.appointmentId,
                  'donorId':_constantController.donorId,
                });
                Navigator.pop(context,true);
                //Get.snackbar('ALERT', response.body);
                Get.to(()=>LocationScreen());

              },
            ),
            TextButton(
              child: Text("لا"),
              onPressed:  () {
                Navigator.pop(context,false);
              },
            ),
          ],
        );
      },
    );
  }
}


class Event {
  final String time;
  final String reserved;
  final String appointmentId;
  Event({required this.appointmentId, required this.reserved, required this.time});
  String toString() => this.time;
}