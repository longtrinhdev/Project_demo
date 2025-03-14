import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataRepo extends Mock implements LocalDataRepo {}

void main() {
  late MockLocalDataRepo mockLocalDataRepo;
  late GetDataUseCase getDataUseCase;
  final locator = GetIt.instance;

  setUp(() {
    mockLocalDataRepo = MockLocalDataRepo();
    getDataUseCase = GetDataUseCase();
    locator.registerLazySingleton<LocalDataRepo>(() => mockLocalDataRepo);
  });

  tearDown(() {
    locator.reset();
  });

  test('GetDataUseCase', () async {
    String key = 'key';
    String value = 'value';
    when(() => mockLocalDataRepo.getString(key)).thenAnswer((_) async => value);

    final result = await getDataUseCase.call(params: key);

    expect(result, value);
    verify(() => mockLocalDataRepo.getString(key)).called(1);
  });
}
