import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore.tm/app/setup.dart';
import 'package:bookstore.tm/helpers/confirm_exit.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/models/pagination/pagination_model.dart';
import 'package:bookstore.tm/models/products/product_model.dart';
import 'package:bookstore.tm/models/property/values/property_value_model.dart';
import 'package:bookstore.tm/models/state/state_model.dart';
import 'package:bookstore.tm/repositories/products/product_repo.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/enums.dart';
import 'package:package_info_plus/package_info_plus.dart';
part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc()
      : super(HomeState(
          state: ProductAPIState.init,
        ));

  final _repo = getIt<ProductRepo>();
  double lastPosition = 0;
  List<PropertyValue> _filters = List.empty();

  Future<void> init({bool forUpdate = false}) async {
    if (state.state != ProductAPIState.init &&
        state.state != ProductAPIState.error &&
        !forUpdate) {
      return;
    }
    emit(
      HomeState(
        stateInfo: state.stateInfo,
        state: ProductAPIState.loading,
      ),
    );
    final data = await _repo.getProducts(
      slugs: List.empty(),
      properties: _filters.map((e) => e.id).toList(),
      page: 0,
    );
    StateModel? stateInfo;
    if (state.stateInfo == null) {
      final stateInfoData = await _repo.getDeliveryInfo();

      stateInfo = stateInfoData;
    } else {
      stateInfo = state.stateInfo;
    }
    if (data != null && stateInfo != null) {
      notificateAboutUpdate(stateInfo.appVersion);
      return emit(
        HomeState(
          state: ProductAPIState.success,
          pagination: data[APIKeys.pagination],
          prods: List.from(data[APIKeys.products]),
          stateInfo: stateInfo,
        ),
      );
    }
    return emit(
      HomeState(stateInfo: state.stateInfo, state: ProductAPIState.error),
    );
  }

  Future<void> loadMore() async {
    emit(
      HomeState(
        stateInfo: state.stateInfo,
        state: ProductAPIState.loadingMore,
        pagination: state.pagination,
        prods: List.from(
          state.prods ?? List.empty(),
        ),
      ),
    );
    final data = await _repo.getProducts(
      slugs: List.empty(),
      properties: List.empty(),
      page: state.pagination!.currentPage + 1,
    );
    if (data != null) {
      return emit(
        HomeState(
          stateInfo: state.stateInfo,
          state: ProductAPIState.success,
          pagination: data[APIKeys.pagination],
          prods: List.from(state.prods ?? List.empty())
            ..addAll(data[APIKeys.products]),
        ),
      );
    }
    return emit(
      HomeState(
        stateInfo: state.stateInfo,
        state: ProductAPIState.loadingMoreError,
        pagination: state.pagination,
        prods: List.from(state.prods ?? List.empty()),
      ),
    );
  }

  void filter(List<PropertyValue> props) {
    _filters = List.from(props);
    lastPosition = 0;
    init(forUpdate: true);
  }

  Future<void> notificateAboutUpdate(String lastAppVersion) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final currentAppVersion = packageInfo.version..log();
    if (lastAppVersion != currentAppVersion) {
      Confirm.showUpdateNotificationDialog();
    }
  }
}
