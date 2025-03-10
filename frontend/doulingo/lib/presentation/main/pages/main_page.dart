import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/domain/languages/entities/language.dart';
import 'package:doulingo/domain/languages/usecase/get_language.dart';
import 'package:doulingo/presentation/home/pages/home_page.dart';
import 'package:doulingo/presentation/practice/pages/practice_page.dart';
import 'package:doulingo/presentation/profile/pages/profile_page.dart';
import 'package:doulingo/presentation/pronounce/pages/pronounce_page.dart';
import 'package:doulingo/presentation/rank/pages/rank_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  PreferredSizeWidget _appBar(Size size, String imageCourse) {
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
                  imageCourse,
                  width: 27,
                  height: 27,
                ),
                _itemTopBar(AppVectors.icFire, '${widget.learnDays!.length}',
                    AppColors.colorStreak),
                _itemTopBar(AppVectors.icScore, '${widget.score}',
                    AppColors.textThirdColor),
                _itemTopBar(AppVectors.icHeart, '5', AppColors.colorHeart),
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

  Widget _pageView(String courseName) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        HomePage(
          courseName: courseName,
          courseId: widget.courseId,
        ),
        PronouncePage(
          idCourse: widget.courseId,
        ),
        const PracticePage(),
        const RankPage(),
        const ProfilePage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GenerateDataCubit()
        ..getData<LanguageEntity>(sl<GetLanguageUseCase>(),
            params: widget.courseId),
      child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const AppLoading();
          }
          if (state is DataLoaded) {
            LanguageEntity language = state.data;
            return Scaffold(
              appBar: (indexSelected != 3 && indexSelected != 4)
                  ? _appBar(size, language.image!)
                  : null,
              body: _pageView(language.language!),
              bottomNavigationBar: _bottom(size),
            );
          }
          return Container();
        },
      ),
    );
  }
}
