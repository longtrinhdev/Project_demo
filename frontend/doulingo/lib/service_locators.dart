import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/common/local_data/source/local_data_service.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/common/local_data/use_case/remove_data_use_case.dart';
import 'package:doulingo/common/local_data/use_case/set_data_use_case.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/auth/repository/auth_repo_impl.dart';
import 'package:doulingo/data/auth/source/auth_service.dart';
import 'package:doulingo/data/chapter/repository/chapter_repo_impl.dart';
import 'package:doulingo/data/chapter/sources/chapter_service.dart';
import 'package:doulingo/data/language/repositories/language_repo_impl.dart';
import 'package:doulingo/data/language/sources/language_service.dart';
import 'package:doulingo/data/pronounce/repository/pronounce_repo_impl.dart';
import 'package:doulingo/data/pronounce/sources/pronounce_service.dart';
import 'package:doulingo/data/question/repository/question_repo_impl.dart';
import 'package:doulingo/data/question/source/question_service.dart';
import 'package:doulingo/data/section/repositories/section_repo_impl.dart';
import 'package:doulingo/data/section/sources/section_service.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/domain/auth/use_case/check_user_use_case.dart';
import 'package:doulingo/domain/auth/use_case/forgot_pw.dart';
import 'package:doulingo/domain/auth/use_case/google_signin_uc.dart';
import 'package:doulingo/domain/auth/use_case/logout_use_case.dart';
import 'package:doulingo/domain/auth/use_case/signin_use_case.dart';
import 'package:doulingo/domain/auth/use_case/signup_use_case.dart';
import 'package:doulingo/domain/auth/use_case/update_new_course.dart';
import 'package:doulingo/domain/chapter/repository/chapter_repo.dart';
import 'package:doulingo/domain/chapter/use_case/get_all_chapter.dart';
import 'package:doulingo/domain/chapter/use_case/get_chapter_by_id.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:doulingo/domain/languages/usecase/get_all_language.dart';
import 'package:doulingo/domain/languages/usecase/get_language.dart';
import 'package:doulingo/domain/pronounce/repository/pronounce_repo.dart';
import 'package:doulingo/domain/pronounce/use_case/get_all_use_case.dart';
import 'package:doulingo/domain/question/repository/question_repo.dart';
import 'package:doulingo/domain/question/use_case/get_all_question_uc.dart';
import 'package:doulingo/domain/section/repositories/section_repo.dart';
import 'package:doulingo/domain/section/use_case/get_all_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setUpServiceLocator() async {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  //Services

  sl.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  sl.registerLazySingleton<LocalDataService>(
      () => LocalDataServiceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<LanguageService>(() => LanguageServiceImpl());
  sl.registerLazySingleton<ChapterService>(() => ChapterServiceImpl());
  sl.registerLazySingleton<SectionService>(() => SectionServiceImpl());
  sl.registerLazySingleton<PronounceService>(() => PronounceServiceImpl());
  sl.registerLazySingleton<QuestionService>(() => QuestionServiceImpl());

  // Repository
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  sl.registerLazySingleton<LocalDataRepo>(
      () => LocalDataRepoImpl(localDataService: sl()));
  sl.registerLazySingleton<LanguageRepository>(() => LanguageRepoImpl());
  sl.registerLazySingleton<ChapterRepo>(() => ChapterRepoImpl());
  sl.registerLazySingleton<SectionRepository>(() => SectionRepoImpl());
  sl.registerLazySingleton<PronounceRepository>(() => PronounceRepoImpl());
  sl.registerLazySingleton<QuestionRepo>(() => QuestionRepoImpl());

  // Use case
  sl.registerLazySingleton<ForgotPwUseCase>(() => ForgotPwUseCase());
  sl.registerLazySingleton<SigninUseCase>(() => SigninUseCase());
  sl.registerLazySingleton<GoogleSigninUc>(() => GoogleSigninUc());
  sl.registerLazySingleton<SignupUseCase>(() => SignupUseCase());
  sl.registerLazySingleton<CheckUserUseCase>(() => CheckUserUseCase());
  sl.registerLazySingleton<GetDataUseCase>(() => GetDataUseCase());
  sl.registerLazySingleton<SetDataUseCase>(() => SetDataUseCase());
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase());
  sl.registerLazySingleton<RemoveDataUseCase>(() => RemoveDataUseCase());
  sl.registerLazySingleton<UpdateNewCourseUC>(() => UpdateNewCourseUC());

  // use case language
  sl.registerLazySingleton<GetAllLanguageUseCase>(
      () => GetAllLanguageUseCase());
  sl.registerLazySingleton<GetLanguageUseCase>(() => GetLanguageUseCase());

  // use case chapter
  sl.registerLazySingleton<GetAllChapterUseCase>(() => GetAllChapterUseCase());
  sl.registerLazySingleton<GetChapterById>(() => GetChapterById());

  // use case section
  sl.registerLazySingleton<GetAllUseCase>(() => GetAllUseCase());

  //  use case question
  sl.registerLazySingleton<GetAllQuestionUc>(() => GetAllQuestionUc());

  // syllables
  sl.registerLazySingleton<GetAllPronounceUseCase>(
      () => GetAllPronounceUseCase());

  // External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
