import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/item_view/item_view.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/collect_info/pages/page_five.dart';
import 'package:flutter/material.dart';

class PageFour extends StatefulWidget {
  final double progress;
  final String? userId;
  const PageFour({
    super.key,
    required this.progress,
    this.userId,
  });

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  int? indexSelected;
  List<String> tvApp = [
    AppTexts.tvGoogleSearch,
    AppTexts.tvVlog,
    AppTexts.tvYouTube,
    AppTexts.tvTiktok,
    AppTexts.tvTV,
    AppTexts.tvInstagram,
  ];

  List<String> imgApp = [
    AppImages.imgGoogle,
    AppImages.imgNewspaper,
    AppImages.imgTiktok,
    AppImages.imgYoutube,
    AppImages.imgTV,
    AppImages.imgInstagram,
  ];

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
                value: widget.progress,
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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AppTooltip(
            message: AppTexts.tvPageFourTitle,
            widget: Image.asset(AppImages.imgIntro),
            arrowDirection: true,
            distanceLeft: size.width / 4 + 20,
            distanceTop: 30,
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: tvApp.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemBuilder: (context, index) {
                final icon = imgApp[index];
                final title = tvApp[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      indexSelected = index;
                    });
                  },
                  child: ItemView(
                    leading: Image.asset(icon),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    isSelected: (index == indexSelected),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _button() {
    return BaseButton(
      onPressed: () {
        if (indexSelected != null) {
          AppRoute.pushLeftToRight(
            context,
            PageFive(
              progress: 0.8,
              userId: widget.userId,
            ),
          );
        }
      },
      backgroundColor:
          (indexSelected == null) ? AppColors.unselect : AppColors.secondColor,
      checkBorder: (indexSelected == null) ? false : true,
      widget: Text(
        AppTexts.tvContinue.toUpperCase(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: (indexSelected == null)
              ? AppColors.textSecondColor
              : AppColors.background,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(size),
      body: _body(size),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _button(),
      ),
    );
  }
}
