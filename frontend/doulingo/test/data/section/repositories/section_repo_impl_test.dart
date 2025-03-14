import 'package:dartz/dartz.dart';
import 'package:doulingo/data/section/repositories/section_repo_impl.dart';
import 'package:doulingo/data/section/sources/section_service.dart';
import 'package:doulingo/domain/section/repositories/section_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockSectionService extends Mock implements SectionService {}

void main() {
  late MockSectionService mockSectionService;
  late SectionRepository sectionRepository;
  final locator = GetIt.instance;

  setUp(() {
    mockSectionService = MockSectionService();
    locator.registerLazySingleton<SectionService>(() => mockSectionService);
    sectionRepository = SectionRepoImpl();
  });

  tearDown(() {
    locator.reset();
  });

  group('Section Repository', () {
    String idChapter = '123456';
    final mockData = [
      {
        'chapterId': '123456',
        'id': '1',
        'title': 'Section 1',
        'color': '',
        'image': '',
        'lessonIds': [''],
        'name': '',
        'sectionContent': [''],
      }
    ];

    test('Case: Success', () async {
      when(() => mockSectionService.getAllSection(idChapter))
          .thenAnswer((_) async => Right(mockData));
      final sections = await sectionRepository.getAllSections(idChapter);

      expect(sections, isA<Right>());
      verify(() => mockSectionService.getAllSection(idChapter)).called(1);
    });

    test('Case: Failure', () async {
      when(() => mockSectionService.getAllSection(idChapter))
          .thenAnswer((_) async => const Left('Invalid Credentials'));
      final sections = await sectionRepository.getAllSections(idChapter);

      expect(sections, isA<Left>());
      verify(() => mockSectionService.getAllSection(idChapter)).called(1);
    });
  });
}
