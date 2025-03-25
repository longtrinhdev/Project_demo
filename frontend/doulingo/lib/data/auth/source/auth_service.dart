import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/core/constant/api_urls.dart';
import 'package:doulingo/core/constant/app_urls.dart';
import 'package:doulingo/core/network/dio_client.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/service_locators.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  Future<Either> checkEmail(String email);
  Future<Either> signup(SignupModel signupReq);
  Future<Either> signin(SigninModel signinReq);
  Future<Either> googleSignin();
  Future<Either> forgotPW(SignupModel signupReq);
  Future<Either> udCourseId(SignupModel signupReq);
  Future<Either> logout();
}

class AuthServiceImpl extends AuthService {
  @override
  Future<Either> checkEmail(String email) async {
    try {
      final response = await sl<DioClient>().post(ApiUrls.checkUser, data: {
        'email': email,
      });
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }

  @override
  Future<Either> signup(SignupModel signupReq) async {
    try {
      final responseData = await sl<DioClient>().post(
        ApiUrls.register,
        data: signupReq.toMap(),
      );
      return Right(responseData.data);
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
      return Right(responseData.data);
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

  @override
  Future<Either> googleSignin() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile', 'openid'],
        serverClientId: AppUrls.clientId,
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return const Left('User Not Signed! ');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      final responseData = await sl<DioClient>().post(
        ApiUrls.googleSignin,
        data: {
          'idToken': idToken,
        },
      );
      return Right(responseData.data);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }

  @override
  Future<Either> udCourseId(SignupModel signupReq) async {
    try {
      final responseData = await sl<DioClient>().post(
        ApiUrls.udCourseId,
        data: signupReq.toMap(),
      );
      return Right(responseData.data);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }

  @override
  Future<Either> logout() async {
    try {
      final accessToken = await sl<GetDataUseCase>().call(
        params: 'access_token',
      );
      final refreshToken = await sl<GetDataUseCase>().call(
        params: 'refresh_token',
      );

      final responseData = await sl<DioClient>().post(
        ApiUrls.logout,
        options: Options(
          headers: {
            'token': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'refreshToken': refreshToken,
        },
      );
      return Right(responseData.data);
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
  }
}
