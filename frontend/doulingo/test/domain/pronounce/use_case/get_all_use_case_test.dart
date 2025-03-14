import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/pronounce/repository/pronounce_repo.dart';
import 'package:doulingo/domain/pronounce/use_case/get_all_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockPronounceRepository extends Mock implements PronounceRepository {}

void main() {
  late MockPronounceRepository pronounceRepository;
  late GetAllPronounceUseCase getAllPronounceUseCase;
  final locator = GetIt.instance;

  setUp(() {
    pronounceRepository = MockPronounceRepository();
    locator
        .registerLazySingleton<PronounceRepository>(() => pronounceRepository);
    getAllPronounceUseCase = GetAllPronounceUseCase();
  });

  tearDown(() {
    locator.reset();
  });

  group('Get All Pronounce', () {
    test('Case: Success', () async {
      String idCourse = '123456';
      when(() => pronounceRepository.getAllPronounce(idCourse)).thenAnswer(
        (_) async => const Right('Get Data Success'),
      );

      final result = await getAllPronounceUseCase.call(
        params: idCourse,
      );

      expect(result, const Right('Get Data Success'));
      verify(() => pronounceRepository.getAllPronounce(idCourse)).called(1);
    });

    test('Case: Failure', () async {
      String idCourse = '123456';
      when(() => pronounceRepository.getAllPronounce(idCourse)).thenAnswer(
        (_) async => const Left('Get Data Failure'),
      );

      final result = await getAllPronounceUseCase.call(
        params: idCourse,
      );

      expect(result, const Left('Get Data Failure'));
      verify(() => pronounceRepository.getAllPronounce(idCourse)).called(1);
    });
  });
}
