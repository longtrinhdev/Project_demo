import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/loading/animation_loading.dart';
import 'package:doulingo/common/widget/snack_bar/custom_snackbar.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/domain/auth/use_case/logout_use_case.dart';
import 'package:doulingo/presentation/introduce/introduce_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GenerateDataCubit>(
      create: (context) => GenerateDataCubit()
        ..getData<bool>(
          sl<LogoutUseCase>(),
        ),
      child: BlocListener<GenerateDataCubit, GenerateDataState>(
        listener: (context, state) {
          if (state is DataLoaded) {
            AppRoute.pushAndRemoveLeftToRight(
              context,
              const IntroducePage(),
            );
          } else if (state is DataLoadedFailure) {
            CustomSnackbar.show(
              context,
              AppImages.imgCancel,
              state.errorMessage,
              AppColors.background,
            );

            AppRoute.pop(context);
          }
        },
        child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
          builder: (context, state) => const AnimationLoading(),
        ),
      ),
    );
  }
}
