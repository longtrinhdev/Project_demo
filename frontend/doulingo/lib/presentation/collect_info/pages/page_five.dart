import 'dart:developer';

import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/local_data/use_case/set_data_use_case.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/item_view/item_view.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/collect_info/pages/page_six.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';

class PageFive extends StatefulWidget {
  final double progress;
  const PageFive({
    super.key,
    required this.progress,
  });

  @override
  State<PageFive> createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  int? isSelected;

  List<String> lstIcon = [
    AppImages.imgFriend,
    AppImages.imgBrain,
    AppImages.imgBag,
    AppImages.imgPlane,
    AppImages.imgBook,
    AppImages.imgCongratulation,
  ];

  List<String> lstTitle = [
    'Kết nối với mọi người',
    'Sử dụng thời gian hiệu quả',
    'Phát triển sự nghiệp',
    'Chuẩn bị đi du lịch',
    'Hỗ trợ việc học tập',
    'Giải trí',
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

  Widget _button(String bio) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BaseButton(
        onPressed: () async {
          sl<SetDataUseCase>().call(
            params: SharedReq(key: 'bio', value: bio),
          );
          log('Bio: $bio');
          if (isSelected != null) {
            AppRoute.push(
              context,
              const PageSix(progress: 0.9),
            );
          }
        },
        backgroundColor:
            (isSelected == null) ? AppColors.unselect : AppColors.secondColor,
        checkBorder: (isSelected == null) ? false : true,
        widget: Text(
          AppTexts.tvContinue,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: (isSelected == null)
                ? AppColors.textSecondColor
                : AppColors.background,
          ),
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
            message: AppTexts.tvPageFiveTitle,
            widget: Image.asset(AppImages.imgIntro),
            distanceLeft: size.width / 4 + 20,
            distanceTop: 30,
            arrowDirection: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: lstIcon.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemBuilder: (context, index) {
                final icon = lstIcon[index];
                final title = lstTitle[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = index;
                    });
                  },
                  child: ItemView(
                    leading: Image.asset(icon),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textColor,
                      ),
                    ),
                    isSelected: (isSelected == index),
                  ),
                );
              },
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
      appBar: _appBar(size),
      body: _body(size),
      bottomNavigationBar: _button(lstTitle[isSelected ?? 0]),
    );
  }
}
