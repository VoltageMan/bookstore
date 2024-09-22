import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/features/home/view/components/photo_sender_widget.dart';
import 'package:bookstore/features/home/view/components/search_field.dart';
import 'package:bookstore/helpers/spacers.dart';
import 'package:bookstore/settings/consts.dart';

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppbar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(52.h);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppColors.appBarShadow,
      ),
      margin: EdgeInsets.only(top: AppSpacing.topPad),
      height: 52.h,
      width: double.infinity,
      padding: AppPaddings.horiz_16.copyWith(right: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeSearchField(),
          AppSpacing.horizontal_4,
          PhotoSenderWidget(),
        ],
      ),
    );
  }
}
