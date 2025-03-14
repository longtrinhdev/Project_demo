import 'package:dartz/dartz.dart';
import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/domain/pronounce/entities/pronounce.dart';
import 'package:doulingo/domain/pronounce/use_case/get_all_use_case.dart';
import 'package:doulingo/presentation/pronounce/pages/pronounce_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllPronounceUC extends Mock implements GetAllPronounceUseCase {}

void main() {
  late MockGetAllPronounceUC getAllPronounceUC;
  late GenerateDataCubit cubit;
  final locator = GetIt.instance;
  String idCourse = '123456';

  setUp(() {
    getAllPronounceUC = MockGetAllPronounceUC();
    cubit = GenerateDataCubit();
    locator.registerLazySingleton<GetAllPronounceUseCase>(
      () => getAllPronounceUC,
    );
  });

  tearDown(() {
    locator.reset();
  });

  group('UI: Pronounce Page', () {
    final mockData = [
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
      PronounceEntity(),
    ];
    Widget widgetTest() {
      return MaterialApp(
        home: BlocProvider.value(
          value: cubit
            ..getData<List<PronounceEntity>>(
              getAllPronounceUC,
              params: idCourse,
            ),
          child: PronouncePage(idCourse: idCourse),
        ),
      );
    }

    testWidgets('Emit DataLoading State', (tester) async {
      when(() => getAllPronounceUC.call(
            params: idCourse,
          )).thenAnswer((_) async => Right(mockData));
      cubit.emit(DataLoading());
      await tester.pumpWidget(widgetTest());

      expect(find.byType(AppLoading), findsOneWidget);
    });
  });
}
