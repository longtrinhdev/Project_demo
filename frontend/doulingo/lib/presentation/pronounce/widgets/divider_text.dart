import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  final String message;
  const DividerText({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.textSecondColor.withOpacity(.5),
            thickness: 2,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        _text(
          21,
          message,
          FontWeight.w900,
          AppColors.textColor.withOpacity(.9),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Divider(
            color: AppColors.textSecondColor.withOpacity(.5),
            thickness: 2,
          ),
        ),
      ],
    );
  }

  Widget _text(double fontSize, String message, FontWeight fw, Color color) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fw,
      ),
    );
  }
}
