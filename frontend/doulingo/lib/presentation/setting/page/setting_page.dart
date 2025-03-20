import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text(
              AppTexts.tvAccount,
              20,
              FontWeight.w800,
              AppColors.textColor.withOpacity(.8),
            ),
            const SizedBox(
              height: 8,
            ),
            _groupItem(_account()),
            const SizedBox(
              height: 32,
            ),
            _text(
              AppTexts.tvSupportTitle,
              20,
              FontWeight.w800,
              AppColors.textColor.withOpacity(.8),
            ),
            const SizedBox(
              height: 12,
            ),
            _groupItem(
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: _item(AppTexts.tvSupport, () {}),
              ),
            ),
            const Spacer(),
            BaseButton(
              onPressed: () {
                AppRoute.pop(context);
              },
              backgroundColor: AppColors.background,
              checkBorder: true,
              widget: _text(
                AppTexts.btnBack.toUpperCase(),
                18,
                FontWeight.w800,
                AppColors.textThirdColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppbarBase(
      backgroundColor: AppColors.background,
      hideBack: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 8,
          ),
          _text(
            AppTexts.tvSettingTitle,
            20,
            FontWeight.w800,
            AppColors.textColor.withOpacity(.8),
          ),
          const SizedBox(
            height: 12,
          ),
          _divider(),
        ],
      ),
    );
  }

  Widget _text(String text, double fs, FontWeight fw, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fs,
        fontWeight: fw,
        color: color,
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: AppColors.unselect,
      thickness: 1.5,
    );
  }

  Widget _groupItem(Widget widget) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondBackground.withOpacity(.5),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.unselect,
          width: 2,
        ),
      ),
      child: widget,
    );
  }

  Widget _account() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _item(AppTexts.tvFile, () {}),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _item(AppTexts.tvNotification, () {}),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _item(AppTexts.tvCourse, () {}),
        ),
        _divider(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _item(AppTexts.tvSocial, () {}),
        ),
      ],
    );
  }

  Widget _item(String message, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _text(message, 20, FontWeight.w900, AppColors.textColor),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textSecondColor,
          ),
        ],
      ),
    );
  }
}
