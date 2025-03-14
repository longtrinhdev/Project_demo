import 'package:doulingo/domain/auth/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {}

class InitialSignInState extends SignInState {
  @override
  List<Object?> get props => [];
}

class SigninLoadingState extends SignInState {
  @override
  List<Object?> get props => [];
}

class SigninSuccessState extends SignInState {
  final UserEntity user;
  SigninSuccessState({required this.user});
  @override
  List<Object?> get props => [user];
}

class SigninErrorState extends SignInState {
  final String errorMessage;
  SigninErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
