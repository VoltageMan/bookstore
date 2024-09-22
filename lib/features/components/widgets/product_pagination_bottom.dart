import 'package:flutter/material.dart';
import 'package:bookstore/features/categories/view/body.dart';
import 'package:bookstore/settings/consts.dart';
import 'package:bookstore/settings/enums.dart';

final class ProductPaginationBottom extends StatelessWidget {
  const ProductPaginationBottom({
    super.key,
    required this.isLastPage,
    required this.state,
    required this.onErrorTap,
  });
  final bool isLastPage;
  final ProductAPIState state;
  final VoidCallback onErrorTap;
  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        if (state == ProductAPIState.loadingMoreError)
          CategoryErrorBody(
            onTap: () => onErrorTap(),
          ), // below widgets puts loadingIndicator if it needs
        if (!isLastPage && state != ProductAPIState.loadingMoreError)
          Container(
            padding: AppPaddings.vertic_12,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: AppColors.appOrange,
            ),
          )
      ],
    );
  }
}
