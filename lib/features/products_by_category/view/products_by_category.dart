import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/categories/view/body.dart';
import 'package:bookstore.tm/features/components/widgets/product_pagination_bottom.dart';
import 'package:bookstore.tm/features/filter/bloc/filter_bloc.dart';
import 'package:bookstore.tm/features/home/view/components/product_builder.dart';
import 'package:bookstore.tm/features/products_by_category/bloc/products_by_category_bloc.dart';
import 'package:bookstore.tm/features/products_by_category/view/app_bar_prods_by_cat.dart';
import 'package:bookstore.tm/features/products_by_category/view/products_by_category_info.dart';
import 'package:bookstore.tm/helpers/modal_sheets.dart';
import 'package:bookstore.tm/models/categories/category_model.dart';
import 'package:bookstore.tm/settings/enums.dart';

class ProductsByCategory extends StatefulWidget {
  const ProductsByCategory({super.key, required this.category});
  final CategoryModel category;
  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  @override
  void initState() {
    bloc = context.read<ProductsByCategoryBloc>()..init(widget.category);
    filterBloc = context.read<FilterBloc>();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (scrollController.position.maxScrollExtent - 15.h) &&
          scrollController.position.isScrollingNotifier.value) {
        final state = bloc.state;
        if (state.state != ProductAPIState.success ||
            state.pagination!.currentPage == state.pagination!.lastPage) {
          return;
        }
        bloc.loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    bloc.dispose();
    filterBloc.add(ClearFilter());
    super.dispose();
  }

  late final ProductsByCategoryBloc bloc;
  late final FilterBloc filterBloc;
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return ModelBottomSheetHelper.doPop();
      },
      child: Scaffold(
        appBar: ProductsByCategoryAppBar(),
        body: BlocBuilder<ProductsByCategoryBloc, ProductsByCategoryState>(
          builder: (context, state) {
            if (state.state == ProductAPIState.init) {
              return SizedBox();
            }
            if (state.state == ProductAPIState.error) {
              return CategoryErrorBody(
                onTap: () {
                  bloc.init(state.category!);
                },
              );
            }
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                ProductsByCategoryInfo(
                  title: state.category?.name,
                  subTitle: state.category?.name,
                  total: state.pagination?.total,
                ),
                HomeProdBuilder(
                  prods: state.products,
                ),
                ProductPaginationBottom(
                  isLastPage: state.pagination?.currentPage ==
                      state.pagination?.lastPage,
                  state: state.state,
                  onErrorTap: () => bloc.loadMore(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
