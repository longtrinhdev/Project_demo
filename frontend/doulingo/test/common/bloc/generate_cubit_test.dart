import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:doulingo/common/bloc/generate_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUseCase extends Mock implements UseCase {}

void main() {
  late MockUseCase mockUseCase;
  late GenerateCubit generateCubit;
  const String email = 'email@example.com';

  setUp(() {
    mockUseCase = MockUseCase();
    generateCubit = GenerateCubit();
  });

  tearDown(() {
    generateCubit.close();
  });

  group('Generic Cubit', () {
    test('Emit Initial State', () {
      expect(generateCubit.state, isA<InitialState>());
    });

    blocTest(
      'Emit [Loading, Loaded] State',
      build: () {
        when(
          () => mockUseCase.call(params: any(named: 'params')),
        ).thenAnswer((_) async => const Right('Send email success'));
        return generateCubit;
      },
      act: (cubit) => cubit.getData<String>(mockUseCase, params: email),
      expect: () => [DataLoading(), DataLoaded(data: 'Send email success')],
    );

    blocTest(
      'Emit [Loading, LoadFailure] State',
      build: () {
        when(
          () => mockUseCase.call(params: any(named: 'params')),
        ).thenAnswer((_) async => const Left('Send email failed'));
        return generateCubit;
      },
      act: (cubit) => cubit.getData<String>(mockUseCase, params: email),
      expect: () => [
        DataLoading(),
        DataLoadedFailure(errorMessage: 'Send email failed'),
      ],
    );
  });
}
