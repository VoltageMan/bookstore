import 'package:flutter/material.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.width,
    this.padding,
    this.child,
    this.textStyle,
    this.color = AppColors.black,
  });

  CustomButton.orange({
    super.key,
    required this.title,
    this.onTap,
    this.width,
    this.padding,
    this.child,
    this.textStyle,
  }) : color = AppColors.appOrange;

  final String title;
  final double? width;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Widget? child;
  final Color color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.r),
      child: Material(
        color: color,
        textStyle: AppTheme.displayLarge14(context),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: padding ?? AppPaddings.vertic_15,
            alignment: Alignment.center,
            width: width,
            child: child ??
                FittedBox(
                  child: Text(
                    title,
                    style: textStyle ?? context.theme.textTheme.labelMedium,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
