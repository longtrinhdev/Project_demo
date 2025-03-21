import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileOverview extends StatelessWidget {
  const ProfileOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextViewShow(
            text: AppTexts.tvOverview,
            size: 24,
            fw: FontWeight.w900,
            color: AppColors.textColor,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: _itemOverview(
                  AppVectors.icFire,
                  '20',
                  AppTexts.tvLeanDay,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: _itemOverview(
                  AppVectors.icKn,
                  '6891',
                  AppTexts.tvTotalKN,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: _itemOverview(
                  AppVectors.icAu,
                  'Top 1',
                  AppTexts.tvNowLevel,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: _itemOverview(
                  AppVectors.icCu,
                  '1',
                  AppTexts.tvOnTopThree,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemOverview(String icon, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.unselect,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          width: 21,
        ),
        title: TextViewShow(
          text: title,
          size: 18,
          fw: FontWeight.w800,
          color: AppColors.textColor,
        ),
        subtitle: TextViewShow(
          text: subtitle,
          size: 15,
          fw: FontWeight.w600,
          color: AppColors.textSecondColor,
        ),
      ),
    );
  }
}
