import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/core/constant/app_urls.dart';
import 'package:doulingo/presentation/collect_info/pages/welcome.dart';
import 'package:doulingo/presentation/auth/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroducePage extends StatelessWidget {
  const IntroducePage({super.key});

  Widget _button(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        BaseButton(
          onPressed: () {
            AppRoute.pushBottomToTop(
              context,
              const WelcomePage(),
            );
          },
          widget: const Text(
            AppTexts.btnGetStarted,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.background,
            ),
          ),
          backgroundColor: AppColors.secondColor,
          checkBorder: true,
        ),
        const SizedBox(
          height: 12,
        ),
        BaseButton(
          onPressed: () {
            AppRoute.pushBottomToTop(
              context,
              const SigninPage(),
            );
          },
          widget: const Text(
            AppTexts.btnAccount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textThirdColor,
            ),
          ),
          backgroundColor: AppColors.background,
          checkBorder: true,
        )
      ],
    );
  }

  Widget _image() {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        SvgPicture.asset(
          AppVectors.vtIntro,
        ),
        const SizedBox(
          height: 12,
        ),
        const Text(
          AppTexts.introducePageTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.network(
              AppUrls.logoAppUrl,
            ),
            _image(),
            _button(context),
          ],
        ),
      ),
    );
  }
}
