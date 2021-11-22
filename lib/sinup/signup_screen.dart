import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import 'signup_conn.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xffD6DACB),
        title: Text(
          'تسجيل جديد',
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
            ),SizedBox(
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
              },
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                prefixIcon: Icon(
                  Icons.email,
                ),
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(30),),
              ),
            ), SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'رقم الجوال',
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    border: OutlineInputBorder( borderRadius: BorderRadius.circular(30),),
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
                    border: OutlineInputBorder( borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration( color: Colors.black87,borderRadius: BorderRadius.circular(30),  boxShadow:[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ] ),

                  child: MaterialButton(
                    onPressed: () {
                      print(nameController.text);
                      print(emailController.text);
                      print(phoneController.text);
                      print(passwordController.text);
                      Conn(nameController.text,phoneController.text,emailController.text,passwordController.text).save_it_to_db().then((value){
                        print("result $value");
                        Fluttertoast.showToast(
                            msg: value ,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
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
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>LoginScreen()),);
                      },
                      child: Text(
                        'سجل دخولك',
                      ),
                    ), Text(
                      'لديك حساب؟',
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
}