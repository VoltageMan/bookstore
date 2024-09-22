import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:bookstore/app/setup.dart';
import 'package:bookstore/data/local/secured_storage.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/helpers/overlay_helper.dart';
import 'package:bookstore/helpers/routes.dart';
import 'package:bookstore/models/cart/cart_update/cart_update_model.dart';
import 'package:bookstore/models/product_details/product_details_model.dart';
import 'package:bookstore/repositories/products/product_repo.dart';
import 'package:bookstore/settings/enums.dart';

part 'product_details_state.dart';

class ProductDetailsBloc extends Cubit<ProductDetailsState> {
  ProductDetailsBloc()
      : super(
          ProductDetailsState(
            state: ProdDetailsAPIState.init,
            product: null,
          ),
        );
  int? currentProdId;
  final repo = getIt<ProductRepo>();
  Future<void> init(int id) async {
    currentProdId = id;
    final cancleToken = CancelToken();
    emit(
      ProductDetailsState(
        state: ProdDetailsAPIState.loading,
        product: null,
        cancelToken: cancleToken,
      ),
    );
    final product = await repo.getDetails(id, cancleToken);
    if (product != null) {
      return emit(
        ProductDetailsState(
          state: ProdDetailsAPIState.success,
          product: product,
          selectedProps: getDefaultProps(product),
        ),
      );
    }
    if (cancleToken.isCancelled) return;
    return emit(
      ProductDetailsState(
        state: ProdDetailsAPIState.error,
        product: null,
      )..log(message: 'Getting Error'),
    );
  }

  // void screenDispose() {
  //   state.cancelToken?.cancel();
  //   final List<ProductDetailsModel> newProd = List.from(state.products);
  //   if (state.state == ProdDetailsAPIState.success) {
  //     sesectedProps.removeLast();
  //     newProd.removeLast();
  //   }
  //   currentProdId = newProd.isNotEmpty ? newProd.last.id : null;
  //   emit(
  //     ProductDetailsState(
  //       products: newProd,
  //       state: ProdDetailsAPIState.success,
  //     )..log(message: 'disposing success State'),
  //   );
  // }

  // int fingProdIndex(int id) {
  //   return state.products.map((e) => e.id).toList().indexOf(id);
  // }

  void selecProp(String propName, int id) {
    state.selectedProps[propName] = id;
  }

  int? getSelectedPropid(String propName) {
    return state.selectedProps[propName];
  }

  bool isNotAllPropsSelected() {
    final val =
        state.product!.properties.map((e) => e.name).toList().any((element) {
      return state.selectedProps[element] == null;
    });
    if (val) {
      SnackBarHelper.showTopSnack('not all props are selected', APIState.error);
    }
    return val;
  }

  bool isUnauthorized() {
    final val = LocalStorage.getToken == null;
    if (val) {
      SnackBarHelper.showTopSnack(
          appRouter.currentContext.l10n.unauthorized, APIState.error);
    }
    return val;
  }

  CartUpdateModel get getUpdateModel {
    return CartUpdateModel(
      productId: currentProdId!,
      properties: state.selectedProps.values.toList(),
      quantity: 1,
    );
  }

  Map<String, int> getDefaultProps(ProductDetailsModel model) {
    final propList =
        model.properties.map((e) => {e.name: e.values.first.id}).toList();
    final Map<String, int> joinedMap = {};
    propList.forEach((element) {
      joinedMap.addAll(element);
    });
    return joinedMap;
  }
}
