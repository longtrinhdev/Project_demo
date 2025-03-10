import 'package:flutter/material.dart';

Color borderColor(Color color, double factor) {
  return HSLColor.fromColor(color)
      .withLightness(
          (HSLColor.fromColor(color).lightness - factor).clamp(0.0, 1.0))
      .toColor();
}
