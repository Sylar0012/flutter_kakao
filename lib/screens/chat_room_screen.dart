import 'package:flutter/material.dart';
import 'package:flutter_kakao/components/chat_icon_button.dart';
import 'package:flutter_kakao/components/my_chat.dart';
import 'package:flutter_kakao/components/other_chat.dart';
import 'package:flutter_kakao/components/time_line.dart';
import 'package:flutter_kakao/models/chat.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final List<MyChat> chats = [];
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffb2c7da),
      child: Scaffold(
        body: Container(
          color: Color(0xffb2c7da),
          child: Scaffold(
            backgroundColor: Colors.transparent, // Scaffold가 배경을 가리지 않도록 투명화
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                "홍길동",
                style: Theme.of(context).textTheme.headline6,
              ),
              actions: [
                Icon(
                  FontAwesomeIcons.search,
                  size: 20,
                  color: Colors.black54,
                ),
                SizedBox(width: 25),
                Icon(
                  FontAwesomeIcons.bars,
                  size: 20,
                  color: Colors.black54,
                ),
                SizedBox(width: 25),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TimeLine(time: "2021년 1월 1일 금요일"),
                        OtherChat(
                          name: "홍길동",
                          text: "오늘 저녁에 시간 되시나요?",
                          time: "오후 11:00",
                        ),
                        MyChat(
                          text: "이미 11시 인데요?",
                          time: "오후 11:05",
                        ),
                        ...List.generate(
                          chats.length,
                          (index) => chats[index],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    children: [
                      ChatIconButton(icon: Icon(FontAwesomeIcons.plusSquare)),
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: _textController,
                            maxLines: 1,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            onSubmitted: _handleSubmitted,
                          ),
                        ),
                      ),
                      ChatIconButton(icon: Icon(FontAwesomeIcons.smile)),
                      ChatIconButton(icon: Icon(FontAwesomeIcons.cog)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmitted(text) {
    _textController.clear();
    setState(() {
      chats.add(
        MyChat(
          text: text,
          time: DateFormat("a K:m")
              .format(new DateTime.now())
              .replaceAll("AM", "오전")
              .replaceAll("PM", "오후"),
        ),
      );
    });
  }
}
