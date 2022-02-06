import 'package:aownapp/cases/cases_model.dart';
import 'package:aownapp/donation/donation_conn.dart';
import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  final String id;
  final CasesDisplayModel thisCase;

  const DonationPage(this.id, this.thisCase, {Key? key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  List<bool> chooseBoolean = [true, true, true, true];
  final _primaryColor = const Color(0xffD6DACB);
  final DonationConnection _donationConnection = DonationConnection();
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD6DACB),
        title: const Text(
          "تفاصيل الحالة‎",
          style:
              TextStyle(color: Colors.black87, fontFamily: 'Almarai Regular'),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
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
      body: (isUploading)
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xffD6DACA)),
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  const Text("هل أنت متأكد ؟ ‎",style: TextStyle(
                    fontFamily: 'Almarai bold',
                    fontSize: 16,
                    color: Colors.black,
                  )),
                  _getYesNoOption("نوع المنتج : " + widget.thisCase.itemType, 0),
                  _getYesNoOption("عدد القطع : " + widget.thisCase.itemCount, 1),
                  _getYesNoOption("لون المنتج : " + widget.thisCase.itemColor, 2),
                  _getYesNoOption("حجم المنتج : " + widget.thisCase.itemSize, 3),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isUploading = true;
                      });
                      _donationConnection
                          .uploadDonation(widget.id, chooseBoolean)
                          .then((value) {
                        setState(() {
                          if(value == "1"){
                            _donationSent().then((value) {
                              print("Uploaded successfully");
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          }
                          else{
                            print("Error in uploading donor try again");
                          }
                        });
                      });
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: _primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text("إرسال ", style: TextStyle(
                          fontFamily: 'Almarai Regular',
                          fontSize: 14,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
  Future<void> _donationSent() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تم ارسال المعلومات بنجاح سيتم التواصل عن طريق الايميل',style:TextStyle(
            fontFamily: 'Almarai Light',
            fontSize: 14,
          )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Positioned(
                    top: -60,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffD6DACB),
                      radius: 30,
                      child: Icon(
                        Icons.check_circle_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
                //Center(child: Text('Account created ')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('تم'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomeScreen()),
                // );
              },
            ),
          ],
        );
      },
    );
  }
  Widget _getYesNoOption(String title, int option) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                chooseBoolean[option] = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: (chooseBoolean[option]) ? Colors.white : _primaryColor,
              child: const Text("نعم",style: TextStyle(
                fontFamily: 'Almarai Regular',
                fontSize: 12,
              ),),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                chooseBoolean[option] = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: (!chooseBoolean[option]) ? Colors.white : _primaryColor,
              child: const Text("لا",style: TextStyle(
                fontFamily: 'Almarai Regular',
                fontSize: 12,
              ),),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .5,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(title,style: TextStyle(
              fontFamily: 'Almarai bold',
              fontSize: 14,
            ),),
          ),
        ],
      ),
    );
  }
}
