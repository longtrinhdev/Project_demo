import 'package:dartz/dartz.dart';
import 'package:doulingo/data/pronounce/repository/pronounce_repo_impl.dart';
import 'package:doulingo/data/pronounce/sources/pronounce_service.dart';
import 'package:doulingo/domain/pronounce/repository/pronounce_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockPronounceService extends Mock implements PronounceService {}

void main() {
  late PronounceRepository pronounceRepository;
  late MockPronounceService pronounceService;
  final locator = GetIt.instance;

  setUp(() {
    pronounceService = MockPronounceService();
    locator.registerLazySingleton<PronounceService>(() => pronounceService);
    pronounceRepository = PronounceRepoImpl();
  });

  tearDown(() {
    locator.reset();
  });

  group('PronounceRepoImpl', () {
    String idCourse = '123456';
    final mockData = [
      {
        'audio': '',
        'courseId': '123456',
        'example': '',
        'image': '',
        'id': '',
        'manual': '',
        'questionId': [''],
        'video': '',
        'word': '',
      }
    ];

    test('Case: Success', () async {
      when(() => pronounceService.getAllPronounce(idCourse)).thenAnswer(
        (_) async => Right(mockData),
      );

      final result = await pronounceRepository.getAllPronounce(idCourse);

      expect(result, isA<Right>());
      verify(() => pronounceService.getAllPronounce(idCourse)).called(1);
    });

    test('Case: Failure', () async {
      when(() => pronounceService.getAllPronounce(idCourse)).thenAnswer(
        (_) async => const Left('Get Data Failure'),
      );

      final result = await pronounceRepository.getAllPronounce(idCourse);

      expect(result, const Left('Get Data Failure'));
      verify(() => pronounceService.getAllPronounce(idCourse)).called(1);
    });
  });
}
