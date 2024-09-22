import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/settings/consts.dart';
import 'package:bookstore/settings/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedBackTile extends StatelessWidget {
  const FeedBackTile(this.content, {super.key});
  final String content;
  void onTap() {
    launchUrl(Uri.parse('tel://$content'));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPaddings.horiz_16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: AppBorderRadiuses.border_50,
              child: InkWell(
                borderRadius: AppBorderRadiuses.border_50,
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  height: 20.sp,
                  width: 20.sp,
                  alignment: Alignment.center,
                  margin: AppPaddings.all_12,
                  child: FittedBox(
                    child: Icon(
                      Icons.phone,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                content,
                style: AppTheme.bodyMedium14(context),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
