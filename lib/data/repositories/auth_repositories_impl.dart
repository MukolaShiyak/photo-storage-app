import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:photo_uploader/data/models/token_model.dart';
import 'package:photo_uploader/domain/entities/token.dart';

import '/data/failure.dart';
import '/data/exception.dart';
import '/data/datasource/auth_api.dart';
import '/data/models/profile_model.dart';
import '/repositories/auth_repository.dart';
import '/data/models/no_token_profile.dart';
import '/domain/entities/profile_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl({required this.authApi});

  @override
  Future<Either<Failure, Profile>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final ProfileModel result = await authApi.signIn(
        email: email,
        password: password,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (error) {
      final message = error.response?.data['message'] as String;
      return Left(BadRequestFailure(message));
    }
  }

  @override
  Future<Either<Failure, Profile>> getUser() async {
    try {
      final NoTokenProfileModel result = await authApi.getUser();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (error) {
      final message = error.response?.data['message'][0] as String;
      return Left(BadRequestFailure(message));
    }
  }

  @override
  Future<Either<Failure, Profile>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final ProfileModel result = await authApi.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (error) {
      final message = error.response?.data['message'] as String;
      return Left(BadRequestFailure(message));
    }
  }

  @override
  Future<Either<Failure, Token>> refreshToken(
      {required String refreshToken}) async {
    try {
      final TokenModel result = await authApi.refreshToken(
        refreshToken: refreshToken,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on DioException catch (error) {
      final message = error.response?.data['message'][0] as String;
      return Left(BadRequestFailure(message));
    }
  }
}
