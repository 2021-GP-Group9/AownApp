import 'package:aownapp/profile/profile_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'bookAppointment/book_appointment_screen.dart';
import 'connection/charity_model.dart';
import 'home_screen/home_screen.dart';

class ViewPage extends StatefulWidget {
  final CharityModel charityModel;

  const ViewPage({Key? key, required this.charityModel}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  int selectedPage = 0;
  final _pageOption=[Profile(),HomeScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'تفاصيل الجمعية الخيرية',
          style: TextStyle(color: Colors.black87),),leading:
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          child:Icon(Icons.arrow_back, color: Colors.black54,)
      ),


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
      body:SingleChildScrollView(
        child: Container(
          // container 1 that contain every thing
          padding: const EdgeInsets.all(50),
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 20,
                  offset: Offset(-10.0, 10.0), // changes position of shadow
                ),
              ]
          ),
          child: Column(
            children:[
          Container(
          child: Text(
          widget.charityModel.name,
            style: TextStyle(
              fontFamily: 'Almarai Bold',
              fontSize: 20,fontWeight: FontWeight.bold,
              // fontWeight: FontWeight.bold
            ),
          ),
        ),
        Divider(color: Colors.grey,),
        Container(
          height: 100,
          width: 100,
          child: (widget.charityModel.imageString == "") ? Icon(Icons.image, size: 100)
              : widget.charityModel.image,
        ),
        Container(

            child: Text(widget.charityModel.description, textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: 'Almarai Light',
                  fontSize: 14,)
            )),
        Divider(color: Colors.grey,),
        Row(
            children: <Widget>[
              Expanded(child: Text(
                  widget.charityModel.city, textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,color: Colors.blueGrey,)),
              ),
              Expanded(child: Text("المدينة:", textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,))
              )

            ]
        ),
        Row(
            children: <Widget>[
              Expanded(child: Text(
                  widget.charityModel.location, textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,color: Colors.blueGrey,)),
              ),
              Expanded(child: Text("الموقع:", textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,))
              )
            ]
        ),
        Row(
            children: <Widget>[
              Expanded(child: Text(
                  widget.charityModel.phone, textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,color: Colors.blueGrey,)),
              ),
              Expanded(child: Text("رقم الهاتف:", textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,))
              )
            ]
        ), Row(
                  children: <Widget>[
                    Expanded(child: Text(
                        widget.charityModel.licenseNumber,textAlign:
                    TextAlign.right,textDirection:TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light' ,
                          fontSize: 14,color: Colors.blueGrey,)),
                    ),
                    Expanded(child: Text("رقم الترخيص:", textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light' ,
                          fontSize: 14,))
                    )
                  ]
              ),
        Row(
            children: <Widget>[
              Expanded(child: Text(
                  widget.charityModel.email, textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,color: Colors.blueGrey,)),
              ),
              Expanded(child: Text(
                  "البريد الإلكتروني:", textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,))
              )

            ]
        ),
        Row(
            children: <Widget>[

              Expanded(child: Text(
                  widget.charityModel.donationType, textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,color: Colors.blueGrey,)),
              ),
              Expanded(child: Text("نوع التبرعات:", textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,))
              )

            ]
        ),
        Row(

            children: <Widget>[
              Expanded(child: Text(
                  widget.charityModel.service, textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,color: Colors.blueGrey,)),
              ),
              Expanded(child: Text(
                  "استلام التبرعات من المنزل:", textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Almarai Light',
                    fontSize: 14,))
              )

            ]
        ),
        Divider(color: Colors.grey,),
              Row(
                  children: <Widget>[
                    Expanded(child: Text(
                        "", textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Almarai Light',
                          fontSize: 14,))
                    )
                  ]
              ),
    Container(
    child: GestureDetector(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Book_appointment()),
    );
    },
    child: Icon(
    Icons.add_circle,
    size: 50,
    )),
    ),
    ],
    )

    ),
      )
       ,
      bottomNavigationBar: ConvexAppBar(
    items: [
    TabItem(icon:Icon(Icons.person),title:'ملف شخصي'),
    // TabItem(icon:Icon(Icons.add_circle),title:'موعد '),
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
  _pn(int selectedPage) {
    if (selectedPage == 0) {
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
}