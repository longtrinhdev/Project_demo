import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_email_page.dart';
import 'package:doulingo/presentation/introduce/introduce_page.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({super.key});

  PreferredSizeWidget _appbar() {
    return const AppbarBase(
      backgroundColor: AppColors.background,
      hideBack: true,
    );
  }

  Widget _body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: AppTooltip(
          message: AppTexts.tvCreateProfileTitle,
          widget: Image.asset(AppImages.imgIntro),
          distanceLeft: size.width / 4 - 20,
          distanceTop: size.height / 4 - 36,
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseButton(
            onPressed: () {
              AppRoute.push(
                context,
                const EnterEmailPage(),
              );
            },
            backgroundColor: AppColors.textThirdColor,
            checkBorder: true,
            widget: Text(
              AppTexts.btnCreateFilePage.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.background,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              AppRoute.pushAndRemove(
                context,
                const IntroducePage(),
              );
            },
            child: Text(
              AppTexts.btnDifference.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: AppColors.textThirdColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appbar(),
      body: _body(size),
      bottomNavigationBar: _button(context),
    );
  }
}
