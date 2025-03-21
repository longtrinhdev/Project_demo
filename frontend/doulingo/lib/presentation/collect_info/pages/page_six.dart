import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/collect_info/pages/create_profile.dart';
import 'package:flutter/material.dart';

class PageSix extends StatefulWidget {
  final double progress;
  final String? userId;
  const PageSix({
    super.key,
    required this.progress,
    this.userId,
  });

  @override
  State<PageSix> createState() => _PageSixState();
}

class _PageSixState extends State<PageSix> {
  double? progress;

  PreferredSizeWidget _appBar(Size size) {
    return AppbarBase(
      backgroundColor: AppColors.background,
      checkIcon: true,
      action: SizedBox(
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: size.width - 80,
              height: 15,
              child: LinearProgressIndicator(
                value: (progress == null) ? widget.progress : progress,
                borderRadius: BorderRadius.circular(16),
                backgroundColor: AppColors.unselect,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.secondColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          AppTooltip(
            message: AppTexts.tvPageSixTitle,
            widget: Image.asset(AppImages.imgIntro),
            distanceLeft: size.width / 4 + 20,
            distanceTop: 18,
            arrowDirection: true,
          ),
        ],
      ),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BaseButton(
        onPressed: () {
          setState(() {
            progress = 1.0;
          });
          Future.delayed(
            const Duration(seconds: 5),
          );
          AppRoute.pushLeftToRight(
            context,
            CreateProfile(
              userId: widget.userId,
            ),
          );
        },
        backgroundColor: AppColors.secondColor,
        widget: TextViewShow(
          text: AppTexts.tvContinue.toUpperCase(),
          size: 18,
          color: AppColors.background,
          fw: FontWeight.w800,
        ),
        checkBorder: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(size),
      body: _body(size),
      bottomNavigationBar: _button(),
    );
  }
}
