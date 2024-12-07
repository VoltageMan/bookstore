import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/auth/bloc/auth_bloc.dart';
import 'package:bookstore.tm/features/auth/components/auth_field.dart';
import 'package:bookstore.tm/features/components/my_text_button.dart';
import 'package:bookstore.tm/features/components/widgets/sheet_titles.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/settings/consts.dart';

class ChangeUserNameSheet extends StatefulWidget {
  const ChangeUserNameSheet({super.key});
  @override
  State<ChangeUserNameSheet> createState() => _ChangeUserNameSheetState();
}

class _ChangeUserNameSheetState extends State<ChangeUserNameSheet> {
  final controller = TextEditingController();
  @override
  void initState() {
    controller.text = authBloc.state.user!.name;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late final authBloc = context.read<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return KeyboardSizeProvider(
      smallSize: 400,
      child: Column(
        children: [
          BottomSheetTitle(
            title: l10n.userName,
            isPadded: true,
          ),
          AppSpacing.vertical_40,
          AuthField(
            keyboardType: TextInputType.text,
            label: l10n.name,
            controller: controller,
          ),
          Padding(
            padding: AppPaddings.horiz_16.copyWith(bottom: 16.h, top: 10.h),
            child: MyDarkTextButton(
              title: context.l10n.save,
              onTap: () async {
                final newName = controller.text;
                await authBloc.editUser(newName);
              },
            ),
          ),
          Consumer<ScreenHeight>(
            builder: (context, value, child) {
              return SizedBox(
                height: value.keyboardHeight,
              );
            },
          ),
        ],
      ).toSingleChildScrollView,
    );
  }
}
