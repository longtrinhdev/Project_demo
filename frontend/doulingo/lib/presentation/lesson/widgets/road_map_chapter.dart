import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/failed_page/failed_page.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/domain/chapter/entities/chapter.dart';
import 'package:doulingo/domain/chapter/use_case/get_chapter_by_id.dart';
import 'package:doulingo/presentation/lesson/widgets/circle_button.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RoadMapChapter extends StatelessWidget {
  final String chapterId;
  const RoadMapChapter({
    super.key,
    required this.chapterId,
  });

  Widget _header(String title, String chapterName, Color color) {
    return BaseButton(
      onPressed: () {},
      height: 80,
      checkBorder: true,
      backgroundColor: color,
      widget: Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chapterName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondBackground,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColors.background,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 1.5,
            color: AppColors.textColor.withOpacity(.4),
          ),
          const SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SvgPicture.asset(AppVectors.icList),
          ),
        ],
      ),
    );
  }

  Widget _body(Size size, ChapterEntity chapter) {
    final title = chapter.title!;
    final chapterName = chapter.name!;
    Color color = Color(int.parse(chapter.color!));
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          _header(title, chapterName, color),
          _positionedWidget(
            size.height / 6,
            size.width / 3,
            null,
            null,
            AppVectors.icStar,
            color,
          ),
          _positionedWidget(
            size.height / 3.5 + 30,
            size.width / 2,
            null,
            null,
            AppVectors.icBook,
            AppColors.textColor.withOpacity(.9),
          ),
          _positionedWidget(
            size.height / 2.5 + 50,
            size.width / 3,
            null,
            null,
            AppVectors.icStarGrey,
            AppColors.textColor.withOpacity(.9),
          ),
          _positionedWidget(
            size.height / 1.5 - 50,
            size.width / 5,
            null,
            null,
            AppVectors.icDumbbellGrey,
            AppColors.textColor.withOpacity(.9),
          ),
          _positionedWidget(
            null,
            size.width / 3,
            10,
            null,
            AppVectors.icAward,
            AppColors.textColor.withOpacity(.9),
          ),
        ],
      ),
    );
  }

  Widget _positionedWidget(double? top, double? left, double? bottom,
      double? right, String image, Color color) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: CircleButton(
        color: color,
        image: image,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => GenerateDataCubit()
        ..getData<ChapterEntity>(sl<GetChapterById>(), params: chapterId),
      child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const AppLoading();
          }
          if (state is DataLoaded) {
            ChapterEntity chapter = state.data;
            return _body(size, chapter);
          }
          return const FailedPage();
        },
      ),
    );
  }
}
