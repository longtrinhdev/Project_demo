import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ItemView extends StatefulWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool isSelected;
  const ItemView({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    required this.isSelected,
  });

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: (widget.isSelected == true)
            ? AppColors.textThirdColor.withOpacity(.2)
            : null,
        border: Border(
            bottom: BorderSide(
              width: 4,
              color: (widget.isSelected == false)
                  ? AppColors.textSecondColor.withOpacity(.3)
                  : AppColors.select.withOpacity(.3),
            ),
            top: BorderSide(
              width: 1.5,
              color: (widget.isSelected == false)
                  ? AppColors.textSecondColor.withOpacity(.3)
                  : AppColors.select.withOpacity(.3),
            ),
            left: BorderSide(
              width: 2,
              color: (widget.isSelected == false)
                  ? AppColors.textSecondColor.withOpacity(.3)
                  : AppColors.select.withOpacity(.3),
            ),
            right: BorderSide(
              width: 2,
              color: (widget.isSelected == false)
                  ? AppColors.textSecondColor.withOpacity(.3)
                  : AppColors.select.withOpacity(.3),
            )),
      ),
      child: ListTile(
        leading: widget.leading ?? const SizedBox(),
        title: widget.title ?? const SizedBox(),
        trailing: widget.trailing ?? const SizedBox(),
      ),
    );
  }
}
