import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/categories/view/body.dart';
import 'package:bookstore.tm/features/components/custom_button.dart';
import 'package:bookstore.tm/features/components/widgets/nav_bar_body.dart';
import 'package:bookstore.tm/features/components/widgets/sheet_titles.dart';
import 'package:bookstore.tm/features/filter/bloc/filter_bloc.dart';
import 'package:bookstore.tm/features/filter/components/builders/props_builder.dart';
import 'package:bookstore.tm/features/filter/components/builders/selected_props_builder.dart';
import 'package:bookstore.tm/features/home/bloc/home_bloc.dart';
import 'package:bookstore.tm/features/product_details/view/product_details_body.dart';
import 'package:bookstore.tm/features/products_by_category/bloc/products_by_category_bloc.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/routes.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/enums.dart';

class FilterSheetBody extends StatefulWidget {
  const FilterSheetBody({super.key});

  @override
  State<FilterSheetBody> createState() => _FilterSheetBodyState();
}

class _FilterSheetBodyState extends State<FilterSheetBody> {
  @override
  void initState() {
    bloc = context.read<FilterBloc>()..add(FilterInit());
    bloc.forHome = appRouter.location == AppRoutes.mainScreen;
    super.initState();
  }

  late FilterBloc bloc;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      height: 735.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: AppBorderRadiuses.border_10,
      ),
      child: BlocBuilder<FilterBloc, FilterState>(
        buildWhen: (previous, current) {
          return previous.state != current.state;
        },
        bloc: bloc,
        builder: (context, state) {
          if (state.state == FilterAPIState.init) return SizedBox();
          if (state.state == FilterAPIState.loading) return CenterLoading();
          if (state.state == FilterAPIState.error)
            return CategoryErrorBody(
              onTap: () {
                bloc.add(FilterInit());
              },
            );
          return Column(
            children: [
              BottomSheetTitle(
                isPadded: true,
                title: context.l10n.filter,
              ),
              AppSpacing.vertical_15,
              Padding(
                padding: AppPaddings.horiz16_vertic12.copyWith(bottom: 0),
                child: SelectedPropsBuilder(),
              ),
              Expanded(
                child: Padding(
                  padding: AppPaddings.horiz16_vertic12.copyWith(top: 0),
                  child: CustomScrollView(
                    slivers: [
                      SliverList.builder(
                        itemCount: state.properties!.length,
                        itemBuilder: (context, index) {
                          return FilterPropertyBuilder(
                            prop: state.properties![index],
                          )..log();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              NavBarBody(
                child: CustomButton(
                  title: l10n.products,
                  child: ValueListenableBuilder(
                    valueListenable: bloc.productCountNotifier,
                    builder: (context, val, _) {
                      return Text(
                        '${l10n.products} (${bloc.getProdCount})',
                        style: context.theme.textTheme.labelMedium,
                      );
                    },
                  ),
                  onTap: () {
                    if (bloc.forHome) {
                      context.read<HomeBloc>().filter(bloc.state.homeSelecteds);
                    } else {
                      context
                          .read<ProductsByCategoryBloc>()
                          .filter(bloc.state.prodByCatselecteds);
                    }
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
