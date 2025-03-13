import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/chapter/repository/chapter_repo.dart';
import 'package:doulingo/domain/chapter/use_case/get_all_chapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockChapterRepository extends Mock implements ChapterRepo {}

void main() {
  late MockChapterRepository chapterRepository;
  late GetAllChapterUseCase getAllChapterUseCase;
  final locator = GetIt.instance;

  setUp(() {
    chapterRepository = MockChapterRepository();
    getAllChapterUseCase = GetAllChapterUseCase();
    locator.registerLazySingleton<ChapterRepo>(() => chapterRepository);
  });

  tearDown(() {
    locator.reset();
  });

  group('Get All Chapter', () {
    const idCourse = '123456';
    test('Case: Success', () async {
      when(
        () => chapterRepository.getAllChapter(
          idCourse,
        ),
      ).thenAnswer((_) async => const Right('Get All Chapter Success'));

      final result = await getAllChapterUseCase.call(
        params: idCourse,
      );

      expect(result, const Right('Get All Chapter Success'));
      verify(
        () => chapterRepository.getAllChapter(
          idCourse,
        ),
      ).called(1);
    });

    test('Case: Failure', () async {
      when(
        () => chapterRepository.getAllChapter(
          idCourse,
        ),
      ).thenAnswer((_) async => const Left('Get All Chapter Failure'));

      final result = await getAllChapterUseCase.call(
        params: idCourse,
      );

      expect(result, const Left('Get All Chapter Failure'));
      verify(
        () => chapterRepository.getAllChapter(
          idCourse,
        ),
      ).called(1);
    });
  });
}
