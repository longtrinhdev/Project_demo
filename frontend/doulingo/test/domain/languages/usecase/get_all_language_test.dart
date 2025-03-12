import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:doulingo/domain/languages/usecase/get_all_language.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockLanguageRepository extends Mock implements LanguageRepository {}

void main() {
  late MockLanguageRepository languageRepository;
  late GetAllLanguageUseCase getAllLanguageUseCase;
  final locator = GetIt.instance;

  setUp(() {
    languageRepository = MockLanguageRepository();
    getAllLanguageUseCase = GetAllLanguageUseCase();
    locator.registerLazySingleton<LanguageRepository>(() => languageRepository);
  });

  tearDown(() {
    locator.reset();
  });

  test('Success when return data', () async {
    when(() => languageRepository.getAllLanguage())
        .thenAnswer((_) async => const Right('Get Data Success'));

    final result = await getAllLanguageUseCase.call();

    expect(result, equals(const Right('Get Data Success')));
    verify(() => languageRepository.getAllLanguage()).called(1);
  });

  test('Error when return error message', () async {
    when(() => languageRepository.getAllLanguage())
        .thenAnswer((_) async => const Left('Invalid Credentials'));

    final result = await getAllLanguageUseCase.call();

    expect(result, equals(const Left('Invalid Credentials')));
    verify(() => languageRepository.getAllLanguage()).called(1);
  });
}
