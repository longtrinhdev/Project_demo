import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/core/usecase/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateDataCubit extends Cubit<GenerateDataState> {
  GenerateDataCubit() : super(DataLoading());

  void getData<T>(UseCase useCase, {dynamic params}) async {
    final returnData = await useCase.call(params: params);
    returnData.fold(
      (error) {
        emit(DataLoadedFailure(errorMessage: error));
      },
      (data) {
        emit(DataLoaded<T>(data: data));
      },
    );
  }
}
