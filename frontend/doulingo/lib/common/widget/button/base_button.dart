import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? widget;
  final Color? backgroundColor;
  final bool? checkBorder;
  final double? height;
  const BaseButton({
    super.key,
    required this.onPressed,
    this.widget,
    this.backgroundColor,
    this.height,
    this.checkBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width,
        alignment: Alignment.center,
        height: height ?? 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor ?? Colors.white,
          border: (checkBorder == true)
              ? Border(
                  bottom: BorderSide(
                    color: backgroundColor == AppColors.background
                        ? AppColors.textSecondColor
                        : AppColors.textColor.withOpacity(.5),
                    width: 4,
                    style: BorderStyle.solid,
                  ),
                )
              : null,
        ),
        child: widget ?? Container(),
      ),
    );
  }
}
