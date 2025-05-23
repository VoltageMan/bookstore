import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/chat/models/message.dart';

class MessageText extends StatelessWidget {
  const MessageText({
    Key? key,
    required this.msg,
  }) : super(key: key);

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.65,
      ),
      child: msg.image != null
          ? Image.file(
              File(
                msg.image!.path,
              ),
            )
          : msg.type == 'file'
              ? Image.network(
                  msg.body,
                  scale: 10,
                )
              : Text(
                  msg.body,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ),
    );
  }
}
