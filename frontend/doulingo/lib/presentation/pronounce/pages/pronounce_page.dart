import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/widget/failed_page/failed_page.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/domain/pronounce/entities/pronounce.dart';
import 'package:doulingo/domain/pronounce/use_case/get_all_use_case.dart';
import 'package:doulingo/presentation/pronounce/widgets/pronounce_item.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PronouncePage extends StatefulWidget {
  final String idCourse;
  const PronouncePage({
    super.key,
    required this.idCourse,
  });

  @override
  State<PronouncePage> createState() => _PronouncePageState();
}

class _PronouncePageState extends State<PronouncePage> {
  Widget _success(Size size, List<PronounceEntity> list) {
    List<PronounceEntity> vowels = list.sublist(0, 15);
    //List<PronounceEntity> consonants = list.sublist(15, 39);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              _text(
                24,
                AppTexts.tvPronounceTitle,
                FontWeight.w900,
                AppColors.textColor,
              ),
              const SizedBox(
                height: 16,
              ),
              _text(
                18,
                AppTexts.tvPronounceIntro,
                FontWeight.w700,
                AppColors.textColor.withOpacity(.5),
              ),
              ...List.generate(
                1,
                (index) => Expanded(
                  child: PronounceItem(list: vowels),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _text(double fontSize, String message, FontWeight fw, Color color) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fw,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => GenerateDataCubit()
        ..getData<List<PronounceEntity>>(
          sl<GetAllPronounceUseCase>(),
          params: widget.idCourse,
        ),
      child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const AppLoading();
          }
          if (state is DataLoaded) {
            List<PronounceEntity> pronounceEntities = state.data;
            return _success(size, pronounceEntities);
          }
          return const FailedPage();
        },
      ),
    );
  }
}
