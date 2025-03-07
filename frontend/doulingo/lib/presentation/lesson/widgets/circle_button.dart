import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleButton extends StatelessWidget {
  final String image;
  final VoidCallback callback;
  final Color color;
  final int index;
  const CircleButton({
    super.key,
    required this.image,
    required this.callback,
    required this.color,
    required this.index,
  });

  Color _borderColor(Color color, double factor) {
    return HSLColor.fromColor(color)
        .withLightness(
            (HSLColor.fromColor(color).lightness - factor).clamp(0.0, 1.0))
        .toColor();
  }

  double _marginLeft(int index) {
    int pos = index % 9;
    double margin = 72.0;
    if (pos == 1) {
      return margin;
    } else if (pos == 2) {
      return margin * 2;
    } else if (pos == 3) {
      return margin;
    } else {
      return 0.0;
    }
  }

  double _marginRight(int index) {
    int pos = index % 9;
    double margin = 72.0;
    if (pos == 5) {
      return margin;
    } else if (pos == 6) {
      return margin * 2;
    } else if (pos == 7) {
      return margin;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 24,
        left: _marginLeft(index),
        right: _marginRight(index),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        border: Border(
          bottom: BorderSide(
            width: 6,
            color: _borderColor(color, .1),
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(66, 58),
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          backgroundColor: color,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
        ),
        child: SvgPicture.asset(image),
      ),
    );
  }
}
