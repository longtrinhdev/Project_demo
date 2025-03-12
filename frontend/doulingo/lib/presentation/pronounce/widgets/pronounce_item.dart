import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/domain/pronounce/entities/pronounce.dart';
import 'package:flutter/material.dart';

class PronounceItem extends StatelessWidget {
  final List<PronounceEntity> list;
  const PronounceItem({
    super.key,
    required this.list,
  });

  Widget _body(PronounceEntity pronounceEntity) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _text(
          20,
          pronounceEntity.word!,
          FontWeight.w600,
          AppColors.textColor,
        ),
        const SizedBox(
          height: 4,
        ),
        _text(
          19,
          pronounceEntity.example!,
          FontWeight.w800,
          AppColors.textSecondColor,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
          child: LinearProgressIndicator(
            borderRadius: BorderRadius.circular(16.0),
            backgroundColor: AppColors.unselect,
            color: AppColors.secondColor,
            value: 0,
          ),
        ),
      ],
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

  Widget _divider(String message) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.textSecondColor.withOpacity(.5),
            thickness: 2,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        _text(
          21,
          message,
          FontWeight.w900,
          AppColors.textColor.withOpacity(.9),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Divider(
            color: AppColors.textSecondColor.withOpacity(.5),
            thickness: 2,
          ),
        ),
      ],
    );
  }

  Widget _item(Size size, PronounceEntity pronounceEntity) {
    return Container(
      width: size.width / 5,
      height: 64,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.background,
        border: const Border(
          bottom: BorderSide(
            color: AppColors.unselect,
            width: 4,
          ),
          top: BorderSide(
            color: AppColors.unselect,
            width: 1.5,
          ),
          left: BorderSide(
            color: AppColors.unselect,
            width: 1.5,
          ),
          right: BorderSide(
            color: AppColors.unselect,
            width: 1.5,
          ),
        ),
      ),
      child: _body(pronounceEntity),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          _divider(AppTexts.tvVowel),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1),
              itemBuilder: (context, index) {
                final pronounceEntity = list[index];
                return _item(size, pronounceEntity);
              },
            ),
          ),
        ],
      ),
    );
  }
}
