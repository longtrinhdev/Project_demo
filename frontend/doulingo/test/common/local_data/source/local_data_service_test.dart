import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/local_data/source/local_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocalDataService localDataService;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataService = LocalDataServiceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('Local Data', () {
    const key = 'key';
    const value = 'value';
    test('Get Data Success', () async {
      when(
        () => mockSharedPreferences.getString(key),
      ).thenReturn(value);

      final result = await localDataService.getString(key);

      expect(result, value);
      verify(() => mockSharedPreferences.getString(key)).called(1);
    });

    test('Get Data Failed', () async {
      when(() => mockSharedPreferences.getString(key)).thenReturn('');

      final result = await localDataService.getString(key);
      expect(result, '');
      verify(() => mockSharedPreferences.getString(key)).called(1);
    });

    test('Save Data', () async {
      final mockShareReq = SharedReq(key: key, value: value);
      when(() => mockSharedPreferences.setString(key, value))
          .thenAnswer((_) async => true);

      await localDataService.setString(mockShareReq);

      verify(() => mockSharedPreferences.setString(key, value)).called(1);
    });

    test('Clear Data', () async {
      when(() => mockSharedPreferences.clear()).thenAnswer((_) async => true);

      await localDataService.removeShared();

      verify(() => mockSharedPreferences.clear()).called(1);
    });
  });
}
