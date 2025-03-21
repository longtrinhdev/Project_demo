import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/introduce/introduce_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted == true) {
      AppRoute.pushAndRemoveLeftToRight(
        context,
        const IntroducePage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextViewShow(
                  text: AppTexts.appName.toLowerCase(),
                  size: 32,
                  fw: FontWeight.w800,
                  color: AppColors.secondBackground,
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset(AppImages.imgMascot),
          ),
        ],
      ),
    );
  }
}
