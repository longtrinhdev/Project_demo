import 'package:equatable/equatable.dart';

abstract class GenerateDataState extends Equatable {}

class DataLoading extends GenerateDataState {
  @override
  List<Object?> get props => [];
}

class DataLoaded<T> extends GenerateDataState {
  final T data;
  DataLoaded({required this.data});
  @override
  List<Object?> get props => [data];
}

class DataLoadedFailure extends GenerateDataState {
  final String errorMessage;
  DataLoadedFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
