import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/data/remote/dio_client.dart';
import 'package:bookstore.tm/features/cart/cubit/cart_cubit.dart';
import 'package:bookstore.tm/features/cart/view/cart_info_widget.dart';
import 'package:bookstore.tm/features/cart/view/cart_widget.dart';
import 'package:bookstore.tm/features/categories/view/body.dart';
import 'package:bookstore.tm/features/components/my_text_button.dart';
import 'package:bookstore.tm/features/product_details/view/product_details_body.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/modal_sheets.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/enums.dart';

class CartScreen extends StatelessWidget with DioClientMixin {
  CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        'cartREBuild'.log();
        if (state.apiState == CartAPIState.init) return SizedBox();
        if (state.apiState == CartAPIState.loading) return CenterLoading();
        if (state.apiState == CartAPIState.error)
          return CategoryErrorBody(
            onTap: () {
              context.read<CartCubit>().getCurrentCart();
            },
          );
        if (state.apiState == CartAPIState.unAuthorized) {
          return Center(
            child: Text(
              l10n.unauthorized,
            ),
          );
        }
        if (state.cart!.orders.isEmpty) {
          return Center(
            child: Text(l10n.empty),
          );
        }
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.custom(
              childrenDelegate: SliverChildListDelegate(
                [
                  ...state.cart!.orders
                      .map((e) => CartWidget(
                            model: e,
                          ))
                      .toList(),
                  CartInfoWidget(
                    model: state.cart,
                  ),
                  AppSpacing.vertical_60,
                  AppSpacing.vertical_30,
                ],
              ),
            ),
            Container(
              height: 48.h,
              margin: AppPaddings.all_16,
              child: MyDarkTextButton(
                title: context.l10n.next,
                width: double.infinity,
                onTap: () {
                  ModelBottomSheetHelper.showAddressSelecSheet();
                },
              ),
            )
          ],
        );
      },
    );
  }
}
