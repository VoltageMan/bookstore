import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bookstore/app/setup.dart';
import 'package:bookstore/data/local/secured_storage.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/helpers/overlay_helper.dart';
import 'package:bookstore/helpers/routes.dart';
import 'package:bookstore/models/addres/address_model.dart';
import 'package:bookstore/models/pagination/pagination_model.dart';
import 'package:bookstore/repositories/address/address_repo.dart';
import 'package:bookstore/settings/consts.dart';
import 'package:bookstore/settings/enums.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressState(state: AddressApiState.init));
  final _repo = getIt<AddressRepo>();

  int selectedAddresIndex = -1;
  Future<void> create(String address) async {
    if (address.length < 5) {
      'address Must BeMore Than 5 Symbols'.log();
      SnackBarHelper.showTopSnack(
          'address Must BeMore Than 5 Symbols', APIState.error);

      /// show fail message
      return;
    }

    OverlayHelper.showLoading();
    final response = await _repo.create(address);
    bool isSucceed = false;
    if (response != null) {
      isSucceed = true;
      emit(
        AddressState(
          state: AddressApiState.succses,
          models: List.from(state.models)..add(response),
        ),
      );
    }
    final l10n = appRouter.currentContext.l10n;
    SnackBarHelper.showTopSnack(
      isSucceed ? l10n.succsess : l10n.socketExeption,
      isSucceed ? APIState.success : APIState.error,
    );
    OverlayHelper.remove();
  }

  Future<void> init({bool forUpdate = false}) async {
    if (LocalStorage.getToken == null) {
      return emit(
        AddressState(state: AddressApiState.unAuthorized),
      );
    }
    emit(
      AddressState(
        state: AddressApiState.loading,
        models: List.empty(growable: true),
      ),
    );
    final data = await _repo.read(0);
    if (data != null) {
      return emit(
        AddressState(
          state: AddressApiState.succses,
          models: List.from(data[APIKeys.data]),
          pagination: data[APIKeys.pagination],
        ),
      );
    }

    return emit(AddressState(state: AddressApiState.error));
  }

  Future<void> update(AddressModel model) async {
    final l10n = appRouter.currentContext.l10n;
    if (model.address.length < 5) {
      SnackBarHelper.showTopSnack(l10n.least5Symbols, APIState.error);

      /// show fail message
      return;
    }
    OverlayHelper.showLoading();
    final response = await _repo.update(model);
    bool isSucceed = false;
    if (response != null) {
      isSucceed = true;
      final newModels = List<AddressModel>.from(state.models);
      final removeIndex =
          newModels.map((e) => e.uuid).toList().indexOf(model.uuid);
      newModels.removeAt(removeIndex);
      emit(
        AddressState(
          state: AddressApiState.succses,
          models: newModels..add(response),
        ),
      );
    }
    SnackBarHelper.showTopSnack(
      isSucceed ? l10n.succsess : l10n.socketExeption,
      isSucceed ? APIState.success : APIState.error,
    );
    OverlayHelper.remove();
  }
}
