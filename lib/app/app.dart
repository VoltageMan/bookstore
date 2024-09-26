import 'package:bookstore/app/setup.dart';
import 'package:bookstore/features/address/cubit/address_cubit.dart';
import 'package:bookstore/features/auth/bloc/auth_bloc.dart';
import 'package:bookstore/features/cart/cubit/cart_cubit.dart';
import 'package:bookstore/features/categories/bloc/category_bloc.dart';
import 'package:bookstore/features/chat/bloc/chat_bloc.dart';
import 'package:bookstore/features/favors/bloc/favors_bloc.dart';
import 'package:bookstore/features/feed_back/cubit/feed_back_cubit.dart';
import 'package:bookstore/features/filter/bloc/filter_bloc.dart';
import 'package:bookstore/features/home/bloc/home_bloc.dart';
import 'package:bookstore/features/mainScreen/view/components/navBar/nav_bar.dart';
import 'package:bookstore/features/notifications/cubit/notification_cubit.dart';
import 'package:bookstore/features/order_history/cubit/order_history_cubit.dart';
import 'package:bookstore/features/product_details/bloc/product_details_bloc.dart';
import 'package:bookstore/features/products_by_category/bloc/products_by_category_bloc.dart';
import 'package:bookstore/features/video/cubit/video_cubit.dart';
import 'package:bookstore/features/video/view/details/cubit/video_details_cubit.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/helpers/routes.dart';
import 'package:bookstore/helpers/spacers.dart';
import 'package:bookstore/repositories/products/product_repo.dart';
import 'package:bookstore/settings/globals.dart';
import 'package:bookstore/settings/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    bodyIndex.value = 0;
    super.initState();
  }

  final repo = getIt<ProductRepo>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => ChatBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ProductsByCategoryBloc()),
        BlocProvider(create: (context) => ProductDetailsBloc()),
        BlocProvider(create: (context) => FilterBloc()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => AddressCubit()),
        BlocProvider(create: (context) => OrderHistoryCubit()),
        BlocProvider(create: (context) => FavorsCubit()),
        BlocProvider(create: (context) => VideoCubit()),
        BlocProvider(create: (context) => VideoDetailsCubit()),
        BlocProvider(create: (context) => FeedBackCubit()..init())
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) {
          return ValueListenableBuilder(
            valueListenable: locale,
            builder: (context, locale, child) {
              locale.log();
              return MaterialApp.router(
                title: 'Yuan Shop',
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: appRouter,
                locale: Locale(locale),
                theme: AppTheme.lightTheme,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                builder: (context, child) {
                  AppSpacing.init(context);
                  return Navigator(
                    onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaler: TextScaler.linear(1)),
                          child: child!,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
