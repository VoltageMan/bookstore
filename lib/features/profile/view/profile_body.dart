import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:bookstore.tm/data/local/secured_storage.dart';
import 'package:bookstore.tm/features/address/cubit/address_cubit.dart';
import 'package:bookstore.tm/features/auth/bloc/auth_bloc.dart';
import 'package:bookstore.tm/features/favors/bloc/favors_bloc.dart';
import 'package:bookstore.tm/features/order_history/cubit/order_history_cubit.dart';
import 'package:bookstore.tm/features/profile/components/profile_list_tile.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/modal_sheets.dart';
import 'package:bookstore.tm/helpers/routes.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/globals.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});
  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void initState() {
    super.initState();
  }

  void setContents() {
    contents = List.from(
      [
        authBloc.state.user != null ? authBloc.state.user!.name : '',
        addressState.state.models.isNotEmpty
            ? addressState.state.models.first.address
            : '',
        orderState.state.models.isNotEmpty
            ? orderState.state.models.first.statusTrans
            : '',
        favorsState.state.models.isNotEmpty
            ? favorsState.state.models.first.name
            : '',
        langs[locale.value]!,
        '',
      ],
    );
  }

  get l10n => context.l10n;

  List<String> get icons => [
        AssetsPath.profileIcon,
        AssetsPath.locationIcon,
        AssetsPath.ordersIcon,
        AssetsPath.favorFilled,
        AssetsPath.langIcon,
        AssetsPath.phoneCall,
      ];
  get langs => {
        'tr': l10n.turkmen,
        'ru': l10n.russian,
        'en': l10n.english,
      };

  List<String> get titles => [
        LocalStorage.getToken == null ? l10n.auth : l10n.myProfile,
        l10n.address,
        l10n.myOrders,
        l10n.favorites,
        l10n.programLang,
        l10n.feedBack,
      ];
  late final favorsState = context.read<FavorsCubit>();
  late final orderState = context.read<OrderHistoryCubit>();
  late final addressState = context.read<AddressCubit>();
  late final authBloc = context.read<AuthBloc>();
  late List<String> contents;
  @override
  Widget build(BuildContext context) {
    setContents();
    return MultiBlocListener(
      listeners: [
        BlocListener<FavorsCubit, FavorsState>(
          listener: (context, state) => setState(() => setContents()),
        ),
        BlocListener<OrderHistoryCubit, OrderHistoryState>(
          listener: (context, state) => setState(() => setContents()),
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) => setState(() => setContents()),
        ),
        BlocListener<AddressCubit, AddressState>(
          listener: (context, state) => setState(() => setContents()),
        )
      ],
      child: Column(
        children: [
          AppSpacing.vertical_30,
          ...List.generate(
            titles.length,
            (index) => ProfileListTile(
              iconPath: icons[index],
              onTap: () {
                authBloc.state.log();
                if (index == 0) {
                  final isAuthed = LocalStorage.getToken != null;
                  GoRouter.of(context).push(
                      isAuthed ? AppRoutes.myProfile : AppRoutes.auth,
                      extra: true);
                  return;
                }
                index.log();
                ModelBottomSheetHelper.showProfileSheets(index);
              },
              title: titles[index],
              tralling: contents[index],
            ),
          ),
        ],
      ),
    );
  }
}
