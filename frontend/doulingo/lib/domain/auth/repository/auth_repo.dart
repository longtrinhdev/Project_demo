import 'package:dartz/dartz.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';

abstract class AuthRepo {
  Future<Either> checkUser(String email);
  Future<Either> signup(SignupModel signupReq);
  Future<Either> signin(SigninModel signinReq);
  Future<Either> googleSignin();
  Future<Either> forgotPW(SignupModel signinReq);
  Future<Either> upCourseId(SignupModel signupReq);
  Future<Either> logout();
}
