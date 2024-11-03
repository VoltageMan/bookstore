import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/features/filter/bloc/filter_bloc.dart';
import 'package:bookstore/features/filter/components/prop_widegets/selected_color_widget.dart';
import 'package:bookstore/features/filter/components/remove_selected_cross.dart';
import 'package:bookstore/helpers/spacers.dart';
import 'package:bookstore/models/property/values/property_value_model.dart';
import 'package:bookstore/settings/consts.dart';
import 'package:bookstore/settings/theme.dart';

class SelectedFilterPropWidget extends StatelessWidget {
  SelectedFilterPropWidget({
    super.key,
    required this.value,
  });
  //change it to PropValue Model
  final PropertyValue value;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FilterBloc>();
    return GestureDetector(
      onTap: () {
        bloc.add(RemoveFilterProperty(model: value));
      },
      child: Container(
        height: 30.sp,
        margin: AppPaddings.bottom_10,
        padding: AppPaddings.horiz10_vertic5,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadiuses.border_6,
          color: AppColors.mainBrown,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            value.isColor
                ? SelectedFilterColorWidget(
                    color: value,
                  )
                : FittedBox(
                    child: Text(
                      '${value.value}',
                      style: AppTheme.displayMedium12(context),
                    ),
                  ),
            AppSpacing.horizontal_5,
            RemoveSelectedWidget(forAll: false),
          ],
        ),
      ),
    );
  }
}
