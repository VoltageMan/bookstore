import 'dart:async';
import 'package:bookstore.tm/models/auth/auth_model.dart';
import 'package:bookstore.tm/models/auth/user/user_model.dart';

abstract class AuthRepo {
  Future<UserModel?> logIn(AuthModel loginReqModel);
  Future<UserModel?> register(AuthModel loginReqModel);
  Future<bool> logOut();
  Future<bool> deleteAcc();
  Future<UserModel?> update(UserModel user);
  Future<UserModel?> authMe();
}
