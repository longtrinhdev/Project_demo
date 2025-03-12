import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:doulingo/domain/languages/usecase/get_language.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockLanguageRepo extends Mock implements LanguageRepository {}

void main() {
  late MockLanguageRepo languageRepo;
  late GetLanguageUseCase getLanguageUseCase;
  final locator = GetIt.instance;
  const courseId = '12345678';

  setUp(() {
    languageRepo = MockLanguageRepo();
    getLanguageUseCase = GetLanguageUseCase();
    locator.registerLazySingleton<LanguageRepository>(() => languageRepo);
  });

  tearDown(() {
    locator.reset();
  });

  test('Success when return data', () async {
    when(() => languageRepo.getCourseById(courseId))
        .thenAnswer((_) async => const Right('Get language success'));
    final result = await getLanguageUseCase.call(
      params: courseId,
    );

    expect(result, const Right('Get language success'));
    verify(() => languageRepo.getCourseById(courseId)).called(1);
  });

  test('Error when return message error', () async {
    when(() => languageRepo.getCourseById(courseId))
        .thenAnswer((_) async => const Left('Get language failure'));
    final result = await getLanguageUseCase.call(
      params: courseId,
    );

    expect(result, const Left('Get language failure'));
    verify(() => languageRepo.getCourseById(courseId)).called(1);
  });
}
