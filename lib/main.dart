import 'dart:async';

import 'package:bookstore/app/app.dart';
import 'package:bookstore/app/setup.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  configureDependencies(getIt);

  final mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark);

  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  runZonedGuarded(() async {
    await WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return runApp(const MyApp());
  }, (error, stack) async {
    'RunZoneError \nerror:${error}\nstackTrace:$stack'.log();
    // Restart.restartApp();
    await Future.delayed(Duration.zero);
  });
}
