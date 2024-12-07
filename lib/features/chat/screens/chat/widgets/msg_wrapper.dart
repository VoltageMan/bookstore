import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/chat/models/message.dart';
import 'package:bookstore.tm/features/chat/screens/chat/widgets/msg_text.dart';
import 'package:bookstore.tm/features/chat/screens/chat/widgets/msg_time.dart';
import 'package:bookstore.tm/features/chat/screens/chat/widgets/ticks.dart';

class MessageWrapper extends StatelessWidget {
  const MessageWrapper({
    Key? key,
    required this.msg,
  }) : super(key: key);

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: msg.is_owner ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.all(4.sp),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 2.sp, color: Colors.black.withOpacity(0.2)),
          ],
          color: msg.is_owner
              ? Color.fromARGB(255, 220, 255, 187)
              : Color.fromARGB(255, 134, 180, 196),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MessageText(msg: msg),
            10.horizontalSpace,
            MessageTime(msg: msg),
            if (msg.is_owner) ...[
              5.horizontalSpace,
              Ticks(msg: msg),
            ]
          ],
        ),
      ),
    );
  }
}
