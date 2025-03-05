import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/common/local_data/source/local_data_service.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/common/local_data/use_case/remove_data_use_case.dart';
import 'package:doulingo/common/local_data/use_case/set_data_use_case.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/auth/repository/auth_repo_impl.dart';
import 'package:doulingo/data/auth/source/auth_service.dart';
import 'package:doulingo/data/language/repositories/language_repo_impl.dart';
import 'package:doulingo/data/language/sources/language_service.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/domain/auth/use_case/check_user_use_case.dart';
import 'package:doulingo/domain/auth/use_case/forgot_pw.dart';
import 'package:doulingo/domain/auth/use_case/signin_use_case.dart';
import 'package:doulingo/domain/auth/use_case/signup_use_case.dart';
import 'package:doulingo/domain/languages/repository/language_repo.dart';
import 'package:doulingo/domain/languages/usecase/get_all_language.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setUpServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //Services
  sl.registerSingleton<AuthService>(AuthServiceImpl());
  sl.registerSingleton<LocalDataService>(LocalDataServiceImpl());
  sl.registerSingleton<LanguageService>(LanguageServiceImpl());

  // Repository
  sl.registerSingleton<AuthRepo>(AuthRepoImpl());
  sl.registerSingleton<LocalDataRepo>(LocalDataRepoImpl());
  sl.registerSingleton<LanguageRepository>(LanguageRepoImpl());

  // Use case
  sl.registerSingleton<ForgotPwUseCase>(ForgotPwUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<CheckUserUseCase>(CheckUserUseCase());
  sl.registerSingleton<GetDataUseCase>(GetDataUseCase());
  sl.registerSingleton<SetDataUseCase>(SetDataUseCase());
  sl.registerSingleton<RemoveDataUseCase>(RemoveDataUseCase());
  sl.registerSingleton<GetAllLanguageUseCase>(GetAllLanguageUseCase());
}
