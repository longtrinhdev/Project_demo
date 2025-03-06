import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/collect_info/pages/create_profile.dart';
import 'package:flutter/material.dart';

class PageSix extends StatefulWidget {
  final double progress;
  const PageSix({
    super.key,
    required this.progress,
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
            const CreateProfile(),
          );
        },
        backgroundColor: AppColors.secondColor,
        widget: Text(
          AppTexts.tvContinue.toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.background,
            fontWeight: FontWeight.w800,
          ),
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
