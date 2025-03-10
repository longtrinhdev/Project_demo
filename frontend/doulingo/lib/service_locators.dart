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
import 'package:doulingo/data/section/repositories/section_repo_impl.dart';
import 'package:doulingo/data/section/sources/section_service.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/domain/auth/use_case/check_user_use_case.dart';
import 'package:doulingo/domain/auth/use_case/forgot_pw.dart';
import 'package:doulingo/domain/auth/use_case/signin_use_case.dart';
import 'package:doulingo/domain/auth/use_case/signup_use_case.dart';
import 'package:doulingo/domain/chapter/repository/chapter_repo.dart';
import 'package:doulingo/domain/chapter/use_case/get_all_chapter.dart';
import 'package:doulingo/domain/chapter/use_case/get_chapter_by_id.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:doulingo/domain/languages/usecase/get_all_language.dart';
import 'package:doulingo/domain/languages/usecase/get_language.dart';
import 'package:doulingo/domain/pronounce/repository/pronounce_repo.dart';
import 'package:doulingo/domain/pronounce/use_case/get_all_use_case.dart';
import 'package:doulingo/domain/section/repositories/section_repo.dart';
import 'package:doulingo/domain/section/use_case/get_all_use_case.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //Services
  sl.registerSingleton<AuthService>(AuthServiceImpl());
  sl.registerSingleton<LocalDataService>(LocalDataServiceImpl());
  sl.registerSingleton<LanguageService>(LanguageServiceImpl());
  sl.registerSingleton<ChapterService>(ChapterServiceImpl());
  sl.registerSingleton<SectionService>(SectionServiceImpl());
  sl.registerSingleton<PronounceService>(PronounceServiceImpl());

  // Repository
  sl.registerSingleton<AuthRepo>(AuthRepoImpl());
  sl.registerSingleton<LocalDataRepo>(LocalDataRepoImpl());
  sl.registerSingleton<LanguageRepository>(LanguageRepoImpl());
  sl.registerSingleton<ChapterRepo>(ChapterRepoImpl());
  sl.registerSingleton<SectionRepository>(SectionRepoImpl());
  sl.registerSingleton<PronounceRepository>(PronounceRepoImpl());

  // Use case
  sl.registerSingleton<ForgotPwUseCase>(ForgotPwUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<CheckUserUseCase>(CheckUserUseCase());
  sl.registerSingleton<GetDataUseCase>(GetDataUseCase());
  sl.registerSingleton<SetDataUseCase>(SetDataUseCase());
  sl.registerSingleton<RemoveDataUseCase>(RemoveDataUseCase());

  // use case language
  sl.registerSingleton<GetAllLanguageUseCase>(GetAllLanguageUseCase());
  sl.registerSingleton<GetLanguageUseCase>(GetLanguageUseCase());

  // use case chapter
  sl.registerSingleton<GetAllChapterUseCase>(GetAllChapterUseCase());
  sl.registerSingleton<GetChapterById>(GetChapterById());

  // use case section
  sl.registerSingleton<GetAllUseCase>(GetAllUseCase());

  // syllables
  sl.registerSingleton<GetAllPronounceUseCase>(GetAllPronounceUseCase());
}
