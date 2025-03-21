import 'package:doulingo/common/widget/divider/app_divider.dart';
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
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: RankHeaderWidget(),
            ),
            SizedBox(
              height: 16,
            ),
            AppDivider(),
            Expanded(
              child: RankBodyWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
