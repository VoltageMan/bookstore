import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bookstore/app/setup.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/repositories/products/product_repo.dart';
import 'package:bookstore/settings/enums.dart';

part 'feed_back_state.dart';

class FeedBackCubit extends Cubit<FeedBackState> {
  FeedBackCubit() : super(FeedBackState(apiState: APIState.init));
  final _repo = getIt<ProductRepo>();

  Future<void> init() async {
    if (state.apiState == APIState.loading ||
        state.apiState == APIState.success) return;
    emit(FeedBackState(apiState: APIState.loading));

    final data = await _repo.getFeedBack();
    if (data != null) {
      emit(
        FeedBackState(apiState: APIState.success, data: data),
      );
      state.apiState.log();
      return;
    }
    return emit(FeedBackState(apiState: APIState.error));
  }
}
