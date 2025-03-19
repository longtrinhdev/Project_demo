import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ItemView extends StatefulWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool isSelected;
  final Color? backgroundColor;
  final VoidCallback? callback;
  const ItemView({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.backgroundColor,
    required this.isSelected,
    this.callback,
  });

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.callback ?? () {},
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: (widget.isSelected == true)
              ? AppColors.textThirdColor.withOpacity(.2)
              : (widget.backgroundColor != null)
                  ? widget.backgroundColor
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
        child: (widget.leading == null && widget.trailing == null)
            ? widget.title
            : ListTile(
                leading: widget.leading,
                title: widget.title ?? const SizedBox(),
                trailing: widget.trailing,
              ),
      ),
    );
  }
}
