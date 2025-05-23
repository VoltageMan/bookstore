import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/filter/bloc/filter_bloc.dart';
import 'package:bookstore.tm/features/filter/components/line.dart';
import 'package:bookstore.tm/features/filter/components/prop_widegets/remove_all_selecteds.dart';
import 'package:bookstore.tm/features/filter/components/prop_widegets/selected_prop_widget.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/modal_sheets.dart';
import 'package:bookstore.tm/helpers/routes.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/theme.dart';

class SelectedPropsBuilder extends StatelessWidget {
  const SelectedPropsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FilterBloc>();
    final buttonTheme = context.theme.textButtonTheme.style as MyButtonStyle;

    return BlocBuilder<FilterBloc, FilterState>(
      bloc: bloc,
      builder: (context, state) {
        final selecteds =
            bloc.forHome ? state.homeSelecteds : state.prodByCatselecteds;
        if (selecteds.isEmpty) return SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExtendedWrap(
              alignment: WrapAlignment.start,
              spacing: 10.w,
              maxLines: 2,
              children: selecteds
                  .map(
                    (e) => SelectedFilterPropWidget(
                      value: e,
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: AppPaddings.bottom_10,
              child: Row(
                children: [
                  RemoveAllSeleteds(),
                  AppSpacing.horizontal_12,
                  TextButton(
                    onPressed: () {
                      ModelBottomSheetHelper.doPop();
                      appRouter.push(AppRoutes.filterSelecteds).then((value) {
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
            ),
            FilterLine()
          ],
        );
      },
    );
  }
}
