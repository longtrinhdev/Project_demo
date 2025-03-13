import 'package:dartz/dartz.dart';
import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/local_data/use_case/set_data_use_case.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/item_view/item_view.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/domain/languages/entities/language.dart';
import 'package:doulingo/domain/languages/usecase/get_all_language.dart';
import 'package:doulingo/presentation/collect_info/pages/page_four.dart';
import 'package:doulingo/presentation/collect_info/pages/page_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockGetAllLanguageUC extends Mock implements GetAllLanguageUseCase {}

class MockSetDataUC extends Mock implements SetDataUseCase {}

void main() {
  group('ChooseLanguage UI Test', () {
    final locator = GetIt.instance;
    late GenerateDataCubit cubit;
    late MockGetAllLanguageUC mockGetAllLanguageUC;
    late MockSetDataUC mockSetDataUC;
    final mockLanguages = [
      LanguageEntity(
        id: 'id',
        image: 'https://example.com/eng.svg',
        language: 'language',
        userIds: ['userIds'],
        idChapters: ['idChapters'],
        vowelIds: ['vowelIds'],
        consonantIds: ['consonantIds'],
      ),
    ];

    setUp(() {
      cubit = GenerateDataCubit();
      mockGetAllLanguageUC = MockGetAllLanguageUC();
      mockSetDataUC = MockSetDataUC();
      registerFallbackValue(SharedReq(key: 'language', value: 'mock_value'));
      locator.registerLazySingleton<GetAllLanguageUseCase>(
          () => mockGetAllLanguageUC);
      locator.registerLazySingleton<SetDataUseCase>(() => mockSetDataUC);
    });

    tearDown(() {
      locator.reset();
    });

    Widget buildTestableWidget(GenerateDataCubit cubit) {
      when(() => mockGetAllLanguageUC.call(params: any(named: 'params')))
          .thenAnswer((_) async => Right(mockLanguages));
      return MaterialApp(
        home: BlocProvider<GenerateDataCubit>.value(
          value: cubit..getData<List<LanguageEntity>>(mockGetAllLanguageUC),
          child: const ChooseLanguage(),
        ),
      );
    }

    testWidgets('Emit DataLoading State', (tester) async {
      cubit.emit(DataLoading());
      await tester.pumpWidget(buildTestableWidget(cubit));

      expect(find.byType(SpinKitThreeBounce), findsOneWidget);
    });

    testWidgets('Emit DataLoaded State', (tester) async {
      await mockNetworkImages(() async {
        when(() => mockSetDataUC.call(params: any(named: 'params')))
            .thenAnswer(((_) async => {}));
        await tester.pumpWidget(buildTestableWidget(cubit));
        cubit.emit(DataLoaded<List<LanguageEntity>>(data: mockLanguages));
        await tester.pump();

        expect(find.byType(AppbarBase), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
        expect(find.text(AppTexts.chooseLanguagePageTitle), findsOneWidget);
        expect(find.byType(AppTooltip), findsOneWidget);
        expect(find.byType(ItemView), findsOneWidget);
        expect(find.byType(BaseButton), findsOneWidget);
        expect(find.byKey(const ValueKey('base_button')), findsOneWidget);

        await tester.tap(find.byKey(const ValueKey('base_button')));
        await tester.pumpAndSettle();

        verify(() => mockSetDataUC.call(params: any(named: 'params')))
            .called(1);

        expect(find.byType(PageFour), findsNothing);
      });
    });

    testWidgets('Emit DataLoadedFailure State', (tester) async {
      await mockNetworkImages(() async {
        when(
          () => mockGetAllLanguageUC.call(
            params: any(named: 'params'),
          ),
        ).thenAnswer((_) async => const Left('Failed to load data'));
        cubit.emit(DataLoadedFailure(errorMessage: "Failed to load data"));

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<GenerateDataCubit>.value(
              value: cubit..getData<List<LanguageEntity>>(mockGetAllLanguageUC),
              child: const ChooseLanguage(),
            ),
          ),
        );
        await tester.pump();

        expect(cubit.state, isA<DataLoadedFailure>());
        expect(find.byType(Center), findsOneWidget);
        expect(find.text('Failed to load data'), findsOneWidget);
      });
    });
  });
}
