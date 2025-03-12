import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUseCase extends Mock implements UseCase<Either, SigninModel> {}

void main() {
  late GenerateDataCubit generateDataCubit;
  late MockUseCase mockUseCase;
  final signinModel =
      SigninModel(username: 'pilong.15@', password: '1234567890');

  setUp(() {
    mockUseCase = MockUseCase();
    generateDataCubit = GenerateDataCubit();

    registerFallbackValue(signinModel);
  });

  tearDown(() {
    generateDataCubit.close();
  });

  group('Base Bloc Test ', () {
    test('Emit initial state', () {
      expect(generateDataCubit.state, equals(DataLoading()));
    });

    blocTest<GenerateDataCubit, GenerateDataState>(
      'emit DataLoaded<String> when get data success',
      build: () {
        when(() => mockUseCase.call(params: any(named: 'params')))
            .thenAnswer((_) async => const Right('Login Success'));
        return generateDataCubit;
      },
      act: (cubit) => cubit.getData<String>(mockUseCase, params: signinModel),
      expect: () => [
        DataLoaded<String>(data: "Login Success"),
      ],
    );

    blocTest<GenerateDataCubit, GenerateDataState>(
      'emit DataFailure<String> when get data failure',
      build: () {
        when(() => mockUseCase.call(params: any(named: 'params')))
            .thenAnswer((_) async => const Left('Invalid Credentials'));
        return generateDataCubit;
      },
      act: (cubit) => cubit.getData<String>(mockUseCase, params: signinModel),
      expect: () => [
        DataLoadedFailure(errorMessage: "Invalid Credentials"),
      ],
    );
  });
}
