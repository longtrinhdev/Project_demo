import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/presentation/setting/page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 300,
      color: AppColors.textThirdColor.withOpacity(.2),
      child: Stack(
        children: [
          Positioned(
            bottom: -64,
            child: _avatar(width),
          ),
          Positioned(
            top: 48,
            right: 20,
            child: _setting(context),
          ),
        ],
      ),
    );
  }

  Widget _avatar(double width) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: width,
        alignment: Alignment.bottomCenter,
        child: SvgPicture.asset(AppVectors.icAvatarDf),
      ),
    );
  }

  Widget _setting(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRoute.pushBottomToTop(
          context,
          const SettingPage(),
        );
      },
      child: SvgPicture.asset(
        AppVectors.icSetting,
        width: 28,
        // ignore: deprecated_member_use
        color: AppColors.textColor.withOpacity(.8),
      ),
    );
  }
}
