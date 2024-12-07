import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/chat/models/message.dart';
import 'package:bookstore.tm/settings/consts.dart';

class Ticks extends StatelessWidget {
  const Ticks({
    Key? key,
    required this.msg,
  }) : super(key: key);

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return msg.is_seen
        ? const Icon(
            Icons.done_all,
            color: Color.fromARGB(255, 95, 136, 87),
            size: 18,
          )
        : const Icon(
            Icons.done,
            color: Color.fromARGB(255, 95, 136, 87),
            size: 18,
          );
  }
}
