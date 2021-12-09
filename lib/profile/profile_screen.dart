import 'dart:math';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:aownapp/bookAppointment/book_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:aownapp/login/login_screen.dart';
import 'package:aownapp/home_screen/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../welcome_screen.dart';
import 'profile_data.dart';
import 'profile_conn.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  var mydata;
 

  bool _isLoadingData = true;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  int donar_id = 0;
  bool name_err = false;
  bool email_err = false;
  bool phone_err = false;


  String? phone_err_msg;
  String? email_err_msg;
  String? name_err_msg;
  int selectedPage = 0;
  final _pageOption=[Profile(),HomeScreen()];
  @override
  void initState() {
    super.initState();
    var mydata = get_id();

    setState(() {
      mydata.then((value) => nameController.text = value.name);
      mydata.then((value) => emailController.text = value.email);
      mydata.then((value) => phoneController.text = value.phone_number);
    });
    var mydata11 = get_donarId().then((value) => donar_id = value);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              remove_id();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomeScrean()),
                      (Route<dynamic> route) => false);
            },
            child: Icon(Icons.logout_rounded)),
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'الملف الشخصي',
          style: TextStyle(color: Colors.black87,fontFamily: 'Almarai Light'),
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
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(
                  child: Transform.rotate(
                    angle: -pi / 3.5,
                    child: ClipPath(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.lightGreen.shade50,
                              Colors.lightGreen.shade50,
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'الملف الشخصي',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai Bold'
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (String value) {
                          print(value);
                          if (value.isEmpty) {
                            name_err_msg = "يجب تعبئة الحقل";
                            setState(() {
                              name_err = true;
                            });
                          } else {
                            name_err = false;
                          }
                        },
                        onChanged: (String value) {
                          print(value);
                          if (value.isEmpty) {
                            name_err_msg = "يجب تعبئة الحقل";
                            setState(() {
                              name_err = true;
                            });
                          } else {
                            name_err = false;
                          }
                        },
                        decoration: InputDecoration(
                          errorText: name_err ? name_err_msg : null,
                          labelText: 'الإسم',
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        onChanged: (String value) {
                          print(value);
                          if (!value.contains("@")) {
                            email_err_msg = "يجب أن يكون ايميل حقيقي";
                            setState(() {
                              email_err = true;
                            });
                          } else {
                            phone_err_msg = "الايميل مستخدم بالفعل";
                            setState(() {
                              email_err = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          errorText: email_err ? email_err_msg : null,
                          labelText: 'البريد الإلكتروني',
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: phoneController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (String value) {
                          print(value);
                          if (value.length < 10 ||
                              int.tryParse(value) == null) {
                            validateMobile(value);
                            phone_err_msg =
                            "يجب أن يكون رقم الجوال يحتوي على ١٠ أرقام";
                            setState(() {
                              phone_err = true;
                            });
                          } else {
                            phone_err_msg = "رقم الجوال المدخل مستخدم بالفعل";
                            setState(() {
                              phone_err = false;
                            });
                          }
                        },
                        onChanged: (String value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          errorText: phone_err ? phone_err_msg : null,
                          labelText: 'رقم الجوال',
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(30)),
                        child: MaterialButton(
                          onPressed: () {
                            print(nameController.text);
                            print(emailController.text);
                            print(phoneController.text);
                            Conn(
                              donar_id,
                              nameController.text,
                              phoneController.text,
                              emailController.text,
                            ).update_it_to_db().then((value) {
                              print("result $value");
                              if (value.toString() ==
                                  'This Phone Number is already exists in our Application') {
                                showerror(true);
                              } else if (value.toString() ==
                                  "This email is already exists in our Application") {
                                showerror(true);
                              } else if (value.toString() ==
                                  "Account Updated") {
                                _accountupdated();
                              }
                            });
                          },
                          child: Text(
                            'حفظ',
                            style: TextStyle(
                              color: Colors.white,fontFamily: 'Almarai Light'
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
    ;
  }
  _pn(int selectedPage){
    if(selectedPage == 0){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
      
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
  Future<void> _accountupdated() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تم تحديث البيانات بنجاح'),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showerror(bool bool) {
    setState(() {
      email_err_msg = "الايميل مستخدم بالفعل";
      email_err = true;

      phone_err_msg = "رقم الجوال مستخدم بالفعل";
      phone_err = true;
    });
  }

  String? validateMobile(String value) {
    String pattern = r"^\+?0[0-9]{10}$";
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty || int.tryParse(value) == null) {
      phone_err_msg = "ادخل رقم جوال";
      return phone_err_msg;
    } else if (!regExp.hasMatch(value)) {
      phone_err_msg = 'أدخل رقم جوال يحتوي على ١٠ أرقام';
      return phone_err_msg;
    }
    return "null";
  }
}
//get the user id to get his profile
Future<profile_data> get_id() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("idKey")) {
    print("Helo");
    print(prefs.getInt("idKey"));
    profile_data mydata =
    await Conn(prefs.getInt("idKey"), " ", " ", " ").save_it_to_db();
    print(mydata.name.toString());

    return mydata;
  } else {
    print(prefs.getInt("idKey"));
    print("key error");
    return new profile_data("error", "error", "000");
  }
}
//get the user id to update his profile
Future<int> get_donarId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("idKey")) {
    return prefs.getInt("idKey") as int;
    //return id;
  } else {
    return 0;
  }
}

//log out
void remove_id() async {
  print('Removed the id from pref');
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  if (prefs.containsKey("idKey")) {
    prefs.remove("idKey");
  }
}
