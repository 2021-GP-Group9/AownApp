import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../login/login_screen.dart';
import 'signup_conn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  bool email_err = false;
  bool phone_err = false;
  String? phone_err_msg;
  String? email_err_msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'تسجيل جديد',
          style: TextStyle(color: Colors.black87),
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
      body:
      Container(
        child: Stack(
            children:[
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
                  'تسجيل جديد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
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
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
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
                    if (value.length < 10) {

                      validateMobile(value);
                      phone_err_msg="يجب أن يكون رقم الجوال يحتوي على ١٠ أرقام";
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
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'كلمة السر',
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: MaterialButton(
                    onPressed: () {
                      print(nameController.text);
                      print(emailController.text);
                      print(phoneController.text);
                      print(passwordController.text);
                      Conn(nameController.text, phoneController.text,
                              emailController.text, passwordController.text)
                          .save_it_to_db()
                          .then((value) {
                        print("result $value");
                        if (value.toString() ==
                            'This email is already exists in our Application') {
                          showerror(true);
                        } else if (value.toString() ==
                            'This phone number is already exists in our Application') {
                          showerror(false);
                        }else{
                          _accountCreated();
                        }
                      });
                    },
                    child: Text(
                      'تسجيل',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'سجل دخولك',
                      ),
                    ),
                    Text(
                      'لديك حساب؟',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
            ], ),
      ),
    );
  }

  void showerror(bool bool) {
    setState(() {
      if (bool) {
        email_err_msg = "الايميل مستخدم بالفعل";
        email_err = true;
      } else {
        phone_err_msg = "رقم الجوال مستخدم بالفعل";
        phone_err = true;
      }
    });
  }

  String? validateMobile(String value) {
    String pattern = r"^\+?0[0-9]{10}$";
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      phone_err_msg = "ادخل رقم جوال";
      return phone_err_msg;
    } else if (!regExp.hasMatch(value)) {
      phone_err_msg = 'أدخل رقم جوال يحتوي على ١٠ أرقام';
      return phone_err_msg;
    }
    return "null";
  }
  Future<void> _accountCreated() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تم التسجيل بنجاح'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
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
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()),
                );

              },
            ),
          ],
        );
      },
    );
  }
}

// class Signup extends StatelessWidget {
//   var nameController = TextEditingController();
//   var emailController = TextEditingController();
//   var phoneController = TextEditingController();
//   var passwordController = TextEditingController();
//   bool email_err=false;
//   bool pass_err=false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         backgroundColor: Color(0xffD6DACB),
//         title: Text(
//           'تسجيل جديد',
//             style: TextStyle(color: Colors.black87),),
//         actions: [
//           Align(
//             alignment: Alignment.center,
//             child: Image.asset(
//               'assets/finalLogo.jpeg',
//               fit: BoxFit.contain,
//               width: 45,
//               height: 45,
//             ),
//           ),
//         ],
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'تسجيل جديد',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 40.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                    ),
//
//             SizedBox(
//               height: 40.0,
//             ),
//             TextFormField(
//               controller: nameController,
//               keyboardType: TextInputType.name,
//               onFieldSubmitted: (String value) {
//                 print(value);
//               },
//               onChanged: (String value) {
//                 print(value);
//               },
//               decoration: InputDecoration(
//                 labelText: 'الإسم',
//                 prefixIcon: Icon(
//                   Icons.person,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//             ),SizedBox(
//             height: 10.0,
//           ),
//             TextFormField(
//
//               controller: emailController,
//               keyboardType: TextInputType.emailAddress,
//               onFieldSubmitted: (String value) {
//                 print(value);
//               },
//               onChanged: (String value) {
//                 print(value);
//               },
//               decoration: InputDecoration(
//                 errorText: email_err ? 'Email Alerady exsisted':null,
//                 labelText: 'البريد الإلكتروني',
//                 prefixIcon: Icon(
//                   Icons.email,
//                 ),
//                 border: OutlineInputBorder( borderRadius: BorderRadius.circular(30),),
//               ),
//             ), SizedBox(
//                   height: 10.0,
//                 ),
//                 TextFormField(
//                   controller: phoneController,
//                   keyboardType: TextInputType.phone,
//                   onFieldSubmitted: (String value) {
//                     print(value);
//                   },
//                   onChanged: (String value) {
//                     print(value);
//                   },
//                   decoration: InputDecoration(
//                     errorText: email_err ? 'Email Alerady exsisted':null,
//                     labelText: 'رقم الجوال',
//                     prefixIcon: Icon(
//                       Icons.phone,
//                     ),
//                     border: OutlineInputBorder( borderRadius: BorderRadius.circular(30),),
//                   ),
//                 ),
//
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 TextFormField(
//
//                   controller: passwordController,
//                   keyboardType: TextInputType.visiblePassword,
//                   obscureText: true,
//                   onFieldSubmitted: (String value) {
//                     print(value);
//                   },
//                   onChanged: (String value) {
//                     print(value);
//                   },
//                   decoration: InputDecoration(
//                     labelText: 'كلمة السر',
//                     prefixIcon: Icon(
//                       Icons.lock,
//                     ),
//                     suffixIcon: Icon(
//                       Icons.remove_red_eye,
//                     ),
//                     border: OutlineInputBorder( borderRadius: BorderRadius.circular(30)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration( color: Colors.black87,borderRadius: BorderRadius.circular(30),  boxShadow:[
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.7),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ] ),
//
//                   child: MaterialButton(
//                     onPressed: () {
//                       print(nameController.text);
//                       print(emailController.text);
//                       print(phoneController.text);
//                       print(passwordController.text);
//                       Conn(nameController.text,phoneController.text,emailController.text,passwordController.text).save_it_to_db().then((value){
//                         print("result $value");
//                         if(value.toString()=='This email is already exists in our Application'){
//                           showerror(true);
//                           }
//                         else{
//                           showerror(false);
//                         }
//                       });
//                     },
//                     child: Text(
//                       'تسجيل',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                           MaterialPageRoute(builder: (context) =>LoginScreen()),);
//                       },
//                       child: Text(
//                         'سجل دخولك',
//                       ),
//                     ), Text(
//                       'لديك حساب؟',
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
