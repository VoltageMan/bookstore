import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/filter/bloc/filter_bloc.dart';
import 'package:bookstore.tm/features/filter/components/line.dart';
import 'package:bookstore.tm/features/filter/components/prop_widegets/filter_color.dart';
import 'package:bookstore.tm/features/filter/components/prop_widegets/filter_prop_widget.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/modal_sheets.dart';
import 'package:bookstore.tm/helpers/routes.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/models/property/property_model.dart';
import 'package:bookstore.tm/settings/theme.dart';

class FilterPropertyBuilder extends StatelessWidget {
  const FilterPropertyBuilder({
    super.key,
    required this.prop,
  });
  final PropertyModel prop;
  @override
  Widget build(BuildContext context) {
    final buttonTheme = context.theme.textButtonTheme.style as MyButtonStyle;
    final bloc = context.read<FilterBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                prop.name,
                style: AppTheme.titleMedium16(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: () {
                ModelBottomSheetHelper.doPop();
                appRouter
                    .push(AppRoutes.filterDetails, extra: prop)
                    .then((value) {
                  ModelBottomSheetHelper.showFilterSheet();
                });
              },
              style: buttonTheme,
              child: Text(
                context.l10n.all,
                style: buttonTheme.myTextStyle,
              ),
            )
          ],
        ),
        AppSpacing.vertical_18,
        BlocBuilder<FilterBloc, FilterState>(
          bloc: bloc,
          builder: (context, state) {
            return ExtendedWrap(
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 10.w,
              maxLines: prop.isColor ?? false ? 1 : 2,
              children: prop.values
                  .map(
                    (e) => prop.isColor ?? false
                        ? FilterColorWidget(
                            color: e,
                            isSelected: bloc.isSelected(e.id),
                            onTap: () => bloc.switchProp(e),
                          )
                        : FilterPropWidget(
                            model: e,
                            onTap: () => bloc.switchProp(e),
                          ),
                  )
                  .toList(),
            );
          },
        ),
        FilterLine()
      ],
    );
  }
}
