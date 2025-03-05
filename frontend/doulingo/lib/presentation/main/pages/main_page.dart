import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/presentation/home/pages/home_page.dart';
import 'package:doulingo/presentation/practice/pages/practice_page.dart';
import 'package:doulingo/presentation/profile/pages/profile_page.dart';
import 'package:doulingo/presentation/pronounce/pages/pronounce_page.dart';
import 'package:doulingo/presentation/rank/pages/rank_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  final List<String>? learnDays;
  final num? score;
  final String courseId;
  const MainPage({
    super.key,
    this.learnDays,
    required this.score,
    required this.courseId,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int? indexSelected = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget _bottom(Size size) {
    return Container(
      width: size.width,
      height: 100,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2,
            color: AppColors.textSecondColor.withOpacity(.5),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _itemBottomNav(AppVectors.icHome, 0),
              _itemBottomNav(AppVectors.icMouth, 1),
              _itemBottomNav(AppVectors.icDumbbell, 2),
              _itemBottomNav(AppVectors.icRank, 3),
              _itemBottomNav(AppVectors.icProfile, 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemBottomNav(String image, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          indexSelected = index;
        });
        _pageController.jumpToPage(index);
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: (indexSelected == index)
            ? BoxDecoration(
                color: AppColors.textThirdColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: AppColors.textThirdColor.withOpacity(.4),
                ),
              )
            : null,
        child: SvgPicture.asset(
          image,
          width: 36,
          height: 36,
        ),
      ),
    );
  }

  Widget _pageView() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomePage(
          courseId: widget.courseId,
          learnDays: widget.learnDays,
          score: widget.score,
        ),
        const PronouncePage(),
        const PracticePage(),
        const RankPage(),
        const ProfilePage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: _pageView(),
      bottomNavigationBar: _bottom(size),
    );
  }
}
