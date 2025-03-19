import 'package:doulingo/core/config/theme/app_colors.dart';
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
          FontWeight.w800,
          AppColors.textColor,
        ),
        const SizedBox(
          height: 4,
        ),
        _text(
          18,
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
        fontFamilyFallback: const ['Arial'],
      ),
    );
  }

  Widget _item(Size size, PronounceEntity pronounceEntity) {
    return Container(
      width: size.width / 3.5,
      height: 104,
      padding: const EdgeInsets.all(6.0),
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
    List<Widget> listItem = <Widget>[];

    for (int i = 0; i < list.length; i++) {
      final pronounceEntity = list[i];
      listItem.add(_item(size, pronounceEntity));
    }
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: listItem,
    );
  }
}
