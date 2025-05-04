import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductCommentWidget extends StatelessWidget {
  const ProductCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328.w,
      margin: EdgeInsets.only(top: 12.h),
      padding: AppPaddings.all_16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.darkGray.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: SvgPicture.asset(
                  AssetsPath.commentStar,
                  colorFilter: index < 3
                      ? null
                      : ColorFilter.mode(
                          AppColors.darkGray.withOpacity(0.5),
                          BlendMode.srcIn,
                        ),
                ),
              ),
            ),
          ),

          // Spacer
          AppSpacing.vertical_12,

          // Comment user name
          Row(
            children: [
              Text(
                'Dowran',
                style: AppTheme.bodyMedium14(context),
              ),

              //
              AppSpacing.horizontal_5,

              Icon(
                Icons.check_circle,
                size: 14.sp,
                color: AppColors.green,
              )
            ],
          ),

          // Spacer
          AppSpacing.vertical_12,

          // Comment description
          Text(
            'Haryt gaty gowy eken. Zakaz etdim 20 min içinde gapyma özleri getirip berdiler. Hyzmatlaryny haladym diňe shu ýerden söwda edip durarn.',
            style: AppTheme.bodyMedium12(context)
                .copyWith(color: AppColors.darkGray),
          ),

          // Spacer
          AppSpacing.vertical_12,

          // Comment description
          Text(
            'Ýazylan senesi: 15/04/2025',
            style: AppTheme.bodyMedium12(context),
          ),
        ],
      ),
    );
  }
}
