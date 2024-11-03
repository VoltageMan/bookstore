import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/features/components/widgets/place_holder.dart';
import 'package:bookstore/helpers/spacers.dart';
import 'package:bookstore/models/cart/cart_model/cart_model.dart';
import 'package:bookstore/settings/consts.dart';

class OrderStateCheck extends StatelessWidget {
  const OrderStateCheck(
      {super.key,
      required this.isLoading,
      this.maxHeight,
      required this.models});
  final List<OrderStateModel> models;
  final bool isLoading;
  final double? maxHeight;
  @override
  Widget build(BuildContext context) {
    final height = AppSpacing.getTextHeight(12) * 1.6;
    final checkCount = models.length;
    final tickedsCount = getTicks(models);
    return Padding(
      padding: AppPaddings.right_6,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.sp),
            height: ((maxHeight ?? 0) / 2.5) *
                ((tickedsCount == 0 ? 1 : tickedsCount) - 1),
            width: 2.sp,
            color: AppColors.mainBrown,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              3,
              (index) {
                final isNotChecked = checkCount < (index + 1);
                return isNotChecked
                    ? SizedBox(
                        height: height,
                      )
                    : isLoading
                        ? MyShimerPlaceHolder(
                            height: height,
                            child: Container(
                              margin: index == 1
                                  ? AppPaddings.vertic_24.add(
                                      EdgeInsets.symmetric(
                                        vertical: AppSpacing.getTextHeight(12),
                                      ),
                                    )
                                  : EdgeInsets.zero,
                              height: 24.sp,
                              width: 24.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.shimmerBodyColor,
                              ),
                            ),
                          )
                        : Container(
                            margin: index == 1
                                ? AppPaddings.vertic_24
                                : EdgeInsets.zero,
                            height: height,
                            alignment: Alignment.center,
                            padding: AppPaddings.all_4,
                            decoration: BoxDecoration(
                              color: tickedsCount > index
                                  ? AppColors.mainBrown
                                  : AppColors.lightGrey,
                              shape: BoxShape.circle,
                            ),
                            child: FittedBox(
                              child: Icon(
                                tickedsCount > index
                                    ? Icons.check_rounded
                                    : null,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}

int getTicks(List<OrderStateModel> models) {
  int length = 0;
  for (final i in models) {
    if (i.completed_at == null) {
      return length;
    }
    length++;
  }
  return length;
}
