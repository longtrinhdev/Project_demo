import 'package:bloc_test/bloc_test.dart';
import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/domain/languages/entities/language.dart';
import 'package:doulingo/domain/languages/usecase/get_all_language.dart';
import 'package:doulingo/presentation/collect_info/pages/page_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAllLanguageUC extends Mock implements GetAllLanguageUseCase {}

class MockGenerateCubit extends MockCubit<GenerateDataState>
    implements GenerateDataCubit {}

void main() {
  late MockGetAllLanguageUC mockGetAllLanguageUC;
  late MockGenerateCubit cubit;
  final locator = GetIt.instance;

  setUp(() {
    mockGetAllLanguageUC = MockGetAllLanguageUC();
    cubit = MockGenerateCubit();
    locator.registerLazySingleton<GetAllLanguageUseCase>(
        () => mockGetAllLanguageUC);
  });

  tearDown(() {
    locator.reset();
  });

  group('Select language page', () {
    final List<LanguageEntity> lst = [
      LanguageEntity(
        id: 'id',
        image: 'image',
        language: 'language',
        userIds: ['userIds'],
        idChapters: ['idChapters'],
        vowelIds: ['vowelIds'],
        consonantIds: ['consonantIds'],
      ),
    ];
    Widget widgetTest() {
      return BlocProvider<GenerateDataCubit>.value(
        value: cubit..getData<List<LanguageEntity>>(mockGetAllLanguageUC),
        child: const MaterialApp(
          home: ChooseLanguage(),
        ),
      );
    }

    testWidgets('Emit DataLoading State', (tester) async {
      when(() => mockGetAllLanguageUC.call(params: any(named: 'params')))
          .thenAnswer((_) async => Future.delayed(const Duration(seconds: 1)));

      when(() => cubit.state).thenReturn(DataLoading());
      await tester.pumpWidget(widgetTest());
      await tester.pump();

      expect(find.byType(SpinKitThreeBounce), findsOneWidget);
    });
  });
}
