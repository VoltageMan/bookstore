import 'package:bookstore.tm/data/local/secured_storage.dart';
import 'package:bookstore.tm/data/remote/dio_client.dart';
import 'package:bookstore.tm/helpers/extentions.dart';
import 'package:bookstore.tm/models/auth/auth_model.dart';
import 'package:bookstore.tm/models/auth/user/user_model.dart';
import 'package:bookstore.tm/repositories/auth/auth_repositori.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo with DioClientMixin {
  @override
  Future<UserModel?> update(UserModel model) async {
    final response = await dio.post(
      endPoint: EndPoints.userUpdate,
      data: model.toJson(),
    );
    if (response.success) {
      final newModel = UserModel.fromJson(response.data[APIKeys.user]);
      return newModel;
    }
    return null;
  }

  @override
  Future<UserModel?> logIn(AuthModel model) async {
    final response = await dio.post(
      endPoint: EndPoints.logIn,
      data: model.toJson(),
    );
    if (response.success) {
      final token = response.data[APIKeys.accsesToken] as String;
      final user = UserModel.fromJson(response.data[APIKeys.user]);
      await LocalStorage.saveToken(token..log(message: 'Tooken'));
      return user;
    }
    return null;
  }

  @override
  Future<UserModel?> register(AuthModel model) async {
    final response = await dio.post(
      endPoint: EndPoints.register,
      data: model.toJson(),
    );
    if (response.success) {
      final token = response.data[APIKeys.accsesToken] as String;
      final user = UserModel.fromJson(response.data[APIKeys.user]);

      await LocalStorage.saveToken((token)..log(message: 'Tokeen'));
      return user;
    }

    return null;
  }

  @override
  Future<bool> logOut() async {
    final response = await dio.post(endPoint: EndPoints.logOut);
    if (response.success) {
      await LocalStorage.deleteToken();
    }
    return response.success;
  }

  @override
  Future<bool> deleteAcc() async {
    final response = await dio.post(endPoint: EndPoints.deleteAcc);
    if (response.success) {
      await LocalStorage.deleteToken();
    }
    return response.success;
  }

  @override
  Future<UserModel?> authMe() async {
    if (LocalStorage.getToken == null) return null;
    final response = await dio.get(endPoint: EndPoints.authMe);
    if (response.success) {
      final user = UserModel.fromJson(response.data[APIKeys.user]);
      return user;
    }
    return null;
  }
}
