import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/use_case/check_user_use_case.dart';
import 'package:doulingo/domain/auth/use_case/signup_use_case.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_state.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignupInitial());

  Future<void> userExist(String email) async {
    emit(SignupLoading());

    final response = await sl<CheckUserUseCase>().call(
      params: email,
    );

    return response.fold(
      (error) => emit(SignupFailureState(errorMessage: error)),
      (data) => emit(SignupSuccessState(isSuccess: data as bool)),
    );
  }

  Future<void> signup(SignupModel signupModel) async {
    emit(SignupLoading());
    final response = await sl<SignupUseCase>().call(
      params: signupModel,
    );

    return response.fold(
      (error) => emit(SignupFailureState(errorMessage: error)),
      (data) => emit(SignupSuccessState(isSuccess: data as bool)),
    );
  }
}
