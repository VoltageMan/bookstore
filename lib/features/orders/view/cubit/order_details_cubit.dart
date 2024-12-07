import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bookstore.tm/app/setup.dart';
import 'package:bookstore.tm/models/cart/cart_model/cart_model.dart';
import 'package:bookstore.tm/repositories/order/order_repo.dart';
import 'package:bookstore.tm/settings/enums.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsState(apiState: APIState.init));

  final _repo = getIt<OrderRepo>();
  Future<void> init(String uuid) async {
    emit(OrderDetailsState(apiState: APIState.loading));
    //! change func
    final data = await _repo.getDetails(uuid);
    if (data != null) {
      return emit(
        OrderDetailsState(
          apiState: APIState.success,
          model: data,
        ),
      );
    }
    return emit(OrderDetailsState(apiState: APIState.error));
  }
}
