import 'dart:async';
import 'dart:convert';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../cases/cases_page.dart';
import '../connection/charity_model.dart';
import '../connection/get_charaty_data.dart';
import '../constant.dart';
import '../favoriteList/favoirte_screen.dart';
import '../global.dart';
import '../home_screen/home_screen.dart';
import '../profile/profile_screen.dart';
import 'components/chart_card.dart';
import 'message_screen.dart';
import 'package:http/http.dart' as http;


class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int selectedPage = 1;
  final _pageOption = [Profile(), HomeScreen(), CasesPage(), Favorite_screen(),ChatsScreen(),];
  TextEditingController passwordController = TextEditingController();
  final CharityDataConnection _charityDataConnection = CharityDataConnection();

  int _selectedIndex = 1;
  bool _isLoadingData = false;

  List<bool> Un_read=[];
  int no_of_unread_msg=0;
  String user_id=AppColors.user;
  List<int>_unread_messages=[];
  int admin_unread=0;
  CharityModel admin=new CharityModel(phone: 'a', city: 'a', email: 'a', charityId: '1111', name: 'مُشرف المنصة',
      description: 'a', service: 'a', licenseNumber: 'a', status: 'a', location: 'a', donationType: 'a');
  void requestData() {
    _charityDataConnection.requestCharityData().then((value) {
      get_unread_messages(_charityDataConnection.finalCharityList).then((value) {
        setState(() {
          _isLoadingData = true;
        });
      });
      get_no_of_unread_msg(admin.charityId,user_id).then((value) {
        admin_unread =  int.parse(value[0]['no_of_unread_mesg']);
        setState(() {
        });
        print("admin unread_message $admin_unread");
      });
      setState(() {
        print(_charityDataConnection.allCharityList.length);
        int length = _charityDataConnection.allCharityList.length;
      });
    });
  }

  Future<dynamic> get_no_of_unread_msg(String charityId,String donorId) async {
    print(charityId);
    dynamic json;
    // var request = http.Request('GET', Uri.parse('${constant.comment}?charity_id=$charity_id'));
    var request = http.Request('GET', Uri.parse('${constant.get_unread_messages}?'
        'from_user=${charityId}&userId=${donorId}'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      //print();
      json=jsonDecode(await response.stream.bytesToString());
      return json;
    }
    else {
      print(response.reasonPhrase);
    }
    return json;
  }

  final StreamController<List<dynamic>> readingStreamController = StreamController<List<dynamic>>();
  @override
  void initState() {
    requestData();
    //startStreamReadingList();
    super.initState();
  }
//for less respones time
  void startStreamReadingList() async {
    Timer.periodic(
      Duration(seconds: 10),
          (timer) async {

      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffD6DACA),
        // leading: Icon(Icons.search),
        title: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: false,
          onFieldSubmitted: (String value) {
            print(value);
          },
          onChanged: (String value) {
            setState(() {
              _charityDataConnection.searchingTheCharityList(value);
            });
            print(value);
          },
          decoration: InputDecoration(
            labelText: 'بحث',
            prefixIcon: Icon(
              Icons.search,
            ),
          ),
        ),
        actions: [],
      ),
      body: _isLoadingData?Column(
        children: [
          ChatCard(
            chat: admin,
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagesScreen(admin),
              ),
            ),
            unread_mssage:admin_unread,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _charityDataConnection.allCharityList.length,
              itemBuilder: (context, index) => ChatCard(
                chat: _charityDataConnection.allCharityList[index],
                press: () {
                  setState(() {
                    Un_read[index]=false;
                    print(" hello");
                  });

                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagesScreen(_charityDataConnection.allCharityList[index]),
                  ),
                );
                },
                unread_mssage:Un_read[index]?_unread_messages[index]:0,
              ),
            ),
          ),
        ],
      ):
      Center(
        child:
        CircularProgressIndicator(color: const Color(0xffD6DACA)),
      ),

      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icon(Icons.person), title: 'ملف شخصي'),
          TabItem(icon: Icon(Icons.chat), title: 'المحادثات'),
          TabItem(icon: Icon(Icons.assignment_rounded), title: 'الحالات‎'),
          TabItem(icon: Icon(Icons.favorite,color: Colors.black,),title: 'المفضلة '),
          TabItem(icon: Icon(Icons.house), title: 'الرئيسية'),
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

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

  Future<void> get_unread_messages(List<CharityModel> allCharityList) async {

    allCharityList.forEach((element) {

      Un_read.add(false);
    });
    int i=0;
    allCharityList.forEach((element) {
      get_no_of_unread_msg(element.charityId,user_id).then((value) {
        _unread_messages.add(int.parse(value[0]['no_of_unread_mesg']));
        Un_read[i]=true;
        i++;
        print("${element.charityId} ,${value[0]['no_of_unread_mesg']}");
      });
    });
    setState(() {
    });
  }
}