import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/common/local_data/source/local_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataService extends Mock implements LocalDataService {}

void main() {
  late MockLocalDataService mockLocalDataService;
  late LocalDataRepo localDataRepo;

  setUp(() {
    mockLocalDataService = MockLocalDataService();
    localDataRepo = LocalDataRepoImpl(
      localDataService: mockLocalDataService,
    );
  });

  group('Local Data Repository', () {
    String key = 'key';
    String value = 'value';

    test('Get Data', () async {
      when(() => mockLocalDataService.getString(key))
          .thenAnswer((_) async => value);
      final result = await localDataRepo.getString(key);

      expect(result, value);
      verify(() => mockLocalDataService.getString(key)).called(1);
    });

    test('Save Data', () async {
      final sharedReq = SharedReq(key: key, value: value);
      when(() => mockLocalDataService.setString(sharedReq))
          .thenAnswer((_) async {});

      await localDataRepo.setString(sharedReq);

      verify(() => mockLocalDataService.setString(sharedReq)).called(1);
    });

    test('Remove Data', () async {
      when(() => mockLocalDataService.removeShared()).thenAnswer((_) async {});

      await localDataRepo.removeData();

      verify(() => mockLocalDataService.removeShared()).called(1);
    });
  });
}
