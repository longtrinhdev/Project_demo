import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleButton extends StatelessWidget {
  final Color color;
  final String image;
  const CircleButton({
    super.key,
    required this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 6),
            color: color.withOpacity(.5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: SvgPicture.asset(image),
    );
  }
}
