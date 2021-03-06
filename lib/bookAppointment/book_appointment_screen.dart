import 'dart:convert';
import 'package:aownapp/appointment/appointment_model.dart';
import 'package:aownapp/bookAppointment/book_appointment_controller.dart';
import 'package:aownapp/cases/cases_page.dart';
import 'package:aownapp/chat/chat_screen.dart';
import 'package:aownapp/controller/constant_controller.dart';
import 'package:aownapp/favoriteList/favoirte_screen.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:aownapp/location/location_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
//import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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

  Book_appointment({Key? key, required this.charityId, this.donorLocation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Calendar(
      charityId: charityId,
      donorLocation: donorLocation ?? '',
    );
  }
}

class Calendar extends StatefulWidget {
  final String charityId;
  String? donorLocation;

  Calendar({Key? key, required this.charityId, this.donorLocation})
      : super(key: key);
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int selectedPage = 4;
  final _pageOption = [
    Profile(),
    HomeScreen(),
    CasesPage(),
    Favorite_screen(),
    ChatsScreen(),
  ];

  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  // to do backend tasks
  BookAppointmentController _bookAppointmentController =
  Get.put(BookAppointmentController());
  //to store donor id
  ConstantController _constantController = Get.find<ConstantController>();

  // store events of the selected date
  List<Event> eventList = [];

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    // takes the selected date and return all  available appointment
    eventList = _bookAppointmentController
        .selectedEvents[DateFormat('yyyy-MM-dd').format(date)] ??
        [];
    return _bookAppointmentController
        .selectedEvents[DateFormat('yyyy-MM-dd').format(date)] ??
        [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          '???????? ????????????????',
          style:
          TextStyle(color: Colors.black87, fontFamily: 'Almarai Regular'),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
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
//  used to call APIs,to deals with future values
      body: FutureBuilder<AppointementModel?>(
          future: _bookAppointmentController.getAppointmentApi(
              widget.charityId, _constantController.donorId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
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
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },
                    // To style the Calendar
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Colors.green,
                        //can be change to rectangle as:
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        //shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      todayDecoration: BoxDecoration(
                        color: Color(0xffD6DACB),
                        //can be change to rectangle as:
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        //shape: BoxShape.circle,
                      ),
                      defaultDecoration: BoxDecoration(
                        // color: Colors.pink,
                        //can be change to rectangle as:
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        //shape: BoxShape.circle,
                      ),
                      weekendDecoration: BoxDecoration(
                        //can be change to rectangle as:
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.0),
                        // shape: BoxShape.circle,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        '?????????????? ??????????????',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Almarai Light'),

                      ),
                    ],
                  ),
                  //available times here
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 50,
                        ),

                        shrinkWrap: true,
                        itemCount: _getEventsfromDay(selectedDay).length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              if (_constantController.donorId != null) {
                                await appointmentConfirmation(
                                    context, eventList[index]);
                                setState(() {});
                              } else {
                                Get.snackbar(
                                    '??????????', '?????? ?????????? ???????????? ???????? ????????');
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Container(
                                height: 34,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
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
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icon(Icons.person), title: '?????? ????????'),
          TabItem(icon: Icon(Icons.chat), title: '??????????????????'),
          TabItem(icon: Icon(Icons.assignment_rounded), title: '?????????????????'),
          TabItem(icon: Icon(Icons.favorite,color: Colors.black,),title: '?????????????? '),
          TabItem(icon: Icon(Icons.house), title: '????????????????'),
        ],
        color: Colors.black,
        height: 60,
        initialActiveIndex: selectedPage,
        onTap: (int index) {
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
  _pn(int selectedPage) {
    if (selectedPage == 0) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
      // } else if(selectedPage == 1){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Book_appointment()),
      //   );

    } else if (selectedPage == 4) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (selectedPage == 2) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CasesPage()),
      );
    } else if (selectedPage == 3) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Favorite_screen()),
      );
    } else if (selectedPage == 1) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatsScreen()),
      );
    }
  }
  Future<void> appointmentConfirmation(
      BuildContext context, Event event) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("???? ?????? ???????????? ???? ???????? ?????? ???????? ???? ${event.time} "),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                CircleAvatar(
                  backgroundColor: Color(0xffD6DACB),
                  radius: 30,
                  child: Icon(
                    Icons.check_circle_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('????'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('??????'),
              onPressed: () async {
                Navigator.pop(context, true);
                await Get.to(() => LocationScreen(
                  appointmentId: event.appointmentId,
                  donorId: _constantController.donorId!,
                ));
                setState(() {});
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
  Event(
      {required this.appointmentId,
        required this.reserved,
        required this.time});
  String toString() => this.time;
}