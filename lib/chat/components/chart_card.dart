import 'package:flutter/material.dart';
import '../../connection/charity_model.dart';
import '../../connection/get_charaty_data.dart';
import '../../constant.dart';


class ChatCard extends StatelessWidget {
   ChatCard({
    Key? key,
    required this.chat,
    required this.press,
    required this.unread_mssage,
  }) : super(key: key);

  final  CharityModel chat;
  final VoidCallback press;
   int unread_mssage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.name,
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              unread_mssage!=0?Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unread_mssage.toString(),
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        // SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ):Text(""),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Container(
                  height: 69,
                  width: 69,
                  child: (chat.imageString==""
                      ? Icon(Icons.image, size: 49)
                      : chat.image
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
