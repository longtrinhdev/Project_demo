import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BottomButtonWidget extends StatefulWidget {
  final Size size;
  final double value;
  final Function(double) onValueChanged;
  const BottomButtonWidget({
    super.key,
    required this.size,
    required this.onValueChanged,
    required this.value,
  });

  @override
  State<BottomButtonWidget> createState() => _BottomButtonWidgetState();
}

class _BottomButtonWidgetState extends State<BottomButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: 120,
      padding: const EdgeInsets.all(16.0),
      color: AppColors.background,
      child: BaseButton(
        onPressed: () {
          double vl = widget.value + 0.2;
          widget.onValueChanged(vl);
        },
        backgroundColor: AppColors.secondColor,
      ),
    );
  }
}
