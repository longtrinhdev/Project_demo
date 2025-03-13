import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/chapter/repository/chapter_repo.dart';
import 'package:doulingo/domain/chapter/use_case/get_chapter_by_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockChapterRepository extends Mock implements ChapterRepo {}

void main() {
  late MockChapterRepository chapterRepository;
  late GetChapterById getChapterById;
  final locator = GetIt.instance;

  setUp(() {
    chapterRepository = MockChapterRepository();
    getChapterById = GetChapterById();
    locator.registerLazySingleton<ChapterRepo>(() => chapterRepository);
  });

  tearDown(() {
    locator.reset();
  });

  group('Get Chapter By Id', () {
    const idChapter = '123456';
    test('Case: Success', () async {
      when(
        () => chapterRepository.getChapterById(
          idChapter,
        ),
      ).thenAnswer((_) async => const Right('Get Chapter Success'));

      final result = await getChapterById.call(
        params: idChapter,
      );

      expect(result, const Right('Get Chapter Success'));
      verify(
        () => chapterRepository.getChapterById(
          idChapter,
        ),
      ).called(1);
    });

    test('Case: Failure', () async {
      when(
        () => chapterRepository.getChapterById(
          idChapter,
        ),
      ).thenAnswer((_) async => const Left('Get Chapter Failure'));

      final result = await getChapterById.call(
        params: idChapter,
      );

      expect(result, const Left('Get Chapter Failure'));
      verify(
        () => chapterRepository.getChapterById(
          idChapter,
        ),
      ).called(1);
    });
  });
}
