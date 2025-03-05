import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTooltip extends StatelessWidget {
  final String message;
  final Widget widget;
  final double distanceLeft;
  final double distanceTop;
  final bool arrowDirection;
  const AppTooltip({
    super.key,
    required this.message,
    required this.widget,
    required this.distanceLeft,
    required this.distanceTop,
    this.arrowDirection = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (arrowDirection)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget,
            ],
          )
        else
          Center(
            child: widget,
          ),
        Positioned(
          top: distanceTop,
          left: distanceLeft,
          child: TooltipWidget(
            message: message,
            arrowDirection: arrowDirection,
          ),
        ),
      ],
    );
  }
}

class TooltipWidget extends StatelessWidget {
  final String message;
  final bool arrowDirection;
  const TooltipWidget({
    super.key,
    required this.message,
    this.arrowDirection = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          color: AppColors.textSecondColor.withOpacity(.3),
          shape: ToolTipCustomShape(
            arrowDirection: arrowDirection,
          ),
        ),
        child: Text(
          message,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.textColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class ToolTipCustomShape extends ShapeBorder {
  final bool usePadding;
  final bool arrowDirection;
  const ToolTipCustomShape({
    this.usePadding = true,
    this.arrowDirection = false,
  });

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const double arrowWidth = 20;
    const double arrowHeight = 10;
    const double radius = 10;

    rect =
        Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 20));
    return (arrowDirection)
        ? topLeftPath(rect, radius, arrowHeight, arrowWidth)
        : bottomCenterPath(rect, radius, arrowHeight, arrowWidth);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}

Path topLeftPath(
    Rect rect, double radius, double arrowHeight, double arrowWidth) {
  return Path()
    ..moveTo(rect.left + radius + arrowHeight, rect.top)
    ..lineTo(rect.right - radius, rect.top)
    ..arcToPoint(
      Offset(rect.right, rect.top + radius),
      radius: Radius.circular(radius),
    )
    ..lineTo(rect.right, rect.bottom - radius)
    ..arcToPoint(
      Offset(rect.right - radius, rect.bottom),
      radius: Radius.circular(radius),
    )
    ..lineTo(rect.left + radius + arrowHeight, rect.bottom)
    ..arcToPoint(
      Offset(rect.left + arrowHeight, rect.bottom - radius),
      radius: Radius.circular(radius),
    )
    ..lineTo(rect.left + arrowHeight, rect.center.dy + arrowWidth / 2)
    ..lineTo(rect.left, rect.center.dy)
    ..lineTo(rect.left + arrowHeight, rect.center.dy - arrowWidth / 2)
    ..lineTo(rect.left + arrowHeight, rect.top + radius)
    ..arcToPoint(
      Offset(rect.left + radius + arrowHeight, rect.top),
      radius: Radius.circular(radius),
    )
    ..close();
}

Path bottomCenterPath(
    Rect rect, double radius, double arrowHeight, double arrowWidth) {
  return Path()
    ..moveTo(rect.left + radius, rect.top)
    ..lineTo(rect.right - radius, rect.top)
    ..arcToPoint(
      Offset(rect.right, rect.top + radius),
      radius: Radius.circular(radius),
    )
    ..lineTo(rect.right, rect.bottom - radius - arrowHeight)
    ..arcToPoint(
      Offset(rect.right - radius, rect.bottom - arrowHeight),
      radius: Radius.circular(radius),
    )
    ..lineTo(rect.center.dx + arrowWidth / 2, rect.bottom - arrowHeight)
    ..lineTo(rect.center.dx, rect.bottom)
    ..lineTo(rect.center.dx - arrowWidth / 2, rect.bottom - arrowHeight)
    ..lineTo(rect.left + radius, rect.bottom - arrowHeight)
    ..arcToPoint(
      Offset(rect.left, rect.bottom - radius - arrowHeight),
      radius: Radius.circular(radius),
    )
    ..lineTo(rect.left, rect.top + radius)
    ..arcToPoint(
      Offset(rect.left + radius, rect.top),
      radius: Radius.circular(radius),
    )
    ..close();
}
