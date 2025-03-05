import 'package:dartz/dartz.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';

abstract class AuthRepo {
  Future<bool> checkUser(String email);
  Future<Either> signup(SignupModel signupReq);
  Future<Either> signin(SigninModel signinReq);
  Future<Either> forgotPW(SignupModel signinReq);
}
