import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/presentation/rank/widgets/rank_body.dart';
import 'package:doulingo/presentation/rank/widgets/rank_header.dart';
import 'package:flutter/material.dart';

class RankPage extends StatelessWidget {
  const RankPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: RankHeaderWidget(),
            ),
            const SizedBox(
              height: 16,
            ),
            _divider(),
            const Expanded(
              child: RankBodyWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      thickness: 2,
      color: AppColors.unselect,
    );
  }
}
