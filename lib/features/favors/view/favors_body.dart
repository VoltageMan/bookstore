import 'package:flutter/material.dart';
import 'package:bookstore/features/components/widgets/sheet_titles.dart';
import 'package:bookstore/features/favors/components/favors_builder.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/helpers/spacers.dart';

class FavorsBody extends StatelessWidget {
  const FavorsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetTitle(
          title: context.l10n.favorites,
          isPadded: true,
        ),
        AppSpacing.vertical_10,
        const FavrosBuilder(),
      ],
    ).toSingleChildScrollView;
  }
}
