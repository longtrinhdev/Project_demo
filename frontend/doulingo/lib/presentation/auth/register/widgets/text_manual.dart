import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';

class TextManual extends StatelessWidget {
  const TextManual({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: AppTexts.tvManualContent1,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondColor,
              ),
            ),
            TextSpan(
              text: AppTexts.tvManualContent2,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textColor.withOpacity(.8),
                fontWeight: FontWeight.w800,
              ),
            ),
            const TextSpan(
              text: AppTexts.tvManualContent3,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondColor,
              ),
            ),
            TextSpan(
              text: AppTexts.tvManualContent4,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textColor.withOpacity(.8),
                fontWeight: FontWeight.w800,
              ),
            ),
            const TextSpan(
              text: AppTexts.tvManualContent5,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
