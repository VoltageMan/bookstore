import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bookstore.tm/data/local/secured_storage.dart';
import 'package:bookstore.tm/features/address/cubit/address_cubit.dart';
import 'package:bookstore.tm/features/auth/bloc/auth_bloc.dart';
import 'package:bookstore.tm/features/cart/cubit/cart_cubit.dart';
import 'package:bookstore.tm/features/categories/bloc/category_bloc.dart';
import 'package:bookstore.tm/features/favors/bloc/favors_bloc.dart';
import 'package:bookstore.tm/features/home/bloc/home_bloc.dart';
import 'package:bookstore.tm/features/order_history/cubit/order_history_cubit.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/routes.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/settings/consts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: AppColors.white));
    initApp();
    super.initState();
  }

  Future initApp() async {
    await LocalStorage.init();
    context.read<HomeBloc>().init();
    context.read<AuthBloc>().authMe();
    context.read<CategoryBloc>()..add(InitCategories());
    context.read<CartCubit>().getCurrentCart();
    context.read<AddressCubit>().init();
    context.read<OrderHistoryCubit>().init();
    context.read<FavorsCubit>().getFavors();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => appRouter.go(AppRoutes.mainScreen));
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.textTheme;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            // color: AppColors.mainOrange,
            color: AppColors.white,
            image: DecorationImage(
              image: AssetImage(
                AssetsPath.splashBackPng,
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: AppPaddings.vertic_28,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),

              SvgPicture.asset(
                AssetsPath.logoIcon,
                width: 147.w,
                height: 123.h,
              ),
              AppSpacing.vertical_20,
              AppSpacing.vertical_7,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Book',
                    style: theme.displayLarge!.copyWith(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  AppSpacing.horizontal_12,
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: AppBorderRadiuses.border_6,
                        color: AppColors.black),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    child: Text(
                      'store',
                      style: theme.displayLarge!.copyWith(
                          color: AppColors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),

              // Spacer
              SizedBox(
                height: 206.h,
              ),

              // Book icon
              SvgPicture.asset(AssetsPath.bookIcon),

              // Spacer
              SizedBox(
                height: 86.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
