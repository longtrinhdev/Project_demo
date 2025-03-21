import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/failed_page/failed_page.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/domain/section/entities/section.dart';
import 'package:doulingo/domain/section/use_case/get_all_use_case.dart';
import 'package:doulingo/presentation/lesson/widgets/chapter_bar.dart';
import 'package:doulingo/presentation/lesson/widgets/road_map_chapter.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonPages extends StatefulWidget {
  final String title;
  final String chapterId;
  final String nameChapter;
  const LessonPages({
    super.key,
    required this.title,
    required this.chapterId,
    required this.nameChapter,
  });

  @override
  State<LessonPages> createState() => _LessonPagesState();
}

class _LessonPagesState extends State<LessonPages> {
  int _currentIndexSection = 0;
  final _heightSizeBox = 64.0;
  final double heightScreen = 764.0;
  final double distance = 300;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    final currentScroll =
        _scrollController.position.pixels - _heightSizeBox - distance;
    int index = (currentScroll / heightScreen).floor();
    if (index < 0) {
      index = 0;
    } else {
      index += 1;
    }
    if (index != _currentIndexSection) {
      setState(() {
        _currentIndexSection = index;
      });
    }
  }

  PreferredSizeWidget _appBar() {
    return AppbarBase(
      backgroundColor: AppColors.background,
      title: TextViewShow(
        text: '${AppTexts.tvLessonTitle}${widget.title}',
        size: 21,
        fw: FontWeight.w900,
        color: AppColors.textColor,
      ),
    );
  }

  Widget _buildSuccess(List<SectionEntity> lst) {
    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: [
          ListView.separated(
            controller: _scrollController,
            itemBuilder: (_, i) => (i == 0)
                ? SizedBox(
                    height: _heightSizeBox,
                  )
                : RoadMapChapter(
                    data: lst[i - 1],
                  ),
            itemCount: lst.length + 1,
            separatorBuilder: (context, index) => const SizedBox(
              height: 24.0,
            ),
          ),
          ChapterBar(
            data: lst[_currentIndexSection],
            nameChapter: widget.nameChapter,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenerateDataCubit()
        ..getData<List<SectionEntity>>(sl<GetAllUseCase>(),
            params: widget.chapterId),
      child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const AppLoading();
          } else if (state is DataLoaded) {
            final List<SectionEntity> lst = state.data;
            return _buildSuccess(lst);
          }
          return const FailedPage();
        },
      ),
    );
  }
}
