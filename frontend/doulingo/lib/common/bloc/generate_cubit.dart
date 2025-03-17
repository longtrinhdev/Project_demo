import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateCubit extends Cubit<GenerateDataState> {
  GenerateCubit() : super(InitialState());

  Future<void> getData<T>(UseCase useCase, {dynamic params}) async {
    emit(DataLoading());
    final responseData = await useCase.call(params: params);

    return responseData.fold(
      (error) => emit(DataLoadedFailure(errorMessage: error)),
      (data) => emit(
        DataLoaded<T>(data: data),
      ),
    );
  }
}
