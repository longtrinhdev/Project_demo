import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BounceItemWidget extends StatelessWidget {
  const BounceItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            AppColors.practiceStart,
            AppColors.practiceCenter,
            AppColors.practiceEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              AppVectors.icPractice,
            ),
          ),
          const Positioned(
            top: 24,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextViewShow(
                  text: AppTexts.tvPracticeContent,
                  size: 22,
                  color: AppColors.background,
                  fw: FontWeight.w800,
                ),
                SizedBox(
                  height: 16,
                ),
                TextViewShow(
                  text: AppTexts.tvPracticeContent1,
                  size: 18,
                  color: AppColors.background,
                  fw: FontWeight.w600,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
