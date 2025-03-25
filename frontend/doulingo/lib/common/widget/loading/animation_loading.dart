import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_animation.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class AnimationLoading extends StatelessWidget {
  const AnimationLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              AppAnimation.animationCongratulation,
              repeat: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextViewShow(
                  text: AppTexts.tvLoadingTitle,
                  size: 20,
                  color: AppColors.textColor.withOpacity(.8),
                  fw: FontWeight.w800,
                ),
                const SizedBox(
                  width: 4,
                ),
                SpinKitThreeBounce(
                  color: AppColors.textColor.withOpacity(.8),
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
