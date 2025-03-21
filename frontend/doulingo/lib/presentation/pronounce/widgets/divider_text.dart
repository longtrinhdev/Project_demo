import 'package:doulingo/common/widget/text/app_textview.dart';
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
        TextViewShow(
          size: 21,
          text: message,
          fw: FontWeight.w900,
          color: AppColors.textColor.withOpacity(.9),
          isCenter: true,
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
}
