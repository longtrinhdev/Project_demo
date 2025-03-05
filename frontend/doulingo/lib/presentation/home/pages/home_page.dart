import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  PreferredSizeWidget _appBar(Size size) {
    return AppbarBase(
      backgroundColor: AppColors.background,
      hideBack: true,
      action: SizedBox(
        width: size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.network(
                  'https://d35aaqx5ub95lt.cloudfront.net/vendor/bbe17e16aa4a106032d8e3521eaed13e.svg',
                  width: 27,
                  height: 27,
                ),
                _itemTopBar(AppVectors.icFire, '10', const Color(0xffEE9623)),
                _itemTopBar(
                    AppVectors.icScore, '120', AppColors.textThirdColor),
                _itemTopBar(AppVectors.icHeart, '5', const Color(0xffE45457)),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemTopBar(String icon, String title, Color color) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 27,
          height: 27,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        )
      ],
    );
  }

  Widget _statusBar(Size size) {
    return BaseButton(
      onPressed: () {},
      backgroundColor: const Color(0xffFE951F),
      checkBorder: true,
      height: 72,
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CHƯƠNG 2',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondBackground,
                  ),
                ),
                Text(
                  'Mua sắm ở cửa hàng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.background,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 2,
              color: AppColors.textColor.withOpacity(.3),
            ),
            const SizedBox(
              width: 12,
            ),
            SvgPicture.asset(
              AppVectors.icList,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(size),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            _statusBar(size),
          ],
        ),
      ),
    );
  }
}
