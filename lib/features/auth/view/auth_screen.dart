import 'package:flutter/material.dart';
import 'package:bookstore.tm/features/auth/view/auth_app_bar.dart';
import 'package:bookstore.tm/features/auth/view/auth_body.dart';
import 'package:bookstore.tm/helpers/confirm_exit.dart';
import 'package:bookstore.tm/helpers/extentions.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.forSingUp});
  final bool forSingUp;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return WillPopScope(
      onWillPop: () async {
        return Confirm.doPop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AuthAppBar(
          title: forSingUp ? l10n.registration : l10n.singIn,
        ),
        body: AuthBody(
          forSingUp: forSingUp,
        ),
      ),
    );
  }
}
