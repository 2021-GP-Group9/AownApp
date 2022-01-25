// import 'dart:convert';
// import 'dart:ui';
// import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
// import 'package:aownapp/connection/charity_model.dart';
// import 'package:aownapp/connection/get_charaty_data.dart';
// import 'package:aownapp/profile/profile_screen.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import '../viewPage.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController passwordController = TextEditingController();
// //method to show the download icone befor get data
//   bool _isLoadingData = true;
//   final CharityDataConnection _charityDataConnection = CharityDataConnection();
//   int selectedPage = 0;
//   final _pageOption=[Profile(),HomeScreen()];
//   void requestData() {
//     _charityDataConnection.requestCharityData().then((value) {
//       setState(() {
//         _isLoadingData = false;
//       });
//     });
//   }
//
//   @override
//   void initState() {
//     requestData(); // method load befor load the page to get information of charities
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // main axis alignment : start
//     // cross axis alignment : center
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xffD6DACA),
//         // leading: Icon(Icons.search),
//         title: TextFormField(
//           controller: passwordController,
//           keyboardType: TextInputType.visiblePassword,
//           obscureText: false,
//           onFieldSubmitted: (String value) {
//             print(value);
//           },
//           onChanged: (String value) {
//             setState(() {
//               _charityDataConnection.searchingTheCharityList(value);
//             });
//             print(value);
//           },
//           decoration: InputDecoration(
//             labelText: 'بحث',
//             prefixIcon: Icon(
//               Icons.search,
//             ),
//
//           ),
//         ),
//         actions: [Image.asset("assets/finalLogo.jpeg")],
//       ),
//       body:(_isLoadingData)
//           ? Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         color: Colors.white,
//         child: Center(
//           child:
//           CircularProgressIndicator(color: const Color(0xffD6DACA)),
//         ),
//       )
//           : ListView.builder(
//           padding: const EdgeInsets.all(8),
//           scrollDirection: Axis.vertical,
//           itemCount: _charityDataConnection.allCharityList.length,
//           // #of charities
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: const EdgeInsets.only(
//                 top: 50,
//               ),
//               child: GestureDetector(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewPage(charityModel:_charityDataConnection.allCharityList[index],)));
//                 },
//                 child: Container(
//                   // height: 100,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       // border: Border.all(color: Colors.white70) ,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(50)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 4,
//                           blurRadius: 20,
//                           offset: Offset(-10.0, 10.0), // changes position of shadow
//                         ),
//                       ]
//                   ),
//
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       SizedBox(
//                         width: 40,
//                       ),
//                       Container(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               constraints: BoxConstraints(
//                                 maxWidth:
//                                 MediaQuery.of(context).size.width - 145,
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   _charityDataConnection
//                                       .allCharityList[index].name,
//                                   style: TextStyle(
//                                       fontFamily: 'almarai Bold',
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//
//                               ),
//                             ),
//                             Container(
//                               constraints: BoxConstraints(
//                                 maxWidth:
//                                 MediaQuery.of(context).size.width - 145,
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child:
//                                 Text(_charityDataConnection
//                                     .allCharityList[index].description, textAlign: TextAlign.right,textDirection:TextDirection.rtl ,
//                                   style: TextStyle(
//                                     fontFamily: 'almarai Regular',
//                                     fontSize: 13,
//                                     color: Colors.blueGrey,
//                                   ),),
//                               ),
//                             )
//                             ,
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 40),
//                         child: Container(
//                           height: 49,
//                           width: 49,
//                           child: (_charityDataConnection
//                               .allCharityList[index].imageString ==
//                               "")
//                               ? Icon(
//                               Icons.image,
//                               size:49
//                           )
//                               : _charityDataConnection
//                               .allCharityList[index].image,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//       bottomNavigationBar: ConvexAppBar(
//         items: [
//           TabItem(icon:Icon(Icons.person),title:'ملف شخصي'),
//           // TabItem(icon:Icon(Icons.add_circle),title:'موعد '),
//           TabItem(icon:Icon(Icons.house),title:'الرئيسية'),
//         ],
//         height: 55,
//         initialActiveIndex: selectedPage,
//         onTap: (int index){
//           print(index);
//           setState(() {
//             selectedPage = index;
//             _pageOption[selectedPage];
//             _pn(selectedPage);
//           });
//         },
//         backgroundColor: const Color(0xffD6DACA),
//       ),
//
//     );
//
//   }
//   _pn(int selectedPage){
//     if(selectedPage == 0){
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Profile()),
//       );
//       // } else if(selectedPage == 1){
//       //   Navigator.push(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => Book_appointment()),
//       //   );
//     } else if(selectedPage == 0){
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Profile()),
//       );
//
//     }else if (selectedPage == 1) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//
//     }
//   }
//   // when notification icon button clicked
//   void onNotification() {
//     print('notification clicked');
//   }
// }