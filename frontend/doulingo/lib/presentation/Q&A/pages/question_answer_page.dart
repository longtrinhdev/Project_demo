import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/presentation/Q&A/widgets/bottom_button.dart';
import 'package:flutter/material.dart';

class QuestionAnswerPage extends StatefulWidget {
  const QuestionAnswerPage({super.key});

  @override
  State<QuestionAnswerPage> createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {
  double _value = 0.0;

  PreferredSizeWidget _appBar(Size size) {
    return AppbarBase(
      backgroundColor: AppColors.background,
      title: SizedBox(
        width: size.width,
        height: 16,
        child: LinearProgressIndicator(
          backgroundColor: AppColors.unselect,
          borderRadius: BorderRadius.circular(16),
          color: AppColors.secondColor,
          value: _value,
        ),
      ),
    );
  }

  _onUpdateValue(double value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(size),
      bottomNavigationBar: BottomButtonWidget(
        size: size,
        value: _value,
        onValueChanged: (value) => _onUpdateValue(value),
      ),
    );
  }
}

//percent_indicator
