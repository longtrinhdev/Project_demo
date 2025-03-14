import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/domain/auth/entities/user.dart';
import 'package:doulingo/domain/auth/use_case/signin_use_case.dart';
import 'package:doulingo/presentation/auth/signin/bloc/sign_in_state.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(InitialSignInState());

  Future<void> signIn(String email, String password) async {
    emit(SigninLoadingState());
    final result = await sl<SigninUseCase>().call(
      params: SigninModel(username: email, password: password),
    );

    result.fold(
      (error) => emit(SigninErrorState(errorMessage: error.toString())),
      (data) => emit(SigninSuccessState(user: data as UserEntity)),
    );
  }
}
