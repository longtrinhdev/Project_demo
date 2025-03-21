import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/divider/app_divider.dart';
import 'package:doulingo/common/widget/round/app_round.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextViewShow(
              text: AppTexts.tvAccount,
              size: 20,
              fw: FontWeight.w800,
              color: AppColors.textColor.withOpacity(.8),
            ),
            const SizedBox(
              height: 8,
            ),
            AppRound(
              backgroundColor: AppColors.secondBackground.withOpacity(.5),
              borderColor: AppColors.unselect,
              widget: _account(),
            ),
            const SizedBox(
              height: 32,
            ),
            TextViewShow(
              text: AppTexts.tvSupportTitle,
              size: 20,
              fw: FontWeight.w800,
              color: AppColors.textColor.withOpacity(.8),
            ),
            const SizedBox(
              height: 12,
            ),
            AppRound(
              backgroundColor: AppColors.secondBackground.withOpacity(.5),
              borderColor: AppColors.unselect,
              widget: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _item(
                  AppTexts.tvSupport,
                  () {},
                ),
              ),
            ),
            const Spacer(),
            BaseButton(
              onPressed: () {
                AppRoute.pop(context);
              },
              backgroundColor: AppColors.background,
              checkBorder: true,
              widget: TextViewShow(
                text: AppTexts.btnBack.toUpperCase(),
                size: 18,
                fw: FontWeight.w800,
                color: AppColors.textThirdColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppbarBase(
      backgroundColor: AppColors.background,
      hideBack: true,
      bottom: const AppDivider(),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 8,
          ),
          TextViewShow(
            text: AppTexts.tvSettingTitle,
            size: 20,
            fw: FontWeight.w800,
            color: AppColors.textColor.withOpacity(.8),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _account() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _item(AppTexts.tvFile, () {}),
        ),
        const AppDivider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _item(AppTexts.tvNotification, () {}),
        ),
        const AppDivider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _item(AppTexts.tvCourse, () {}),
        ),
        const AppDivider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: _item(AppTexts.tvSocial, () {}),
        ),
      ],
    );
  }

  Widget _item(String message, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextViewShow(
            text: message,
            size: 20,
            fw: FontWeight.w900,
            color: AppColors.textColor,
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textSecondColor,
          ),
        ],
      ),
    );
  }
}
