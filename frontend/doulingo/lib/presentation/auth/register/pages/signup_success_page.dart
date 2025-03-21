import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_animation.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/signin/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignupSuccessPage extends StatefulWidget {
  final String text;
  const SignupSuccessPage({
    super.key,
    required this.text,
  });

  @override
  State<SignupSuccessPage> createState() => _SignupSuccessPageState();
}

class _SignupSuccessPageState extends State<SignupSuccessPage> {
  bool checkMessage = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BaseButton(
        onPressed: () {
          AppRoute.pushAndRemoveLeftToRight(
            context,
            const SigninPage(),
          );
        },
        backgroundColor: AppColors.secondColor,
        checkBorder: true,
        widget: const TextViewShow(
          text: AppTexts.btnLogin,
          size: 18,
          color: AppColors.background,
          fw: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _message(Size size) {
    return AppTooltip(
      message: widget.text,
      widget: Lottie.asset(
        AppAnimation.animationCongratulation,
        width: size.width,
        height: 320,
        repeat: false,
      ),
      distanceLeft: size.width / 5 - 30,
      distanceTop: size.height / 5 - 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: _message(size),
          )),
      bottomNavigationBar: _button(context),
    );
  }
}
