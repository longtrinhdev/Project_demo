import 'package:doulingo/common/widget/item_view/item_view.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                return Container(
                  width: 72,
                  height: 64,
                  margin: const EdgeInsets.all(8.0),
                  child: ItemView(
                    isSelected: false,
                    backgroundColor: AppColors.background,
                    title: _body(pronounceEntity),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
