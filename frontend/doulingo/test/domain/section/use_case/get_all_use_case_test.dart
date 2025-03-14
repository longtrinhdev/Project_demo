import 'package:dartz/dartz.dart';
import 'package:doulingo/domain/section/repositories/section_repo.dart';
import 'package:doulingo/domain/section/use_case/get_all_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockSectionRepository extends Mock implements SectionRepository {}

void main() {
  late MockSectionRepository sectionRepository;
  late GetAllUseCase getAllUseCase;
  final locator = GetIt.instance;

  setUp(() {
    sectionRepository = MockSectionRepository();
    locator.registerLazySingleton<SectionRepository>(() => sectionRepository);
    getAllUseCase = GetAllUseCase();
  });

  tearDown(() {
    locator.reset();
  });

  group('Get All Use Case', () {
    String idChapter = '12345';

    test('Case: Success', () async {
      when(() => sectionRepository.getAllSections(idChapter))
          .thenAnswer((_) async => const Right('Get Data Success'));

      final result = await getAllUseCase.call(
        params: idChapter,
      );

      expect(result, const Right('Get Data Success'));
      verify(() => sectionRepository.getAllSections(idChapter)).called(1);
    });

    test('Case: Failure', () async {
      when(() => sectionRepository.getAllSections(idChapter))
          .thenAnswer((_) async => const Left('Get Data Failure'));

      final result = await getAllUseCase.call(
        params: idChapter,
      );

      expect(result, const Left('Get Data Failure'));
      verify(() => sectionRepository.getAllSections(idChapter)).called(1);
    });
  });
}
