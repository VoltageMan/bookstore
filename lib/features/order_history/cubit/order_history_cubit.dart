import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bookstore/app/setup.dart';
import 'package:bookstore/data/local/secured_storage.dart';
import 'package:bookstore/models/order_history/order_history_model.dart';
import 'package:bookstore/models/pagination/pagination_model.dart';
import 'package:bookstore/repositories/order/order_repo.dart';
import 'package:bookstore/settings/enums.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryState.deftState);

  final repo = getIt<OrderRepo>();
  Future<void> init({bool forUpdate = false}) async {
    if (state.apiState != OrderHistoryAPIState.init &&
        state.apiState != OrderHistoryAPIState.error &&
        !forUpdate) {
      return;
    }
    if (LocalStorage.getToken == null) {
      emit(
        OrderHistoryState(
          apiState: OrderHistoryAPIState.unauthorized,
          models: List.empty(growable: true),
        ),
      );
      return;
    }
    state.models.clear();
    emit(
      OrderHistoryState(
        apiState: OrderHistoryAPIState.loading,
        models: List.empty(growable: true),
      ),
    );
    final response = await repo.getOrderHistory(0);
    if (response != null) {
      return emit(
        OrderHistoryState(
          apiState: OrderHistoryAPIState.success,
          models: List.from(response.data),
          pagination: response.pagination,
        ),
      );
    }
    emit(
      OrderHistoryState(
        apiState: OrderHistoryAPIState.error,
        models: List.empty(growable: true),
      ),
    );
  }

  Future<void> loadMore() async {
    emit(
      OrderHistoryState(
        apiState: OrderHistoryAPIState.loadingMore,
        models: List.from(state.models),
        pagination: state.pagination,
      ),
    );
    final response =
        await repo.getOrderHistory((state.pagination!.currentPage + 1));
    if (response != null) {
      return emit(
        OrderHistoryState(
          apiState: OrderHistoryAPIState.success,
          models: List.from(state.models)..addAll(response.data),
          pagination: response.pagination,
        ),
      );
    }
    emit(
      OrderHistoryState(
        apiState: OrderHistoryAPIState.errorMore,
        models: List.from(state.models),
        pagination: state.pagination,
      ),
    );
  }
}
