import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookstore/features/components/widgets/svg_icons.dart';
import 'package:bookstore/features/notifications/cubit/notification_cubit.dart';
import 'package:bookstore/helpers/extentions.dart';
import 'package:bookstore/helpers/spacers.dart';
import 'package:bookstore/models/notifications/notification_model.dart';
import 'package:bookstore/settings/consts.dart';
import 'package:bookstore/settings/theme.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key, required this.notif});

  final NotificationModel? notif;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme.textTheme;
    final notifCubit = context.read<NotificationCubit>();
    return Container(
      margin: AppPaddings.bottom_5,
      color:
          widget.notif?.is_seen ?? false ? Colors.grey.shade100 : Colors.white,
      padding: AppPaddings.horiz16_vertic18,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyImageIcon(
            path: AssetsPath.crossIcon,
            contSize: 24.sp,
            color: AppColors.mainOrange,
            onTap: () {
              if (widget.notif != null)
                notifCubit.deleteNotification(widget.notif!.id);
            },
          ),
          AppSpacing.horizontal_12,
          SizedBox(
            width: 292.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${widget.notif?.id} ${widget.notif?.title}',
                  style: theme.titleLarge,
                ),
                Padding(
                  padding: AppPaddings.vertic_8,
                  child: Text(
                    widget.notif?.subTitle ?? '',
                    style: theme.titleSmall,
                  ),
                ),
                Text(
                  widget.notif?.date ?? '',
                  style: AppTheme.bodyMedium10(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
