import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/snack_bar/custom_snackbar.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/domain/auth/entities/user.dart';
import 'package:doulingo/domain/auth/use_case/google_signin_uc.dart';
import 'package:doulingo/presentation/collect_info/pages/page_three.dart';
import 'package:doulingo/presentation/main/pages/main_page.dart';
import 'package:doulingo/service_locators.dart';
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

  Widget _button(BuildContext context, Widget widget, bool checkIcon) {
    return BaseButton(
      onPressed: (checkIcon == true)
          ? () {}
          : () async {
              _signGoogleOrFace(context, false);
            },
      backgroundColor: AppColors.background,
      widget: _initial(checkIcon, widget),
      checkBorder: true,
    );
  }

  Widget _initial(bool checkIcon, Widget widget) {
    return Row(
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

  Widget _signInOr(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _button(
            context,
            _textFaceOrGG(AppTexts.tvFacebook, true),
            true,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: _button(
            context,
            _textFaceOrGG(AppTexts.tvGoogle, false),
            false,
          ),
        ),
      ],
    );
  }

  _showSnackBar(BuildContext context, String message) {
    return CustomSnackbar.show(
      context,
      AppImages.imgCancel,
      message,
      AppColors.background,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (userExist == false) ? _textOr() : const SizedBox(),
          (userExist == false) ? const SizedBox(height: 16) : const SizedBox(),
          (userExist == false) ? _signInOr(context) : const SizedBox(),
          (userExist == false) ? const SizedBox(height: 32) : const SizedBox(),
        ],
      ),
    );
  }

  _signGoogleOrFace(BuildContext context, bool isFace) async {
    final responseData = (isFace)
        ? await sl<GoogleSigninUc>().call()
        : await sl<GoogleSigninUc>().call();

    responseData.fold(
      (error) {
        _showSnackBar(
          context,
          error,
        );
      },
      (data) async {
        final user = data as UserEntity;
        if (user.courseId!.isEmpty) {
          AppRoute.pushLeftToRight(
            context,
            ChooseLanguage(
              userId: user.id,
            ),
          );
          return;
        }
        if (context.mounted && user.courseId!.isNotEmpty) {
          AppRoute.pushAndRemoveLeftToRight(
            context,
            MainPage(
              score: 0,
              courseId: user.courseId![0],
            ),
          );
        }
      },
    );
  }
}
