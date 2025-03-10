import 'package:doulingo/presentation/home/widgets/chapters.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? courseId;
  final String? courseName;
  const HomePage({
    super.key,
    required this.courseId,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ChaptersWidget(
          courseId: courseId!,
          courseTitle: courseName!,
        ),
      ),
    );
  }
}
