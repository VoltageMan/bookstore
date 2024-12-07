import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/settings/consts.dart';

class MyProfileTile extends StatelessWidget {
  const MyProfileTile({
    super.key,
    required this.contents,
    required this.titles,
    required this.onTaps,
    required this.icons,
  });
  final List<IconData>? icons;
  final List<String> titles;
  final List<String> contents;
  final List<VoidCallback> onTaps;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightGrey,
      borderRadius: AppBorderRadiuses.border_6,
      child: Column(
        children: [
          _MyTile(
            icon: icons?.first,
            content: contents.first,
            title: titles.first,
            onTap: onTaps.first,
          ),
          Container(
            width: double.infinity,
            height: 1.2.h,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: AppBorderRadiuses.border_6,
            ),
            margin: AppPaddings.horiz_16,
          ),
          _MyTile(
            icon: icons?.last,
            content: contents.last,
            title: titles.last,
            onTap: onTaps.last,
          )
        ],
      ),
    );
  }
}

class _MyTile extends StatelessWidget {
  const _MyTile({
    required this.content,
    required this.title,
    required this.onTap,
    required this.icon,
  });
  final IconData? icon;
  final String title;
  final String content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;
    return InkWell(
      borderRadius: AppBorderRadiuses.border_6,
      onTap: onTap,
      child: Padding(
        padding: AppPaddings.all_16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: textTheme.titleLarge, maxLines: 1),
            icon != null
                ? Icon(
                    icon,
                    color: Colors.black,
                    size: 20.sp,
                  )
                : Expanded(
                    child: Text(
                      content,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      style: textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
