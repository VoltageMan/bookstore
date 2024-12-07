import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/address/cubit/address_cubit.dart';
import 'package:bookstore.tm/features/components/widgets/svg_icons.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/modal_sheets.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/enums.dart';
import 'package:bookstore.tm/settings/theme.dart';

class AddressSheetTitle extends StatelessWidget {
  const AddressSheetTitle({super.key, required this.forComplete});
  final bool forComplete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horiz_16.copyWith(top: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final state = context.read<AddressCubit>().state;
              if (state.state != AddressApiState.succses) {
                return;
              }
              ModelBottomSheetHelper.doPop();
              await ModelBottomSheetHelper.showAddressUpdateSheet(null);
              if (forComplete) {
                ModelBottomSheetHelper.showAddressSelecSheet();

                return;
              }

              /// 1 index of it self to return addres sheet back
              ModelBottomSheetHelper.showProfileSheets(1);
            },
            child: SizedBox.square(
              dimension: 22.sp,
              child: FittedBox(
                child: Icon(
                  Icons.add_rounded,
                  color: AppColors.darkBlue,
                ),
              ),
            ),
          ),
          Text(
            context.l10n.delivery,
            style: AppTheme.titleMedium16(context),
          ),
          MyImageIcon(
            path: AssetsPath.crossIcon,
            contSize: 20.sp,
            iconSize: 20.sp,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
