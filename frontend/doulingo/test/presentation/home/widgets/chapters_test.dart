import 'package:dartz/dartz.dart';
import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/failed_page/failed_page.dart';
import 'package:doulingo/common/widget/item_view/item_view.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/domain/chapter/entities/chapter.dart';
import 'package:doulingo/domain/chapter/use_case/get_all_chapter.dart';
import 'package:doulingo/domain/section/entities/lesson.dart';
import 'package:doulingo/domain/section/entities/section.dart';
import 'package:doulingo/domain/section/use_case/get_all_use_case.dart';
import 'package:doulingo/presentation/home/widgets/chapters.dart';
import 'package:doulingo/presentation/lesson/pages/lesson_page.dart';
import 'package:doulingo/presentation/sections/widgets/chapter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockGetAllChapterUC extends Mock implements GetAllChapterUseCase {}

class MockGetAllUseCase extends Mock implements GetAllUseCase {}

void main() {
  late MockGetAllChapterUC mockGetAllChapterUC;
  late MockGetAllUseCase mockGetAllUseCase;
  late GenerateDataCubit cubit;
  final locator = GetIt.instance;
  const courseId = '123456';
  const courseTitle = 'English';

  setUp(() {
    mockGetAllChapterUC = MockGetAllChapterUC();
    mockGetAllUseCase = MockGetAllUseCase();
    locator.registerLazySingleton<GetAllChapterUseCase>(
      () => mockGetAllChapterUC,
    );
    locator.registerLazySingleton<GetAllUseCase>(
      () => mockGetAllUseCase,
    );
    cubit = GenerateDataCubit();
  });

  tearDown(() {
    locator.reset();
  });

  group('UI: Chapter Page', () {
    final mockLesson = LessonEntity(
      id: '123456',
      isCompleted: false,
      isUnlocked: true,
      title: 'English',
      questions: [],
    );

    final mockChapters = [
      ChapterEntity(
        avatar: 'https://example.com/eng.svg',
        color: '0xFFAA1234',
        courseId: '123456',
        id: '',
        isCompleted: true,
        isUnlocked: false,
        name: '',
        sectionIds: [''],
        title: 'English',
      ),
    ];

    final mockSections = [
      SectionEntity(
        image: 'https://example.com/eng.svg',
        color: '0xFFAA1234',
        id: '',
        name: 'Chapter 1',
        chapter: '123456',
        lessons: [mockLesson],
        sectionContent: [''],
        title: 'English',
      ),
    ];

    Widget widgetTest() {
      return MaterialApp(
        home: BlocProvider<GenerateDataCubit>.value(
          value: cubit
            ..getData<List<ChapterEntity>>(
              mockGetAllChapterUC,
              params: courseId,
            ),
          child: const ChaptersWidget(
            courseId: courseId,
            courseTitle: courseTitle,
          ),
        ),
      );
    }

    testWidgets('Emit DataLoading State', (tester) async {
      when(
        () => mockGetAllChapterUC.call(
          params: courseId,
        ),
      ).thenAnswer(
        (_) async => Right(
          mockChapters,
        ),
      );
      cubit.emit(DataLoading());

      await tester.pumpWidget(widgetTest());

      expect(find.byType(AppLoading), findsOneWidget);
      expect(find.byType(SpinKitThreeBounce), findsOneWidget);
    });

    testWidgets('Emit DataLoaded State', (tester) async {
      await mockNetworkImages(() async {
        when(
          () => mockGetAllChapterUC.call(
            params: courseId,
          ),
        ).thenAnswer(
          (_) async => Right(
            mockChapters,
          ),
        );

        cubit.emit(DataLoaded<List<ChapterEntity>>(data: mockChapters));
        await tester.pumpWidget(widgetTest());
        await tester.pump();

        expect(cubit.state, isA<DataLoaded>());
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(ItemView), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
        expect(find.byType(SvgPicture), findsOneWidget);
        expect(find.byType(RichText), findsWidgets);
        expect(find.byType(TextSpan), findsNothing);
        expect(find.byKey(const ValueKey('img_lock')), findsOneWidget);
        expect(find.byKey(const ValueKey('item_chapter')), findsOneWidget);
      });
    });

    testWidgets('Navigation To Lesson Page When tap item', (tester) async {
      await mockNetworkImages(() async {
        when(
          () => mockGetAllChapterUC.call(params: any(named: 'params')),
        ).thenAnswer((_) async => Right(mockChapters));

        cubit.emit(DataLoaded<List<ChapterEntity>>(data: mockChapters));

        await tester.pumpWidget(widgetTest());
        await tester.pumpAndSettle();

        expect(find.byType(ListView), findsOneWidget);
        expect(find.byKey(const ValueKey('item_chapter')), findsOneWidget);

        when(
          () => mockGetAllUseCase.call(params: any(named: 'params')),
        ).thenAnswer(
          (_) async => Right(mockSections),
        );

        await tester.tap(find.byKey(const ValueKey('item_chapter')));
        await tester.pumpAndSettle();

        expect(find.byType(LessonPage), findsOneWidget);
        expect(find.byType(AppbarBase), findsOneWidget);
        expect(find.byType(ListView), findsNWidgets(2));
        expect(find.byType(ChapterBar), findsOneWidget);
        expect(cubit.state, isA<DataLoaded>());

        expect(find.byKey(const ValueKey('_back')), findsOneWidget);
        await tester.tap(find.byKey(const ValueKey('_back')));
        await tester.pumpAndSettle();

        expect(find.byType(ChaptersWidget), findsOneWidget);
      });
    });

    testWidgets('Emit DataFailure State', (tester) async {
      const errorMessage = 'Data Loading Failed';
      await mockNetworkImages(() async {
        when(
          () => mockGetAllChapterUC.call(
            params: courseId,
          ),
        ).thenAnswer(
          (_) async => const Left(
            errorMessage,
          ),
        );
        cubit.emit(DataLoadedFailure(errorMessage: errorMessage));
        await tester.pumpWidget(widgetTest());
        await tester.pump();

        expect(cubit.state, isA<DataLoadedFailure>());
        expect(find.byType(FailedPage), findsOneWidget);
        expect(find.byType(AppTooltip), findsOneWidget);
      });
    });
  });
}
