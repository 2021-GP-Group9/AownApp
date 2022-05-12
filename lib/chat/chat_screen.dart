
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../cases/cases_page.dart';
import '../connection/charity_model.dart';
import '../connection/get_charaty_data.dart';
import '../constant.dart';
import '../favoriteList/favoirte_screen.dart';
import '../home_screen/home_screen.dart';
import '../profile/profile_screen.dart';

import 'components/chart_card.dart';

import 'message_screen.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int selectedPage = 4;
  final _pageOption = [Profile(), HomeScreen(), CasesPage(), Favorite_screen(),ChatsScreen(),];
  TextEditingController passwordController = TextEditingController();
  final CharityDataConnection _charityDataConnection = CharityDataConnection();

  int _selectedIndex = 1;
  bool _isLoadingData = false;
  void requestData() {
    _charityDataConnection.requestCharityData().then((value) {
      setState(() {
        _isLoadingData = true;
        print(_charityDataConnection.allCharityList.length);
        int length = _charityDataConnection.allCharityList.length;

      });
    });
  }
  CharityModel admin=new CharityModel(phone: 'a', city: 'a', email: 'a', charityId: '1111', name: 'Admin',
      description: 'a', service: 'a', licenseNumber: 'a', status: 'a', location: 'a', donationType: 'a');

  @override
  void initState() {
    requestData();

    super.initState();
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
        actions: [

        ],
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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _charityDataConnection.allCharityList.length,
              itemBuilder: (context, index) => ChatCard(
                chat: _charityDataConnection.allCharityList[index],
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagesScreen(_charityDataConnection.allCharityList[index]),
                  ),
                ),
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
          TabItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              title: 'المفضلة '),
          TabItem(icon: Icon(Icons.assignment_rounded), title: 'الحالات‎'),
          TabItem(icon: Icon(Icons.house), title: 'الرئيسية'),
          TabItem(icon: Icon(Icons.chat ), title: 'Chat'),
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
    } else if (selectedPage == 0) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    } else if (selectedPage == 3) {
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
    } else if (selectedPage == 1) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Favorite_screen()),
      );
    }
    else if (selectedPage == 4) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatsScreen()),
      );
    }
  }
  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          label: "Profile",
        ),
      ],
    );
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
}