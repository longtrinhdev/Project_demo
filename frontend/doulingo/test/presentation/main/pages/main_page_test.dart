import 'package:dartz/dartz.dart';
import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/widget/failed_page/failed_page.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/domain/languages/entities/language.dart';
import 'package:doulingo/domain/languages/usecase/get_language.dart';
import 'package:doulingo/presentation/main/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetLanguageUC extends Mock implements GetLanguageUseCase {}

void main() {
  late MockGetLanguageUC mockGetLanguageUC;
  late GenerateDataCubit mockGenerateDataCubit;
  final locator = GetIt.instance;
  String courseId = '123456';
  num score = 6;
  final language = LanguageEntity(
    id: 'id',
    image: 'image',
    language: 'language',
    userIds: ['userIds'],
    idChapters: ['idChapters'],
    vowelIds: ['vowelIds'],
    consonantIds: ['consonantIds'],
  );

  setUp(() {
    mockGetLanguageUC = MockGetLanguageUC();
    mockGenerateDataCubit = GenerateDataCubit();
    locator.registerLazySingleton<GetLanguageUseCase>(() => mockGetLanguageUC);
  });

  tearDown(() {
    locator.reset();
    mockGenerateDataCubit.close();
  });

  group('Main Page', () {
    Widget widgetTest() {
      return BlocProvider<GenerateDataCubit>(
        create: (context) => mockGenerateDataCubit
          ..getData<LanguageEntity>(
            mockGetLanguageUC,
            params: courseId,
          ),
        child: MaterialApp(
          home: MainPage(score: score, courseId: courseId),
        ),
      );
    }

    testWidgets('UI when state is loading', (tester) async {
      when(() => mockGetLanguageUC.call(params: any(named: 'params')))
          .thenAnswer((_) async => Right(language));
      mockGenerateDataCubit.emit(DataLoading());

      await tester.pumpWidget(widgetTest());

      expect(find.byType(AppLoading), findsOneWidget);
    });

    testWidgets('UI when state is Failed', (tester) async {
      when(() => mockGetLanguageUC.call(params: any(named: 'params')))
          .thenAnswer((_) async => const Left('Load Data Failed'));

      mockGenerateDataCubit
          .emit(DataLoadedFailure(errorMessage: 'Load Data Failed'));

      await tester.pumpWidget(widgetTest());
      await tester.pump();

      expect(find.byType(FailedPage), findsOneWidget);
    });

    testWidgets('UI when state is Data Loaded', (tester) async {
      when(
        () => mockGetLanguageUC.call(
          params: any(named: 'params'),
        ),
      ).thenAnswer((_) async => Right(language));

      mockGenerateDataCubit.emit(DataLoaded(data: language));

      await tester.pumpWidget(widgetTest());

      expect(mockGenerateDataCubit.state, isA<DataLoaded>());
    });
  });
}
