import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/categories/view/body.dart';
import 'package:bookstore.tm/features/favors/components/favors_widget.dart';
import 'package:bookstore.tm/features/favors/bloc/favors_bloc.dart';
import 'package:bookstore.tm/features/product_details/view/product_details_body.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/settings/enums.dart';

class FavrosBuilder extends StatefulWidget {
  const FavrosBuilder({super.key});

  @override
  State<FavrosBuilder> createState() => _FavrosBuilderState();
}

class _FavrosBuilderState extends State<FavrosBuilder> {
  late final cubit = context.read<FavorsCubit>()..getFavors();

  final scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          (scrollController.position.maxScrollExtent - 15.h)) {
        final state = cubit.state;
        if (state.apiState != FavorsAPIState.success) {
          return;
        }
        cubit.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      child: BlocBuilder<FavorsCubit, FavorsState>(
        bloc: cubit,
        builder: (context, state) {
          final apiState = state.apiState;
          if (apiState == FavorsAPIState.unauthorized)
            return Center(
              child: Text(context.l10n.unauthorized),
            );
          if (apiState == FavorsAPIState.init) return SizedBox();
          if (apiState == FavorsAPIState.error) return CategoryErrorBody();
          final isLoading = apiState == FavorsAPIState.loading;
          if (state.models.isEmpty && !isLoading) {
            return Center(
              child: Text(
                context.l10n.empty,
              ),
            );
          }
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              AppSpacing.vertical_10.toSliverBox,
              SliverList.builder(
                itemCount: isLoading ? 10 : state.models.length,
                itemBuilder: (context, index) {
                  return FavorsWidget(
                    /// condition to show loading
                    model: isLoading ? null : state.models[index],
                  );
                },
              ),
              if (apiState == FavorsAPIState.errorMore)
                CategoryErrorBody(
                  onTap: () {
                    cubit.getFavors();
                  },
                ).toSliverBox,
              if (apiState == FavorsAPIState.loadingMore)
                CenterLoading().toSliverBox
            ],
          );
        },
      ),
    );
  }
}
