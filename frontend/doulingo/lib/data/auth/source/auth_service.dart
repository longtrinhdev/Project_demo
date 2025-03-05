import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/service_locators.dart';

abstract class AuthService {
  Future<bool> checkEmail(String email);
  Future<Either> signup(SignupModel signupReq);
  Future<Either> signin(SigninModel signinReq);
  Future<Either> forgotPW(SignupModel signupReq);
}

class AuthServiceImpl extends AuthService {
  @override
  Future<bool> checkEmail(String email) async {
    try {
      final response = await sl<DioClient>().post(ApiUrls.checkUser, data: {
        'email': email,
      });
      return response.data;
    } on DioException catch (error) {
      throw Exception(error.message);
    }
  }

  @override
  Future<Either> signup(SignupModel signupReq) async {
    try {
      final responseData = await sl<DioClient>().post(
        ApiUrls.register,
        data: signupReq.toMap(),
      );
      return Right(responseData);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }

  @override
  Future<Either> signin(SigninModel signinReq) async {
    try {
      final responseData = await sl<DioClient>().post(
        ApiUrls.signin,
        data: signinReq.toMap(),
      );
      return Right(responseData);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }

  @override
  Future<Either> forgotPW(SignupModel signupReq) async {
    try {
      final responseData = await sl<DioClient>().post(
        ApiUrls.forgotPW,
        data: signupReq.toMap(),
      );
      return Right(responseData);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }
}
