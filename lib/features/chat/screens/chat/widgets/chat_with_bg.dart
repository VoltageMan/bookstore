import 'package:flutter/material.dart';
import 'package:bookstore.tm/features/chat/models/message.dart';
import 'package:bookstore.tm/features/chat/screens/chat/widgets/msgs_list.dart';

class ChatWithBackground extends StatelessWidget {
  const ChatWithBackground({
    Key? key,
    required this.msgs,
  }) : super(key: key);

  final Set<Message> msgs;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: MsgsList(
        msgs: msgs,
      ),
    );
  }
}
