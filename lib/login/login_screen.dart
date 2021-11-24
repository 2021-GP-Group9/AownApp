import 'package:aownapp/signup/signup_screen.dart';
import '../home_screen.dart';
import 'login_conn.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool email_err = false;
  bool password_err = false;
  String? email_err_msg;
  String? password_err_msg;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'تسجيل دخول',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (String value) {
                    print(value);
                    if (value.toString() ==
                        'fail mail') {

                      email_err_msg ="خطا";
                      setState(() {
                        email_err = true;
                      });
                    } else {
                      email_err_msg = "الايميل غير موجود";
                      setState(() {
                        email_err = false;
                      });
                    }
                  },
                  onChanged: (String value) {
                    print(value);
                    if (!value.contains("@")) {
                      email_err_msg = "يجب أن يكون ايميل حقيقي";
                      setState(() {
                        email_err = true;
                      });
                    } else {
                      email_err_msg = "الايميل مستخدم بالفعل";
                      setState(() {
                        email_err = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    errorText: email_err ? email_err_msg : null,
                    labelText: 'البريد الالكتروني',
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),),
                  ),
                ),
                SizedBox(
                  height: 15.0,
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
                    if (value.isEmpty) {
                      password_err_msg = "يجب تعبئة الحقل";
                      setState(() {
                        password_err = true;
                      });
                    } else {
                      password_err_msg = "كلمة السر خاطئة";
                      setState(() {
                        password_err = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    errorText: password_err ? password_err_msg : null,
                    labelText: 'كلمة المرور',
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.black87,
                      borderRadius: BorderRadius.circular(30)),

                  child: MaterialButton(

                    onPressed: () {
                      print(emailController.text);
                      print(passwordController.text);
                      Conn_login(emailController.text, passwordController.text)
                          .login_function()
                          .then((value) {
                            print("login $value");
                        if (value.toString() ==
                            'fail mail') {
                          showerror(true);

                        } else if (value.toString() ==
                            'fail pass') {
                          showerror(false);
                        }
                            // Navigator.push(context,
                            //   MaterialPageRoute(
                            //       builder: (context) => HomeScreen()),);

                      });
                    },
                    child: Text(
                      'تسجيل الدخول',
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
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()),);
                      },
                      child: Text(
                        'تسجيل جديد',
                      ),
                    ), Text(
                      'ليس لديك حساب؟',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  void showerror(bool bool) {
    setState(() {
      if (bool) {
        email_err_msg = "الايميل غير صحيح";
        email_err = true;
      } else {
        password_err_msg = "كلمة السر غير صحيحة";
        password_err = true;
      }
    });
  }
  }






//
// class LoginScreen extends StatelessWidget {
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffD6DACB),
//         title: Text(
//           'تسجيل دخول',
//           style: TextStyle(color: Colors.black87),),
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
//                   'تسجيل الدخول',
//                   style: TextStyle(
//                     fontSize: 40.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40.0,
//                 ),
//                 TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   onFieldSubmitted: (String value) {
//                     print(value);
//                   },
//                   onChanged: (String value) {
//                     print(value);
//                   },
//                   decoration: InputDecoration(
//
//                     labelText: 'البريد الالكتروني',
//                     prefixIcon: Icon(
//                       Icons.email,
//                     ),
//                     border: OutlineInputBorder( borderRadius: BorderRadius.circular(30),),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 TextFormField(
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
//                     labelText: 'كلمة المرور',
//                     prefixIcon: Icon(
//                       Icons.lock,
//                     ),
//                     suffixIcon: Icon(
//                       Icons.remove_red_eye,
//                     ),
//                     border: OutlineInputBorder( borderRadius: BorderRadius.circular(30),),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration( color: Colors.black87,borderRadius: BorderRadius.circular(30)),
//
//                   child: MaterialButton(
//
//                     onPressed: () {
//                       print(emailController.text);
//                       print(passwordController.text);
//                       Conn_login(emailController.text,passwordController.text).login_function().then((value){
//                         print("login $value");
//                         Navigator.push(context,
//                           MaterialPageRoute(builder: (context) =>HomeScreen()),);
//                       });
//
//                      },
//                     child: Text(
//                       'تسجيل الدخول',
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
//                           MaterialPageRoute(builder: (context) =>Signup()),);
//                       },
//                       child: Text(
//                         'تسجيل جديد',
//                       ),
//                     ), Text(
//                       'ليس لديك حساب؟',
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