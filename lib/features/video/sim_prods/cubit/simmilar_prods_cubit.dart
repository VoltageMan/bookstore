import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:bookstore.tm/app/setup.dart';
import 'package:bookstore.tm/models/pagination/pagination_model.dart';
import 'package:bookstore.tm/models/products/product_model.dart';
import 'package:bookstore.tm/repositories/products/product_repo.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/enums.dart';

part 'simmilar_prods_state.dart';

class SimmilarProdsCubit extends Cubit<SimmilarProdsState> {
  SimmilarProdsCubit(this.slug, this.id)
      : super(SimmilarProdsState(state: ProductAPIState.init));
  final String slug;
  final int id;
  int videoId = 0;
  CancelToken? cnToken;
  final _repo = getIt<ProductRepo>();
  void cancel() {
    cnToken?.cancel();
  }

  Future<void> init({bool forUpdate = false}) async {
    if (state.state != ProductAPIState.init &&
        state.state != ProductAPIState.error &&
        !forUpdate) {
      return;
    }
    emit(
      SimmilarProdsState(state: ProductAPIState.loading),
    );
    cnToken = CancelToken();
    final data = await _repo.getDetails(id, cnToken!);

    if (data != null) {
      return emit(
        SimmilarProdsState(
          state: ProductAPIState.success,
          pagination: PaginationModel(
            count: data.similarProducts.length,
            currentPage: 1,
            lastPage: 1,
            perPage: 0,
            total: data.similarProducts.length,
          ),
          prods: List.from(data.similarProducts),
        ),
      );
    }
    return emit(SimmilarProdsState(state: ProductAPIState.error));
  }

  Future<void> loadMore() async {
    emit(
      SimmilarProdsState(
        state: ProductAPIState.loadingMore,
        pagination: state.pagination,
        prods: List.from(
          state.prods ?? List.empty(),
        ),
      ),
    );
    final data = await _repo.getProducts(
      slugs: [slug],
      properties: List.empty(),
      page: state.pagination!.currentPage + 1,
    );
    if (data != null) {
      return emit(
        SimmilarProdsState(
          state: ProductAPIState.success,
          pagination: data[APIKeys.pagination],
          prods: List.from(state.prods ?? List.empty())
            ..addAll(
              data[APIKeys.products],
            ),
        ),
      );
    }
    return emit(
      SimmilarProdsState(
        state: ProductAPIState.loadingMoreError,
        pagination: state.pagination,
        prods: List.from(state.prods ?? List.empty()),
      ),
    );
  }
}
