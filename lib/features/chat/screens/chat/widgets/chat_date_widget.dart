import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/settings/consts.dart';

class ChatDateWidget extends StatelessWidget {
  const ChatDateWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: AppBorderRadiuses.border_12,
        ),
        margin: AppPaddings.vertic_10,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
