import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/collect_info/pages/page_two.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  PreferredSizeWidget _appBar() {
    return const AppbarBase(
      backgroundColor: AppColors.background,
    );
  }

  Widget _button(BuildContext context) {
    return BaseButton(
      onPressed: () {
        AppRoute.push(context, const PageTwo());
      },
      backgroundColor: AppColors.secondColor,
      checkBorder: true,
      widget: Text(
        AppTexts.tvContinue.toUpperCase(),
        style: const TextStyle(
          fontSize: 18,
          color: AppColors.background,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: AppTooltip(
        message: AppTexts.tvWelcomeTitle,
        widget: Image.asset(
          AppImages.imgIntro,
        ),
        distanceLeft: 100,
        distanceTop: size.height / 3 - 60,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _button(context),
      ),
    );
  }
}
