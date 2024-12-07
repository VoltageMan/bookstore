import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore.tm/features/components/widgets/place_holder.dart';
import 'package:bookstore.tm/features/video/view/details/cubit/video_details_cubit.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/helpers/modal_sheets.dart';
import 'package:bookstore.tm/helpers/routes.dart';
import 'package:bookstore.tm/helpers/spacers.dart';
import 'package:bookstore.tm/models/products/product_model.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/theme.dart';

class SimmilarVideoWidget extends StatelessWidget {
  const SimmilarVideoWidget({
    super.key,
    this.model,
  });
  final ProductModel? model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ModelBottomSheetHelper.doPop();
        context.read<VideoDetailsCubit>().changePage(-1);
        appRouter.push(AppRoutes.prodDetails, extra: model!.id);
      },
      child: Container(
        height: (AppSpacing.getTextHeight(67)) + 38.h,
        width: double.infinity,
        margin: AppPaddings.horiz_16.add(AppPaddings.vertic_12),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 115 / 139,
              child: ClipRRect(
                borderRadius: AppBorderRadiuses.border_6,
                child: CachedNetworkImage(
                  imageUrl: model?.image ?? AssetsPath.macBook,
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: AppColors.darkBlue,
                      ),
                    );
                  },
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const MyShimerPlaceHolder(),
                ),
              ),
            ),
            AppSpacing.horizontal_15,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model?.description}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.displaySmall12(context),
                  ),
                  AppSpacing.vertical_12,
                  Text(
                    '${model?.salePrice} TMT',
                    style: AppTheme.titleLargeW600(context),
                  ),
                  Text(
                    '${model?.price} TMT',
                    style: AppTheme.displaySmall12(context).copyWith(),
                  ),
                  AppSpacing.vertical_12,
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF0B1427),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: AppPaddings.horiz10_vertic5,
                    child: FittedBox(
                      child: Text(
                        context.l10n.details,
                        maxLines: 1,
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
