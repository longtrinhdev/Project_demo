import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppbarBase extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideBack;
  final bool checkIcon;
  final double? height;
  const AppbarBase({
    super.key,
    this.title,
    this.action,
    this.backgroundColor,
    this.height,
    this.hideBack = false,
    this.checkIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      centerTitle: true,
      title: title ?? const Text(''),
      actions: [action ?? Container()],
      leading: hideBack == true
          ? null
          : IconButton(
              onPressed: () {
                AppRoute.pop(context);
              },
              icon: Icon(
                checkIcon ? Icons.arrow_back_rounded : Icons.close_rounded,
                size: 27,
                color: AppColors.textSecondColor,
              ),
            ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
