import 'package:dio/dio.dart';
import 'package:photo_uploader/data/models/no_token_profile.dart';
import 'package:photo_uploader/data/models/token_model.dart';

import '/data/constants.dart';
import '/data/exception.dart';
import '/data/models/profile_model.dart';

abstract class AuthApi {
  Future<ProfileModel> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<ProfileModel> signIn({
    required String email,
    required String password,
  });

  Future<NoTokenProfileModel> getUser();

  Future<TokenModel> refreshToken({required String refreshToken});
}

class AuthApiImpl implements AuthApi {
  final Dio dio;
  AuthApiImpl({required this.dio});

  @override
  Future<ProfileModel> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    print('${Urls.baseUrl}auth/sign-up');
    final response = await dio.post(
      '${Urls.baseUrl}auth/sign-up',
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password
      },
    );

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      ProfileModel data = ProfileModel.fromJson(response.data);

      return data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfileModel> signIn({
    required String email,
    required String password,
  }) async {
    print('${Urls.baseUrl}auth/sign-in');

    final response = await dio.post(
      '${Urls.baseUrl}auth/sign-in',
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      ProfileModel data = ProfileModel.fromJson(response.data);

      return data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NoTokenProfileModel> getUser() async {
    print('${Urls.baseUrl}users/me');

    final response = await dio.get('${Urls.baseUrl}users/me');

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      NoTokenProfileModel data = NoTokenProfileModel.fromJson(response.data);

      return data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TokenModel> refreshToken({required String refreshToken}) async {
    print('${Urls.baseUrl}users/me');

    final response = await dio.post(
      '${Urls.baseUrl}auth/refresh',
      data: {'refreshToken': refreshToken},
    );

    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      TokenModel data = TokenModel.fromJson(response.data);

      return data;
    } else {
      throw ServerException();
    }
  }
}
