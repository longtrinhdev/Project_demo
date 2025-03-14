import 'package:dartz/dartz.dart';
import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/helpers/mapper/user.dart';
import 'package:doulingo/common/local_data/repository/local_data_repo.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/data/auth/models/user.dart';
import 'package:doulingo/data/auth/source/auth_service.dart';
import 'package:doulingo/domain/auth/repository/auth_repo.dart';
import 'package:doulingo/service_locators.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either> checkUser(String email) async {
    final responseData = await sl<AuthService>().checkEmail(email);
    return responseData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        final responseData = data as bool;
        return Right(responseData);
      },
    );
  }

  @override
  Future<Either> signup(SignupModel signupReq) async {
    final responseData = await sl<AuthService>().signup(signupReq);
    return responseData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> signin(SigninModel signinReq) async {
    final responseData = await sl<AuthService>().signin(signinReq);
    return responseData.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final userData = UserMapper.toEntity(UserModel.fromJson(data['user']));
        await sl<LocalDataRepo>().setString(
          SharedReq(
            key: 'access_token',
            value: data['accessToken'],
          ),
        );

        await sl<LocalDataRepo>().setString(
          SharedReq(
            key: 'refresh_token',
            value: data['refreshToken'],
          ),
        );
        return Right(userData);
      },
    );
  }

  @override
  Future<Either> forgotPW(SignupModel signinReq) async {
    final responseData = await sl<AuthService>().forgotPW(signinReq);
    return responseData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }
}
