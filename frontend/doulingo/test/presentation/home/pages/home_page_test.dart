import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/chapter/entities/chapter.dart';
import 'package:doulingo/domain/chapter/use_case/get_all_chapter.dart';
import 'package:doulingo/presentation/home/pages/home_page.dart';
import 'package:doulingo/presentation/home/widgets/chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockGetAllChapterUC extends Mock implements GetAllChapterUseCase {}

void main() {
  final locator = GetIt.instance;
  late MockGetAllChapterUC getAllChapterUC;
  String? courseId;
  String? courseName;

  setUp(() {
    courseId = '123456';
    courseName = 'Flutter Course';
    getAllChapterUC = MockGetAllChapterUC();
    locator.registerLazySingleton<GetAllChapterUseCase>(() => getAllChapterUC);
  });

  tearDown(() {
    locator.reset();
  });

  testWidgets('UI: Chapter Page', (tester) async {
    final lst = [
      ChapterEntity(
        avatar: 'https://example.com/eng.svg',
        color: '0xff000000',
        title: 'Chapter 1',
        courseId: '',
        id: '',
        isCompleted: true,
        isUnlocked: false,
        name: 'Flutter Course',
        sectionIds: [''],
      ),
    ];

    await mockNetworkImages(() async {
      when(
        () => getAllChapterUC.call(
          params: any(named: 'params'),
        ),
      ).thenAnswer(
        (_) async => Right(lst),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            courseId: courseId,
            courseName: courseName,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ChaptersWidget), findsOneWidget);
    });
  });
}
