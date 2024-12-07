import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:bookstore.tm/features/auth/bloc/auth_bloc.dart';
import 'package:bookstore.tm/features/categories/view/body.dart';
import 'package:bookstore.tm/features/my_profile/view/my_profile_tile.dart';
import 'package:bookstore.tm/features/product_details/view/product_details_body.dart';
import 'package:bookstore.tm/helpers/confirm_exit.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/modal_sheets.dart';
import 'package:bookstore.tm/settings/consts.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late final l10n = context.l10n;
  late final authBloc = context.read<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Confirm.doPop() && ModelBottomSheetHelper.doPop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.l10n.myProfile,
            style: context.theme.textTheme.titleMedium,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => context.pop(),
            alignment: Alignment.center,
            color: AppColors.black,
            iconSize: 23.sp,
          ),
        ),
        body: FutureBuilder(
          future: authBloc.authMe(),
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return CenterLoading();
            }
            if (authBloc.state.user == null) {
              return CategoryErrorBody(onTap: () {
                setState(() {});
              });
            }
            return Padding(
              padding: AppPaddings.all_16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.account),
                  16.verticalSpace,
                  BlocBuilder<AuthBloc, AuthState>(
                    bloc: authBloc,
                    builder: (context, state) {
                      return MyProfileTile(
                        icons: null,
                        contents: [
                          '+${state.user?.entity ?? ''}',
                          state.user?.name ?? ' '
                        ],
                        titles: [l10n.phoneNumber, l10n.userName],
                        onTaps: [
                          () {},
                          () {
                            ModelBottomSheetHelper.showEditUserNameSheet();
                          },
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: AppPaddings.vertic_16,
                    child: Text(l10n.exit),
                  ),
                  MyProfileTile(
                    icons: [Icons.arrow_forward_ios, Icons.delete_outlined],
                    contents: ['', ''],
                    titles: [l10n.logOut, l10n.deleteAcc],
                    onTaps: [
                      () async {
                        await Confirm.showLogOutDialog(context);
                      },
                      () async {
                        await Confirm.showDeleteAccDialog(context);
                      }
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
