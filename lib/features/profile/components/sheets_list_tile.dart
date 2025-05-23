import 'package:flutter/material.dart';
import 'package:bookstore.tm/features/profile/components/selected_indicator.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:bookstore.tm/settings/theme.dart';

class ProfileSelectListTile extends StatelessWidget {
  const ProfileSelectListTile(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap});
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPaddings.horiz_16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.bodyMedium14(context),
            ),
            SheetListTileSelectedIndicator(
              isSelected: isSelected,
            )
          ],
        ),
      ),
    );
  }
}
