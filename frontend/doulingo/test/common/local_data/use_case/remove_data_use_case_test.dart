import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/common/local_data/use_case/remove_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataRepo extends Mock implements LocalDataRepo {}

void main() {
  late MockLocalDataRepo mockLocalDataRepo;
  late RemoveDataUseCase removeDataUseCase;
  final locator = GetIt.instance;

  setUp(() {
    mockLocalDataRepo = MockLocalDataRepo();
    removeDataUseCase = RemoveDataUseCase();
    locator.registerLazySingleton<LocalDataRepo>(() => mockLocalDataRepo);
  });

  tearDown(() {
    locator.reset();
  });

  test('RemoveDataUseCase ', () async {
    when(() => mockLocalDataRepo.removeData()).thenAnswer((_) async {});

    await removeDataUseCase.call();
    verify(() => mockLocalDataRepo.removeData()).called(1);
  });
}
