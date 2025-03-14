import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FooterWidget extends StatelessWidget {
  final bool? userExist;
  const FooterWidget({
    super.key,
    this.userExist,
  });

  Widget _textOr() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            height: 1,
            color: AppColors.textSecondColor.withOpacity(.5),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          AppTexts.tvOr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Divider(
            height: 1,
            color: AppColors.textSecondColor.withOpacity(.5),
          ),
        ),
      ],
    );
  }

  Widget _button(Widget widget, bool checkIcon) {
    return BaseButton(
      onPressed: () {},
      backgroundColor: AppColors.background,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (checkIcon)
              ? SvgPicture.asset(AppVectors.icFacebook)
              : SvgPicture.asset(AppVectors.icGoogle),
          const SizedBox(
            width: 8,
          ),
          widget,
        ],
      ),
      checkBorder: true,
    );
  }

  Widget _textFaceOrGG(String title, bool checkIcon) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: checkIcon ? const Color(0xff5A678D) : AppColors.textSecondColor,
      ),
    );
  }

  Widget _signInOr() {
    return Row(
      children: [
        Expanded(
          child: _button(
            _textFaceOrGG(AppTexts.tvFacebook, true),
            true,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: _button(
            _textFaceOrGG(AppTexts.tvGoogle, false),
            false,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (userExist == false) ? _textOr() : const SizedBox(),
          (userExist == false) ? const SizedBox(height: 16) : const SizedBox(),
          (userExist == false) ? _signInOr() : const SizedBox(),
          (userExist == false) ? const SizedBox(height: 32) : const SizedBox(),
        ],
      ),
    );
  }
}
