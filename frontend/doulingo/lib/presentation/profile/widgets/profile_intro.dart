import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileIntroWidget extends StatelessWidget {
  const ProfileIntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextViewShow(
                text: 'Long',
                size: 24,
                fw: FontWeight.w900,
                color: AppColors.textColor,
              ),
              SvgPicture.network(
                'https://d35aaqx5ub95lt.cloudfront.net/vendor/bbe17e16aa4a106032d8e3521eaed13e.svg',
                width: 32,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          TextViewShow(
            text: 'pilong',
            size: 18,
            fw: FontWeight.w600,
            color: AppColors.textColor.withOpacity(.6),
          ),
          const SizedBox(
            height: 2,
          ),
          TextViewShow(
            text: AppTexts.tvWork,
            size: 16,
            fw: FontWeight.w600,
            color: AppColors.textColor.withOpacity(.6),
          ),
          const SizedBox(
            height: 8,
          ),
          const Row(
            children: [
              TextViewShow(
                text: '${AppTexts.tvFollowing} 0',
                size: 18,
                fw: FontWeight.w800,
                color: AppColors.textThirdColor,
              ),
              SizedBox(
                width: 12,
              ),
              TextViewShow(
                text: '1 ${AppTexts.tvFollowers}',
                size: 18,
                fw: FontWeight.w800,
                color: AppColors.textThirdColor,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: _button(_addFriend(), () {}),
              ),
              const SizedBox(
                width: 16,
              ),
              _button(_logout(), () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _button(Widget widget, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: const Border(
            bottom: BorderSide(
              color: AppColors.unselect,
              width: 4,
            ),
            top: BorderSide(
              color: AppColors.unselect,
              width: 1,
            ),
            left: BorderSide(
              color: AppColors.unselect,
              width: 1,
            ),
            right: BorderSide(
              color: AppColors.unselect,
              width: 1,
            ),
          ),
        ),
        child: widget,
      ),
    );
  }

  Widget _addFriend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.person_add_alt_1_rounded,
          color: AppColors.textThirdColor,
        ),
        const SizedBox(
          width: 10,
        ),
        TextViewShow(
          text: AppTexts.btnAddFriend.toUpperCase(),
          size: 18,
          fw: FontWeight.w800,
          color: AppColors.textThirdColor,
        ),
      ],
    );
  }

  Widget _logout() {
    return Image.asset(
      AppImages.imgLogout,
    );
  }
}
