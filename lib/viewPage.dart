import 'package:aownapp/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'bookAppointment/book_appointment_screen.dart';
import 'connection/charity_model.dart';
import 'home_screen/home_screen.dart';

class ViewPage extends StatelessWidget {
final CharityModel charityModel;
  const ViewPage({Key? key,required this.charityModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color(0xffD6DACA),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
                child: Icon(
                  Icons.person,
                  size: 35,
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Book_appointment()),
                  );
                },
                child: Icon(
                  Icons.add_circle,
                  size: 49,
                )),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },

                child: Icon(
                  Icons.house,
                  size: 35,)
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'تفاصيل الجمعية الخيرية',
          style: TextStyle(color: Colors.black87),),
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
      body:Container(// container 1 that contain every thing
        padding: const EdgeInsets.all(50),
        height: MediaQuery.of(context).size.height,
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
        child:Column (
          children:[
           Container(
              child: Text(
              charityModel.name,
              style: TextStyle(
                fontFamily: 'Almarai Bold',
                  fontSize: 20,
                 // fontWeight: FontWeight.bold
                ),

            ),
            ),
            Divider(color: Colors.grey,),
            Container(
                height: 100,
                width: 100,
              child: (charityModel.imageString=="")?Icon(Icons.image, size:100)
                  :charityModel.image,
            ),
            Container(
              child:Text(charityModel.description, textAlign: TextAlign.end,
                style: TextStyle(
                 fontFamily: 'Almarai Light' ,
                fontSize: 20,)
              )),
            Divider(color: Colors.grey,),
            Row(
               children: <Widget>[
                Expanded(child: Text(
                    charityModel.city,textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                    style: TextStyle(
                      fontFamily: 'Almarai Light' ,
                      fontSize: 20,)),
                ),
                 Expanded(child: Text("المدينة:", textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                     style: TextStyle(
                       fontFamily: 'Almarai Light' ,
                       fontSize: 20,))
                 )

               ]
                ),
            Row(
                children: <Widget>[
                  Expanded(child: Text(
                      charityModel.city,textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Light' ,
                        fontSize: 20,)),
                  ),
                  Expanded(child: Text("الموقع:", textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Light' ,
                        fontSize: 20,))
                  )

                ]
            ),
            Row(
                children: <Widget>[
                  Expanded(child: Text(
                      charityModel.city,textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Light' ,
                        fontSize: 20,)),
                  ),
                  Expanded(child: Text("رقم الهاتف:", textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Light' ,
                        fontSize: 20,))
                  )

                ]
            ),
            Row(
                children: <Widget>[
                  Expanded(child: Text(
                      charityModel.city,textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Light' ,
                        fontSize: 20,)),
                  ),
                  Expanded(child: Text("البريد الإلكتروني:", textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Light' ,
                        fontSize: 20,))
                  )

                ]
            ),
            Row(
                children: <Widget>[
                  Expanded(child: Text(
                      charityModel.city,textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Light' ,
                        fontSize: 20,)),
                  ),
                  Expanded(child: Text("نوع التبرعات:", textAlign: TextAlign.right,textDirection:TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Almarai Light' ,
                        fontSize: 20,))
                  )

                ]
            )
          ],
        )

      )

    );
  }
}
