import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    super.key,
    required this.title,
    this.onTap,
    this.width,
    this.padding,
    this.textStyle,
  });

  final String title;
  final double? width;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? AppPaddings.vertic_15,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(
            color: AppColors.darkBlue,
            width: 1.w,
          ),
        ),
        width: width,
        child: FittedBox(
          child: Text(
            title,
            style: textStyle ?? context.theme.textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
