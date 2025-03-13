import 'package:dartz/dartz.dart';
import 'package:doulingo/data/chapter/repository/chapter_repo_impl.dart';
import 'package:doulingo/data/chapter/sources/chapter_service.dart';
import 'package:doulingo/domain/chapter/repository/chapter_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockChapterService extends Mock implements ChapterService {}

void main() {
  late MockChapterService mockChapterService;
  late ChapterRepo chapterRepo;
  final locator = GetIt.instance;

  setUp(() {
    mockChapterService = MockChapterService();
    chapterRepo = ChapterRepoImpl();
    locator.registerLazySingleton<ChapterService>(() => mockChapterService);
  });
  tearDown(() {
    locator.reset();
  });

  group('Get All Chapter', () {
    const idCourse = '123456';
    final mockData = [
      {
        'id': '1',
        'title': 'Chapter 1',
        'avatar': 'http://12345',
        'color': '',
        'courseId': '',
        'isCompleted': false,
        'isUnlocked': false,
        'name': 'pilong',
        'sectionIds': [''],
      },
    ];

    test('Case: Success', () async {
      when(
        () => mockChapterService.getAllChapter(idCourse),
      ).thenAnswer(
        (_) async => Right(mockData),
      );

      final result = await chapterRepo.getAllChapter(idCourse);

      expect(result, isA<Right>());
      verify(() => mockChapterService.getAllChapter(idCourse)).called(1);
    });

    test('Case: Failure', () async {
      when(
        () => mockChapterService.getAllChapter(idCourse),
      ).thenAnswer(
        (_) async => Left(mockData),
      );

      final result = await chapterRepo.getAllChapter(idCourse);

      expect(result, isA<Left>());
      verify(() => mockChapterService.getAllChapter(idCourse)).called(1);
    });
  });

  group('Get Chapter By Id', () {
    final mockData = {
      'id': '1',
      'title': 'Chapter 1',
      'avatar': 'http://12345',
      'color': '',
      'courseId': '',
      'isCompleted': false,
      'isUnlocked': false,
      'name': 'pilong',
      'sectionIds': [''],
    };
    const chapterId = '123456';

    test('Case: Success', () async {
      when(
        () => mockChapterService.getChapterById(
          chapterId,
        ),
      ).thenAnswer((_) async => Right(mockData));

      final result = await chapterRepo.getChapterById(chapterId);

      expect(result, isA<Right>());
      verify(() => mockChapterService.getChapterById(chapterId)).called(1);
    });

    test('Case: Failure', () async {
      when(
        () => mockChapterService.getChapterById(
          chapterId,
        ),
      ).thenAnswer((_) async => Left(mockData));

      final result = await chapterRepo.getChapterById(chapterId);

      expect(result, isA<Left>());
      verify(() => mockChapterService.getChapterById(chapterId)).called(1);
    });
  });
}
