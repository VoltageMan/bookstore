import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/categories/view/body.dart';
import 'package:bookstore.tm/features/components/widgets/sheet_titles.dart';
import 'package:bookstore.tm/features/feed_back/cubit/feed_back_cubit.dart';
import 'package:bookstore.tm/features/feed_back/view/feed_back_tile.dart';
import 'package:bookstore.tm/features/product_details/view/product_details_body.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/enums.dart';

class FeedBackSheet extends StatelessWidget {
  const FeedBackSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedBackCubit>();
    return SizedBox(
      height: 300.h,
      child: Column(
        children: [
          BottomSheetTitle(title: context.l10n.feedBack, isPadded: true),
          Expanded(
            child: BlocBuilder<FeedBackCubit, FeedBackState>(
              bloc: cubit,
              builder: (context, state) {
                state.apiState.log();
                if (state.apiState == APIState.init) return SizedBox();
                if (state.apiState == APIState.error)
                  return CategoryErrorBody(onTap: () => cubit.init());
                if (state.apiState == APIState.loading) return CenterLoading();
                return ListView.builder(
                  padding: AppPaddings.bottom_10,
                  itemCount: state.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return FeedBackTile(state.data?[index] ?? '');
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _centerText(String text) {
  return Center(
    child: Text(text),
  );
}
