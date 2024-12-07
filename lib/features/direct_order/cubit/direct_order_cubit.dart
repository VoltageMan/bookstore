import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bookstore.tm/app/setup.dart';
import 'package:bookstore.tm/models/cart/cart_model/cart_model.dart';
import 'package:bookstore.tm/models/cart/cart_update/cart_update_model.dart';
import 'package:bookstore.tm/repositories/cart/cart_repository.dart';
import 'package:bookstore.tm/settings/enums.dart';

part 'direct_order_state.dart';

class DirectOrderCubit extends Cubit<DirectOrderState> {
  DirectOrderCubit() : super(DirectOrderState(apiState: APIState.init));

  final _repo = getIt<CartRepo>();
  Future<void> init(CartUpdateModel model) async {
    emit(state.copyWith(apiState: APIState.loading));
    final response = await _repo.getInstance(model);

    if (response != null) {
      return emit(
        DirectOrderState(
          apiState: APIState.success,
          cartModel: response,
        ),
      );
    }
    return emit(state.copyWith(apiState: APIState.error));
  }

  Future<void> updateQuantity(int quantity) async {
    if (_isUpdating) return;
    final order = state.cartModel!.orders.first;
    _isUpdating = true;
    final response = await _repo.getInstance(
      CartUpdateModel(
        productId: order.product.id,
        properties: (order.propertyValues ?? []).map((e) => e.id).toList(),
        quantity: quantity,
      ),
    );
    _isUpdating = false;
    if (response != null) {
      return emit(
        DirectOrderState(
          apiState: APIState.success,
          cartModel: response,
        ),
      );
    }
  }

  Future<bool> complete(String address) async {
    final response =
        await _repo.completeInstance(state.cartModel!.uuid, address);
    return response;
  }

  bool _isUpdating = false;
}
