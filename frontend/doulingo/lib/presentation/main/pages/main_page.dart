import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String indexSelected = AppVectors.icHome;

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
              _itemBottomNav(AppVectors.icHome),
              _itemBottomNav(AppVectors.icMouth),
              _itemBottomNav(AppVectors.icDumbbell),
              _itemBottomNav(AppVectors.icRank),
              _itemBottomNav(AppVectors.icProfile),
            ],
          ),
        ],
      ),
    );
  }

  Widget _itemBottomNav(String image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          indexSelected = image;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: (indexSelected == image)
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: const HomePage(),
      bottomNavigationBar: _bottom(size),
    );
  }
}
