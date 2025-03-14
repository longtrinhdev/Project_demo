import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {}

class SignupInitial extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignupLoading extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignupSuccessState extends SignUpState {
  final bool isSuccess;
  SignupSuccessState({required this.isSuccess});
  @override
  List<Object?> get props => [isSuccess];
}

class SignupFailureState extends SignUpState {
  final String errorMessage;
  SignupFailureState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
