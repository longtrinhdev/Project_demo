import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/presentation/home/widgets/show_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  final String? courseId;
  final List<String>? learnDays;
  final num? score;
  const HomePage({
    super.key,
    required this.courseId,
    required this.learnDays,
    required this.score,
  });

  PreferredSizeWidget _appBar(Size size, String streak) {
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
                _itemTopBar(AppVectors.icFire, streak, const Color(0xffEE9623)),
                _itemTopBar(
                    AppVectors.icScore, '$score', AppColors.textThirdColor),
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final streak = learnDays!.length.toString();
    return Scaffold(
      appBar: _appBar(size, streak),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const ShowCourse(),
      ),
    );
  }
}
