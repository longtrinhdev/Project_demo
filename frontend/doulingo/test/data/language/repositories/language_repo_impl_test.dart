import 'package:dartz/dartz.dart';
import 'package:doulingo/data/language/repositories/language_repo_impl.dart';
import 'package:doulingo/data/language/sources/language_service.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockLanguageService extends Mock implements LanguageService {}

void main() {
  late MockLanguageService mockLanguageService;
  late LanguageRepository languageRepository;
  final locator = GetIt.instance;
  final courses = {
    {
      'id': 'id',
      'image': 'image',
      'language': 'language',
      'userIds': ['userIds'],
      'idChapters': ['idChapters'],
      'vowelIds': ['vowelIds'],
      'consonantIds': ['consonantIds'],
    }
  };
  final course = {
    'id': 'id',
    'image': 'image',
    'language': 'language',
    'userIds': ['userIds'],
    'idChapters': ['idChapters'],
    'vowelIds': ['vowelIds'],
    'consonantIds': ['consonantIds'],
  };

  const idCourse = '12345678';

  setUp(() {
    mockLanguageService = MockLanguageService();
    languageRepository = LanguageRepoImpl();
    locator.registerLazySingleton<LanguageService>(() => mockLanguageService);
  });

  tearDown(() {
    locator.reset();
  });

  group('Get All Language', () {
    test('Success when return data', () async {
      when(() => mockLanguageService.getAllLanguage())
          .thenAnswer((_) async => Right(courses));

      final result = await languageRepository.getAllLanguage();

      expect(result, isA<Right>());
      verify(() => mockLanguageService.getAllLanguage()).called(1);
    });

    test('Failed when return error message', () async {
      when(() => mockLanguageService.getAllLanguage())
          .thenAnswer((_) async => const Left('Get All Language Failed'));

      final result = await languageRepository.getAllLanguage();

      expect(result, isA<Left>());
      verify(() => mockLanguageService.getAllLanguage()).called(1);
    });
  });

  group('Get Course by id', () {
    test('Success when return data', () async {
      when(() => mockLanguageService.getCourseById(idCourse)).thenAnswer(
        (_) async => Right(course),
      );

      final result = await languageRepository.getCourseById(idCourse);

      expect(result, isA<Right>());
      verify(() => mockLanguageService.getCourseById(idCourse)).called(1);
    });

    test('Failure when return error message', () async {
      when(() => mockLanguageService.getCourseById(idCourse)).thenAnswer(
        (_) async => const Left('Invalid Credentials'),
      );

      final result = await languageRepository.getCourseById(idCourse);

      expect(result, isA<Left>());
      verify(() => mockLanguageService.getCourseById(idCourse)).called(1);
    });
  });
}
