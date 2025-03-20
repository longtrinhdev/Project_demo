import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RankItem extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool? checkUser;
  const RankItem({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.checkUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return (checkUser == true)
        ? Container(
            color: AppColors.textThirdColor.withOpacity(.3),
            child: ListTile(
              leading: leading,
              title: title,
              trailing: trailing,
            ),
          )
        : ListTile(
            leading: leading,
            title: title,
            trailing: trailing,
          );
  }
}
