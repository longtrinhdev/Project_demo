import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/common/local_data/use_case/set_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataRepo extends Mock implements LocalDataRepo {}

void main() {
  late MockLocalDataRepo mockLocalDataRepo;
  late SetDataUseCase setDataUseCase;
  final locator = GetIt.instance;

  setUp(() {
    mockLocalDataRepo = MockLocalDataRepo();
    setDataUseCase = SetDataUseCase();
    locator.registerLazySingleton<LocalDataRepo>(() => mockLocalDataRepo);
  });

  tearDown(() {
    locator.reset();
  });

  test('SaveDataUseCase ', () async {
    final mockData = SharedReq(key: 'key', value: 'value');

    when(() => mockLocalDataRepo.setString(mockData)).thenAnswer((_) async {});

    await setDataUseCase.call(
      params: mockData,
    );
    verify(() => mockLocalDataRepo.setString(mockData)).called(1);
  });
}
