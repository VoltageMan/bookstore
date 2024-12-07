import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/auth/bloc/auth_bloc.dart';
import 'package:bookstore.tm/features/terms_of_usage/usage_terms_widget.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/routes.dart';
import 'package:bookstore.tm/settings/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Confirm {
  static Future<void> onlogOut(BuildContext context) async {
    await context.read<AuthBloc>().logOut();
    Navigator.pop(_currentContext!);
  }

  static Future<void> onDeleteAcc(BuildContext context) async {
    await context.read<AuthBloc>().deleteAcc();
    Navigator.pop(_currentContext!);
  }

  static void onConfirmExit(BuildContext context) {
    Confirm.exit = true;
    Navigator.pop(_currentContext!);
  }

  static bool exit = false;
  static bool _isDialogShown = false;
  static BuildContext? _currentContext;
  static bool doPop() {
    if (_isDialogShown) {
      Navigator.pop(_currentContext!);
      return false;
    }
    return true;
  }

  static Future<bool> confirmExit(BuildContext context) async {
    exit = false;
    await showDialog(
      context: context,
      builder: (context) {
        _currentContext = context;
        _isDialogShown = true;
        return ConfirmingDialog(
          title: context.l10n.exit,
          content: context.l10n.exitConfirm,
          onConfirm: () => onConfirmExit(context),
        );
      },
    );
    _isDialogShown = false;
    return exit;
  }

  static Future<void> confirmTerms(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        _currentContext = context;
        _isDialogShown = true;
        _currentContext = context;
        return UsageTermsDialog();
      },
    );
    _isDialogShown = false;
  }

  static Future<void> showLogOutDialog(BuildContext context) async {
    final l10n = context.l10n;
    await showDialog(
      context: context,
      builder: (context) {
        _currentContext = context;
        _isDialogShown = true;
        return ConfirmingDialog(
          title: l10n.logOut,
          content: l10n.exitConfirm,
          onConfirm: () => onlogOut(context),
        );
      },
    );
    _isDialogShown = false;
  }

  static Future<void> showDeleteAccDialog(BuildContext context) async {
    final l10n = context.l10n;
    await showDialog(
      context: context,
      builder: (context) {
        _currentContext = context;
        _isDialogShown = true;
        return ConfirmingDialog(
          title: l10n.delete,
          content: l10n.deleteAccConfirm,
          confirmText: l10n.delete,
          onConfirm: () => onDeleteAcc(context),
        );
      },
    );
    _isDialogShown = false;
  }

  static Future<void> showUpdateNotificationDialog() async {
    final context = appRouter.currentContext;
    final l10n = context.l10n;
    await showDialog(
      context: context,
      builder: (context) {
        _currentContext = context;
        _isDialogShown = true;
        return ConfirmingDialog(
          title: l10n.updateTitle,
          content: l10n.updateTitle,
          confirmText: l10n.update,
          cancleText: l10n.later,
          onConfirm: sendToUpdateStore,
        );
      },
    );
    _isDialogShown = false;
  }

  static Future<void> sendToUpdateStore() async {
    final appId =
        Platform.isAndroid ? 'YOUR_ANDROID_PACKAGE_ID' : 'YOUR_IOS_APP_ID';
    final url = Uri.parse(
      Platform.isAndroid
          ? "market://details?id=$appId"
          : "https://apps.apple.com/app/id$appId",
    );
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}

class ConfirmingDialog extends StatelessWidget {
  const ConfirmingDialog({
    super.key,
    required this.content,
    required this.title,
    required this.onConfirm,
    this.confirmText,
    this.cancleText,
  });
  final String? confirmText;
  final String? cancleText;
  final String title;
  final String content;
  final VoidCallback onConfirm;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textButtonTheme.style as MyButtonStyle;
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(
        title,
        style: AppTheme.bodyLargeW500(context),
      ),
      content: Text(
        content,
        style: context.theme.textTheme.titleLarge!.copyWith(
          fontSize: 16.sp,
        ),
      ),
      actions: [
        TextButton(
          style: theme,
          onPressed: () => Navigator.pop(context),
          child: Text(
            cancleText ?? l10n.cancle,
            style: theme.myTextStyle,
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          style: theme,
          child: Text(
            confirmText ?? l10n.exit,
            style: theme.myTextStyle,
          ),
        ),
      ],
    );
  }
}
