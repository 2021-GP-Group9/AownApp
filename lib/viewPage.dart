
import 'package:flutter/material.dart';
import 'bookAppointment/book_appointment_screen.dart';
import 'connection/charity_model.dart';
import 'home_screen/home_screen.dart';
import 'package:aownapp/profile/profile_screen.dart';

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
      body:Container(
        child:Column (
          children:[
            Container(
              child: Text(
              charityModel.name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),

            ),
            ),
            Container(
                height: 100,
                width: 100,
              child: (charityModel.imageString=="")?Icon(Icons.image, size:100)
                  :charityModel.image,
            ),
            Container(
              child:Text(charityModel.description,
                style: TextStyle(fontSize: 20,)
              )),
               Container(
                 child:
                 Text(
                     charityModel.city)
               ),
            Container(
              child: Text(charityModel.location),
            ),

           Container(
            child: Text (charityModel.phone),

           ),
        Container(
          child: Row(
            children: [
              Text('احجز موعد '),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Book_appointment()),
                    );
                  },
                  child: Icon(
                    Icons.add_circle ,
                    size: 35,
                  )),
            ],
          ),
        ),

        ],
        )


      )

    );
  }
}
