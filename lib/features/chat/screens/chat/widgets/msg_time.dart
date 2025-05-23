import 'package:flutter/material.dart';
import 'package:bookstore.tm/features/chat/models/message.dart';

class MessageTime extends StatelessWidget {
  const MessageTime({
    Key? key,
    required this.msg,
  }) : super(key: key);

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Text(
      msg.hour,
      style: TextStyle(
        fontSize: 12,
        color: Color.fromARGB(255, 95, 136, 87),
      ),
    );
  }
}
